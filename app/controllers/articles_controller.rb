class ArticlesController < ApplicationController
  def index
    pokemon_name = params[:pokemon_name] || 'bulbasaur'
    @pokemon_image_url,@pokemon_name,@pokemon_type,@flavor_text = PokemonApi.get_image_url(pokemon_name)
  end
end
