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

  # GET /labels/:id/qrtags 
  def index
    custom_order = [4, 3, 2, 1, 8, 7, 6, 5, 4, 12, 11, 10, 9, 16, 15, 14, 13, 9, 8, 20, 19, 18, 17, 16, 24, 23, 22, 21]
    order_case = custom_order.each_with_index.map { |num, index| "WHEN #{num} THEN #{index}" }.join(' ')

    @label = Label.find params[:label_id]
    @qrtags = @label.qrtags.joins(:qrcode).includes(:qrcode).order(:labelnumber).order(Arel.sql("CASE referencenumber #{order_case} END"))

    csv_name = "qrtags-#{@label.batch.serialnumber}-#{@label.code}-#{Date.today}.csv"   
    respond_to do |format|
      # format.html
      format.csv { send_data @qrtags.to_csv, filename: csv_name }
    end 
  end

  private

    def qrtags_params
      params.require(:qrtag).permit(:q)
    end

end