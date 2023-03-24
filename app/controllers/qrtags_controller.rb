class QrtagsController < ApplicationController

  # GET /labels/:id/qrtags 
  def show
    label = Label.find_by code: params[:label]
    qrtag =  label.qrtags.find_by code: params[:tag]
   
    respond_to do |format|
      format.html { redirect_to qrtag.qrcode.baseurl, allow_other_host: true }
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

end