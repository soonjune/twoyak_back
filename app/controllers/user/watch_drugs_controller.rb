class User::WatchDrugsController < ApplicationController
  before_action :set_watch_drug, only: [:show, :update, :destroy]

  # GET /watch_drugs
  def index
    @watch_drugs = WatchDrug.all

    render json: @watch_drugs
  end

  # GET /watch_drugs/1
  def show
    render json: @watch_drug
  end

  # POST /watch_drugs
  def create
    @watch_drug = WatchDrug.new(watch_drug_params)

    if @watch_drug.save
      render json: @watch_drug, status: :created, location: @watch_drug
    else
      render json: @watch_drug.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /watch_drugs/1
  def update
    if @watch_drug.update(watch_drug_params)
      render json: @watch_drug
    else
      render json: @watch_drug.errors, status: :unprocessable_entity
    end
  end

  # DELETE /watch_drugs/1
  def destroy
    @watch_drug.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_watch_drug
      @watch_drug = WatchDrug.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def watch_drug_params
      params.fetch(:watch_drug, {})
    end
end
