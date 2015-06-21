class TheoriesController < ApplicationController
  before_action :set_theory, only: [:show, :edit, :update, :destroy]
 # before_filter :authenticate_user! 
authorize_resource
  # GET /theories
  # GET /theories.json
  def index
    @theories = Theory.all.order('created_at DESC').page(params[:page]).per(5)

      
    if params[:search]
      @theories = Theory.search(params[:search]).order("created_at DESC").page(params[:page]).per(5)

    else
      @theories = Theory.order("created_at DESC").page(params[:page]).per(5)

    end
  end

  def fromlevel
    @level = Level.find(params[:id])
    @theories = Theory.where(level_id:  @level.id).page(params[:page]).per(5)
  end

  # GET /theories/1
  # GET /theories/1.json
  def show
    @surveys = Survey::Survey.where(theory_id: @theory.id)
  
  end

  # GET /theories/new
  def new
    @theory = current_user.theories.build
  end

  # GET /theories/1/edit
  def edit
  end

  # POST /theories
  # POST /theories.json
  def create
    @theory = current_user.theories.build(theory_params)

    respond_to do |format|
      if @theory.save
        format.html { redirect_to @theory, notice: 'Theory was successfully created.' }
        format.json { render :show, status: :created, location: @theory }
      else
        format.html { render :new }
        format.json { render json: @theory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /theories/1
  # PATCH/PUT /theories/1.json
  def update
    respond_to do |format|
      if @theory.update(theory_params)
        format.html { redirect_to @theory, notice: 'Theory was successfully updated.' }
        format.json { render :show, status: :ok, location: @theory }
      else
        format.html { render :edit }
        format.json { render json: @theory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /theories/1
  # DELETE /theories/1.json
  def destroy
    @theory.destroy
    respond_to do |format|
      format.html { redirect_to theories_url, notice: 'Theory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_theory
      @theory = Theory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def theory_params
      params.require(:theory).permit(:title, :body, :image, :level_id, :survey_id, :user_id)
    end
end
