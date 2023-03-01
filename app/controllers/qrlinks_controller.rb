class QrlinksController < ApplicationController
  before_action :set_qrlink, only: %i[ show edit update destroy ]

  # GET /qrlinks or /qrlinks.json
  def index
    @qrlinks = Qrlink.all
  end

  # GET /qrlinks/1 or /qrlinks/1.json
  def show
  end

  # GET /qrlinks/new
  def new
    @qrlink = Qrlink.new
  end

  # GET /qrlinks/1/edit
  def edit
  end

  # POST /qrlinks or /qrlinks.json
  def create
    @qrlink = Qrlink.new(qrlink_params)

    respond_to do |format|
      if @qrlink.save
        format.html { redirect_to qrlink_url(@qrlink), notice: "Qrlink was successfully created." }
        format.json { render :show, status: :created, location: @qrlink }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @qrlink.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /qrlinks/1 or /qrlinks/1.json
  def update
    respond_to do |format|
      if @qrlink.update(qrlink_params)
        format.html { redirect_to qrlink_url(@qrlink), notice: "Qrlink was successfully updated." }
        format.json { render :show, status: :ok, location: @qrlink }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @qrlink.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qrlinks/1 or /qrlinks/1.json
  def destroy
    @qrlink.destroy

    respond_to do |format|
      format.html { redirect_to qrlinks_url, notice: "Qrlink was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qrlink
      @qrlink = Qrlink.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def qrlink_params
      params.require(:qrlink).permit(:url, :label_id, :qrcode_id)
    end
end
