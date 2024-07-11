class PokemonsController < ApplicationController
  POKEMON_API = "https://pokeapi.co/api/v2/pokemon"
  before_action :set_pokemon, only: [:update, :destroy]
  before_action :authenticate_user!
  cattr_accessor :use_second_api
  self.use_second_api = true

  def search
    name = params[:name]

    name = name.to_s

    if name.blank? || name.match(/\d/)
      render json: { error: "Invalid Pokémon name" }, status: :bad_request
      return
    end

    result = fetch_pokemon_species_data(name)

    if result.key?("error")
      render json: result, status: :bad_request
    else
      render json: result
    end
  end

  def fetch_all_pokemon_data
    response = pokemons_service.all_pokemons
    render json: response
  end

  def species
    name = params[:name]
    data = fetch_pokemon_species_data(name)
    if data[:error]
      render json: { error: data[:error] }, status: :not_found
    else
      description = find_english_description(data)
      render json: { description: description }
    end
  end

  def toggle_api
    self.class.use_second_api = !self.class.use_second_api
    render json: { message: "API toggled to #{self.class.use_second_api}" }
  end

  private

  def fetch_pokemon_data(pokemon_name)
    response = HTTParty.get("#{POKEMON_API}/#{pokemon_name}")
    if response.code == 200
      JSON.parse(response.body)
    else
      { error: "Pokémon not found" }
    end
  end

  def fetch_pokemon_species_data(pokemon_name)
    response = HTTParty.get("#{POKEMON_API}-species/#{pokemon_name}")
    if response.code == 200
      JSON.parse(response.body)
    else
      { error: "Pokémon not found" }
    end
  end

  def find_english_description(data)
    entry = data['flavor_text_entries'].find { |entry| entry['language']['name'] == 'en' }
    if entry
      entry['flavor_text'].gsub("\f", " ")
    else
      "Description not found"
    end
  end

  def set_pokemon
    @pokemon = Pokemon.find(params[:id])
  end

  def pokemon_params
    params.require(:pokemon).permit(:nome, :tipo, :imagem, moves: [])
  end

  def pokemons_service
    if self.class.use_second_api
      PokemonsService.new(PokemonsApiRepository.new)
    else
      PokemonsService.new(PokemonsRepository.new)
    end
  end
end
