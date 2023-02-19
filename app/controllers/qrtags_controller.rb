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
   
    respond_to do |format|
      format.html
      format.csv { send_data @qrtags.to_csv, filename: "qrtags-#{Date.today}.csv" }
    end 
  end

end