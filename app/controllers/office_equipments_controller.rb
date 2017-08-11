class OfficeEquipmentsController < ApplicationController
  before_action :set_office_equipment, only: [:show, :edit, :update, :destroy]

  # GET /office_equipments
  # GET /office_equipments.json
  def index
    @office_equipments = OfficeEquipment.all
  end

  # GET /office_equipments/1
  # GET /office_equipments/1.json
  def show
  end

  # GET /office_equipments/new
  def new
    @office_equipment = OfficeEquipment.new
  end

  # GET /office_equipments/1/edit
  def edit
  end

  # POST /office_equipments
  # POST /office_equipments.json
  def create
    @office_equipment = OfficeEquipment.new(office_equipment_params)

    respond_to do |format|
      if @office_equipment.save
        format.html { redirect_to @office_equipment, notice: 'Office equipment was successfully created.' }
        format.json { render :show, status: :created, location: @office_equipment }
      else
        format.html { render :new }
        format.json { render json: @office_equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /office_equipments/1
  # PATCH/PUT /office_equipments/1.json
  def update
    respond_to do |format|
      if @office_equipment.update(office_equipment_params)
        format.html { redirect_to @office_equipment, notice: 'Office equipment was successfully updated.' }
        format.json { render :show, status: :ok, location: @office_equipment }
      else
        format.html { render :edit }
        format.json { render json: @office_equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /office_equipments/1
  # DELETE /office_equipments/1.json
  def destroy
    @office_equipment.destroy
    respond_to do |format|
      format.html { redirect_to office_equipments_url, notice: 'Office equipment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_office_equipment
      @office_equipment = OfficeEquipment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def office_equipment_params
      params.require(:office_equipment).permit(:title, :desc, :slugged, :owner_id, :price)
    end
end
