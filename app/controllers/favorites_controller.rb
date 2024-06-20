class FavoritesController < ApplicationController
  before_action :set_favorite, only: [:update, :destroy]
  before_action :authenticate_user!

  def create
    favorite = Favorite.new(favorite_params)
    if favorite.save
      render json: favorite, status: :created
    else
      render json: { error: favorite.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @favorite.update(favorite_params)
      render json: @favorite, status: :ok
    else
      render json: { error: @favorite.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @favorite.destroy
      render json: { message: 'Favorite successfully deleted' }, status: :ok
    else
      render json: { error: 'Unable to delete favorite' }, status: :unprocessable_entity
    end
  end
  def list
    favorites = Favorite.all
    render json: favorites, status: :ok
  end
  def get_user_favorites
    user_favorites = Favorite.where(user_id: params[:user_id])
    render json: user_favorites, status: :ok
  end
  def fetch_pokemon_data(pokemon_name)
    response = HTTParty.get("https://pokeapi.co/api/v2/pokemon/#{pokemon_name.downcase}")
    if response.code == 200
      data = JSON.parse(response.body)
      {
        id: data['id'],
        name: data['name'],
        image_url: data['sprites']['front_default']
      }
    else
      { id: data['id'], name: pokemon_name, image_url: "https://example.com/default_image.png" }
    end
  end
  def set_favorite
    @favorite = Favorite.find(params[:id])
  end

  def favorite_params
    params.require(:favorite).permit(:pokemon_id,:name,:image_url, :user_id)
  end
end
