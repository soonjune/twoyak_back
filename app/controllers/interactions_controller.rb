class InteractionsController < ApplicationController
  before_action :set_interaction, only: [:show, :update, :destroy]

  # GET /interactions
  def index
    @interactions = Interaction.all

    render json: @interactions
  end

  # GET /interactions/1
  def show
    render json: @interaction
  end

  # POST /interactions
  def create
    @interaction = Interaction.new(interaction_params)

    if @interaction.save
      render json: @interaction, status: :created, location: @interaction
    else
      render json: @interaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /interactions/1
  def update
    if @interaction.update(interaction_params)
      render json: @interaction
    else
      render json: @interaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /interactions/1
  def destroy
    @interaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interaction
      @interaction = Interaction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def interaction_params
      params.require(:interaction).permit(:interaction_type, :first_ingr, :second_ingr, :review, :note, :more_info)
    end
end
