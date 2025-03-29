class QrtagsController < ProtectedController

  

  # GET /labels/:label_id/search(/:q)
  def search
    @label = Label.find params[:label_id]
    if params[:q] 
      @qrtag = @label.find_tag(params[:q]) 
    else
      params[:q] = @label.qrtags.first.code
    end

    if @qrtag 
      @qrtags = @label.qrtags.with_qrcode.where(labelnumber: @qrtag.labelnumber)
    end

    add_breadcrumb("Home", root_path)
    add_breadcrumb(@label.batch.name, @label.batch)
    add_breadcrumb("search")
  
  end

  def claim
    @label = Label.find params[:label_id]
    @qrtag = @label.qrtags.find_by(code: params[:tag]) 
    if @qrtag 
      @label.claim_label(@qrtag.labelnumber)
      redirect_to @label, notice: "Qrlink was successfully created."
    else
      redirect_to @label, notice: "No valid tag."
    end
  end

  def unclaim_all
    @label = Label.find params[:label_id]
    @label.qrtags.where.not(qrlink_id: nil).update_all(qrlink_id: nil)
    redirect_to @label, notice: "All tags are claimable."
  end

  def new_qrlink
    @qrtag = Qrtag.find(params[:qrtag_id])
    @qrlink = @qrtag.label.qrlinks.new
  end

  def create_qrlink
    @qrtag = Qrtag.find(params[:qrtag_id])
    @qrlink = Qrlink.new(qrcode_id: @qrtag.qrcode_id, label_id: @qrtag.label_id, url: qrlink_params[:url], valid_until: Time.zone.now)

    begin
      ActiveRecord::Base.transaction do
        @qrlink.save!
        @qrtag.update!(qrlink_id: @qrlink.id)
      end
      redirect_to label_search_path(@qrtag.label_id, q: @qrtag.code), notice: "Link aangemaakt voor tag '#{@qrtag.code}'"
    rescue ActiveRecord::RecordInvalid => e
      render :new_qrlink
    end
  end

  # GET /labels/:id/qrtags 
  # def index
  #   custom_order = [4, 3, 2, 1, 8, 7, 6, 5, 4, 12, 11, 10, 9, 16, 15, 14, 13, 9, 8, 20, 19, 18, 17, 16, 24, 23, 22, 21]
  #   order_case = custom_order.each_with_index.map { |num, index| "WHEN #{num} THEN #{index}" }.join(' ')

  #   @label = Label.find params[:label_id]
  #   @qrtags = @label.qrtags.joins(:qrcode).includes(:qrcode).order(:labelnumber).order(Arel.sql("CASE referencenumber #{order_case} END"))

  #   csv_name = "qrtags-#{@label.batch.serialnumber}-#{@label.code}-#{Date.today}.csv"   
  #   respond_to do |format|
  #     # format.html
  #     format.csv { send_data @qrtags.to_csv, filename: csv_name }
  #   end 
  # end

  def index
    @label = Label.find_by(id: params[:label_id])
    unless @label
      render plain: "Label not found", status: :not_found and return
    end

    @qrtags = @label.qrtags
                    .joins(:qrcode)
                    .order(:labelnumber, :referencenumber)

    # Groepeer de qrtags per labelnummer
    @grouped_qrtags = @qrtags.group_by(&:labelnumber)

    # Bestandsnaam maken
    csv_name = "qrtags-#{@label.batch.serialnumber}-#{@label.code}-#{Date.today.iso8601}.csv"

    # Reageren op CSV-aanvragen
    respond_to do |format|
      format.html # Renders a view (optional, for browser access)
      format.csv { send_data generate_csv(@grouped_qrtags), filename: csv_name }
    end


  end


  private

    def qrtags_params
      params.require(:qrtag).permit(:q)
    end

    def qrlink_params
      params.require(:qrlink).permit(:url)
    end

    # CSV te genereren
    def generate_csv(grouped_qrtags, separator = ";")
      CSV.generate(headers: true, col_sep: separator) do |csv|
        all_referencenumbers = grouped_qrtags.values.flatten.map(&:referencenumber).uniq.sort
        # Voeg de headers toe
        csv << all_referencenumbers.map { |i| "tagurl#{i}" }
        grouped_qrtags.each do |labelnumber, tags|
          csv << tags.map { |tag| tag.tagurl }
        end
      end
    end

end