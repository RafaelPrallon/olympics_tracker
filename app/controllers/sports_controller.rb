class SportsController < ApplicationController
  before_action :set_sport, except: [:index, :create]

  def index
    @sports = Sport.all
  end
  
  def show
  end

  def create
    @sport = Sport.new(sport_params)
    unless @sport.save
      render json: {message: "Não foi possível criar a modalidade", errors: @sport.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    unless @sport.update(sport_params)
      render json: {message: "Não foi possível alterar a modalidade", errors: @sport.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    @sport.destroy
    head 204
  end

  private

  def set_sport
    @sport = Sport.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: {message: "Não foi possível encontrar modalidade com o id #{params[:id]}" }, status: :not_found
  end

  def sport_params
    params.require(:sport).permit(:name, :victory_rule)
  end
  
end
