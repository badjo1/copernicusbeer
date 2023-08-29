class BatchesController < ProtectedController
  before_action :set_batch, only: %i[ show edit update destroy ]
  before_action :set_breadcrumbs, only: %i[ show  edit]

  # GET /batches or /batches.json
  def index
    @batches = Batch.all.order(serialnumber: :desc)
  end

  # GET /batches/1 or /batches/1.json
  def show
    add_breadcrumb("Batch #{@batch.serialnumber}")
  end

  # GET /batches/new
  def new
    @batch = authorize Batch.new
  end

  # GET /batches/1/edit
  def edit
    add_breadcrumb("Batch #{@batch.serialnumber}", @batch)
  end

  # POST /batches or /batches.json
  def create
    @batch = authorize Batch.new(batch_params)

    respond_to do |format|
      if @batch.save
        format.html { redirect_to batch_url(@batch), notice: "Batch was successfully created." }
        format.json { render :show, status: :created, location: @batch }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /batches/1 or /batches/1.json
  def update
    respond_to do |format|
      if @batch.update(batch_params)
        format.html { redirect_to batch_url(@batch), notice: "Batch was successfully updated." }
        format.json { render :show, status: :ok, location: @batch }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /batches/1 or /batches/1.json
  def destroy
    @batch.destroy

    respond_to do |format|
      format.html { redirect_to batches_url, notice: "Batch was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_batch
      @batch = Batch.find(params[:id])
    end

    def set_breadcrumbs
      # add_breadcrumb("Admin", admin_home_path) if Current.user.admin?
      add_breadcrumb("Batches", batches_path)
    end

    # Only allow a list of trusted parameters through.
    def batch_params
      params.require(:batch).permit(:serialnumber, :description, :liters)
    end

    def authorize batch
      raise NotAuthorizedError unless current_user.admin?
      return batch
    end


end
