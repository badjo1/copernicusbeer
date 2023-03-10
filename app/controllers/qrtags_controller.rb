class QrtagsController < ApplicationController

  # GET /labels/:id/qrtags 
  def show
    @label = Label.find_by code: params[:label]
    @qrtag =  @label.qrtags.find_by code: params[:tag]
   
    respond_to do |format|
      format.html
    end 
  end

  # GET /labels/:id/qrtags 
  def index
    @label = Label.find params[:label_id]
    @qrtags = @label.qrtags.includes(:qrcode)
    csv_name = "qrtags-#{@label.batch.serialnumber}-#{@label.code}-#{Date.today}.csv"   
    respond_to do |format|
      # format.html
      format.csv { send_data @qrtags.to_csv, filename: csv_name }
    end 
  end

end