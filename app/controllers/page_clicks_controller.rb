class PageClicksController < ApplicationController
  before_action :set_page_click, only: [:show, :edit, :update, :destroy]

  # GET /page_clicks
  # GET /page_clicks.json
  def index
    @page_clicks = PageClick.all
  end

  # GET /page_clicks/1
  # GET /page_clicks/1.json
  def show
  end

  # GET /page_clicks/new
  def new
    @page_click = PageClick.new
  end

  # GET /page_clicks/1/edit
  def edit
  end

  # POST /page_clicks
  # POST /page_clicks.json
  def create
    @page_click = PageClick.new(page_click_params)

    respond_to do |format|
      if @page_click.save
        format.html { redirect_to @page_click, notice: 'Page click was successfully created.' }
        format.json { render :show, status: :created, location: @page_click }
      else
        format.html { render :new }
        format.json { render json: @page_click.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /page_clicks/1
  # PATCH/PUT /page_clicks/1.json
  def update
    respond_to do |format|
      if @page_click.update(page_click_params)
        format.html { redirect_to @page_click, notice: 'Page click was successfully updated.' }
        format.json { render :show, status: :ok, location: @page_click }
      else
        format.html { render :edit }
        format.json { render json: @page_click.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /page_clicks/1
  # DELETE /page_clicks/1.json
  def destroy
    @page_click.destroy
    respond_to do |format|
      format.html { redirect_to page_clicks_url, notice: 'Page click was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page_click
      @page_click = PageClick.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_click_params
      params.require(:page_click).permit(:pv, :uv)
    end
end
