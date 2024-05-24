class PokemonController < ApplicationController
  def index
    pokemon_name = params[:pokemon_name] || 'bulbasaur'
    response = HTTParty.get("https://pokeapi.co/api/v2/pokemon/#{pokemon_name.downcase}")

    search_list = HTTParty.get("https://pokeapi.co/api/v2/pokemon?limit=100000")
    search_list = JSON.parse(search_list.body) # storing pokemons in order to have the full list to be able to filter and show on the screen when the user is typing

    if response.code == 200
      data = JSON.parse(response.body)
      sprite_url = data['sprites']['front_default']
      pokemon_name = data['name']
      type = response['types'][0]['type']['name']
      if pokemon_name.include?('mega') || pokemon_name.include?('gmax')
        species_call = HTTParty.get("https://pokeapi.co/api/v2/pokemon-species/#{pokemon_name.strip().split('-')[0]}")
        species_data = JSON.parse(species_call.body)
      else
        species_call = HTTParty.get("https://pokeapi.co/api/v2/pokemon-species/#{pokemon_name}")
        species_data = JSON.parse(species_call.body)
      end

      english_description = species_data['flavor_text_entries'].find do |entry|
        entry['language']['name'] == 'en'
      end

      if english_description
        description = english_description['flavor_text']
      else
        description = "English description not found."
      end

      if response['types'].length > 1
        type += ", " +response['types'][1]['type']['name']
      end

      if pokemon_name.include?('mega') || pokemon_name.include?('gmax')
      image = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/#{data['id']}.png"
      else
        image = "https://img.pokemondb.net/artwork/#{pokemon_name}.jpg"
      end
      @pokemon_image_url = image
      @pokemon_name = pokemon_name
      @pokemon_type = type
      @flavor_text = description
    else
      default_image_url = 'https://example.com/default_image.png'
      error_message = "Pokemon not found"
      @pokemon_image_url = default_image_url
      @pokemon_name = error_message
      @pokemon_type = ""
      @flavor_text = ""
    end
  end
end
