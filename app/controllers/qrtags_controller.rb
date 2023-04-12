class QrtagsController < ApplicationController

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

    respond_to do |format|
      format.html
    end 
  end

  def claim
    @label = Label.find params[:label_id]
    @qrtag = @label.qrtags.find_by(code: params[:tag]) 
    if @qrtag 
      claim_label(@qrtag.labelnumber)
      redirect_to @label, notice: "Qrlink was successfully created."
    else
      redirect_to @label, notice: "No valid tag."
    end
  end

  #  GET '/:qr/:label/:tag'
  def redirect
    @label = Label.find_by code: params[:label]
    qrtag =  @label.qrtags.find_by code: params[:tag]

    #todo extra test if tagcode is not exists

    if !(qrtag.qrlink)
      claim_label(qrtag.labelnumber)
      qrtag.reload
    end

   to_url = qrtag.to_url

    respond_to do |format|
      format.html { redirect_to to_url, allow_other_host: true }
    end 
  end

  # GET /labels/:id/qrtags 
  def index
    @label = Label.find params[:label_id]
    @qrtags = @label.qrtags.joins(:qrcode).includes(:qrcode).order(:labelnumber, :referencenumber)
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

    def claim_label (labelnumber)
      tags_on_label = @label.qrtags.where(labelnumber: labelnumber)
      latest_links =  Qrlink.latest_qrlinks.where(label_id: @label.id)   
      tags_on_label.each do |tag|   
        link=latest_links.find_by(qrcode_id: tag.qrcode_id)
        tag.update(qrlink_id: link.id) if link
      end

    end

end