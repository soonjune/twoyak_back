class User::WatchSupplementsController < ApplicationController
  before_action :set_watch_supplement, only: [:show, :update, :destroy]

  # GET /watch_supplements
  def index
    @watch_supplements = WatchSupplement.all

    render json: @watch_supplements
  end

  # GET /watch_supplements/1
  def show
    render json: @watch_supplement
  end

  # POST /watch_supplements
  def create
    @watch_supplement = WatchSupplement.new(watch_supplement_params)

    if @watch_supplement.save
      render json: @watch_supplement, status: :created, location: @watch_supplement
    else
      render json: @watch_supplement.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /watch_supplements/1
  def update
    if @watch_supplement.update(watch_supplement_params)
      render json: @watch_supplement
    else
      render json: @watch_supplement.errors, status: :unprocessable_entity
    end
  end

  # DELETE /watch_supplements/1
  def destroy
    @watch_supplement.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_watch_supplement
      @watch_supplement = WatchSupplement.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def watch_supplement_params
      params.fetch(:watch_supplement, {})
    end
end
