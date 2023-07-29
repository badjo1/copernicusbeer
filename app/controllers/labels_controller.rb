class LabelsController < ProtectedController
  before_action :set_label, only: %i[ show edit update destroy ]
  before_action :set_breadcrumbs, only: %i[ show  edit]

  # GET /labels or /labels.json
  def index
    @labels = Label.all
  end

  # GET /labels/1 or /labels/1.json
  def show
    @qrlinks = @label.qrlinks.latest_qrlinks.with_qrcode

    add_breadcrumb(@label.batch.name, @label.batch)
    add_breadcrumb(@label.name)
  end

  # GET /labels/new
  def new
    @batch = Batch.find(params[:batch_id])
    @label = @batch.labels.new
  end

  # GET /labels/1/edit 
  def edit
  end

  # POST /labels or /labels.json
  def create
    @batch = Batch.find(params[:batch_id])
    @label = @batch.labels.new(label_params)
    
    respond_to do |format|
      if @label.save
        createTags(@label.number_of_labels)
        format.html { redirect_to label_url(@label), notice: "Label was successfully created." }
        format.json { render :show, status: :created, location: @label }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @label.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /labels/1 or /labels/1.json
  def update
    respond_to do |format|
      if @label.update(label_params)
        format.html { redirect_to label_url(@label), notice: "Label was successfully updated." }
        format.json { render :show, status: :ok, location: @label }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @label.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /labels/1 or /labels/1.json
  def destroy
    batch = @label.batch
    @label.destroy

    respond_to do |format|
      format.html { redirect_to batch_url(batch), notice: "Label was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_label
      @label = Label.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def label_params
      params.require(:label).permit(:code,:description, :number_of_labels)
    end

    def createTags (n)    
      qrcodes = Qrcode.all.order(:referencenumber)
      n.times { |i| 
        qrcodes.each do |qrcode|    
          new_tag = @label.qrtags.new(qrcode: qrcode, labelnumber: i)
          new_tag.generate_token  
          new_tag.save!
        end  
      }   
    end

    def set_breadcrumbs
      add_breadcrumb("Batches", batches_path)
    end

end
