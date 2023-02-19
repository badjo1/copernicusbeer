class QrcodesController < ApplicationController
  before_action :set_qrcode, only: %i[ edit update destroy ]

  # GET /qrcodes or /qrcodes.json
  def index
    @qrcodes = Qrcode.all.order(:referencenumber)
  end

  # GET /qrcodes/1 or /qrcodes/1.json
  def show
      # @qrcode = Qrcode.find_by(referencenumber: params[:id])
      @qrcode = Qrcode.find_by referencenumber: params[:id]
  end

  # GET /qrcodes/new
  def new
    @qrcode = Qrcode.new
  end

  # GET /qrcodes/1/edit
  def edit
  end

  # POST /qrcodes or /qrcodes.json
  def create
    @qrcode = Qrcode.new(qrcode_params)

    respond_to do |format|
      if @qrcode.save
        format.html { redirect_to qrcodes_url, notice: "qrcode was successfully created." }
        format.json { render :show, status: :created, location: @qrcode }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @qrcode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /qrcodes/1 or /qrcodes/1.json
  def update
    respond_to do |format|
      if @qrcode.update(qrcode_params)
        format.html { redirect_to qrcodes_url, notice: "qrcode was successfully updated." }
        format.json { render :show, status: :ok, location: @qrcode }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @qrcode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qrcodes/1 or /qrcodes/1.json
  def destroy
    @qrcode.destroy

    respond_to do |format|
      format.html { redirect_to qrcodes_url, notice: "qrcode was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qrcode
      @qrcode = Qrcode.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def qrcode_params
      params.require(:qrcode).permit(:referencenumber, :baseurl)
    end
end
