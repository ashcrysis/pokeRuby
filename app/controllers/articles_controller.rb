class ArticlesController < ApplicationController
  def index
    pokemon_name = params[:pokemon_name] || 'bulbasaur'
    response = HTTParty.get("https://pokeapi.co/api/v2/pokemon/#{pokemon_name.downcase}")

    search_list = HTTParty.get("https://pokeapi.co/api/v2/pokemon?limit=100000")
    search_list = JSON.parse(search_list.body) # storing pokemons in order to have the full list to be able to filter and show on the screen when the user is typing

    if response.code == 200 # Check if the request was successful
      data = JSON.parse(response.body)
      sprite_url = data['sprites']['front_default']
      pokemon_name = data['name']
      type = response['types'][0]['type']['name']
      description = HTTParty.get("https://pokeapi.co/api/v2/pokemon-species/#{response['id']}")['flavor_text_entries'][0]['flavor_text']

      if response['types'].length > 1
        type += ", " +response['types'][1]['type']['name']
      end

      image = "https://img.pokemondb.net/artwork/#{pokemon_name}.jpg"
      @pokemon_image_url = image
      @pokemon_name = pokemon_name
      @pokemon_type = type
      @flavor_text = description
    else
      default_image_url = 'https://example.com/default_image.png'
      error_message = "Pokemon not found"
      @pokemon_image = default_image_url
      @pokemon_name = error_message
      return default_image_url, error_message
    end
  end
end
