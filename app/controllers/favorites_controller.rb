class FavoritesController < ApplicationController
  def create
    pokemon_name = params[:name]
    existing_favorite = Favorite.find_by(name: pokemon_name)

    if existing_favorite
      existing_favorite.destroy
      flash[:notice] = 'pokemon removed from favorites!'
    else
      pokemon_data = fetch_pokemon_data(pokemon_name)
      if pokemon_data
        favorite = Favorite.new(pokemon_id: pokemon_data[:id], name: pokemon_data[:name], image_url: pokemon_data[:image_url])
        if favorite.save
          flash[:notice] = 'Pokemon added to favorites!'
        else
          flash[:alert] = 'unable to add to favorites.'
        end
      else
        flash[:alert] = 'unable to fetch Pokemon data.'
      end
    end

    redirect_back(fallback_location: root_path)
  end
  def clear
    Favorite.delete_all
    flash[:notice] = 'all favorites have been cleared.'
    redirect_back(fallback_location: favorites_path)
  end

  def destroy
    favorite = Favorite.find(params[:id])
    if favorite.destroy
      flash[:notice] = 'pokemon removed from favorites!'
    else
      flash[:alert] = 'Unable to remove from favorites.'
    end
    redirect_back(fallback_location: root_path)
  end
  private

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
end
