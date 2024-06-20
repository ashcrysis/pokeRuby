class PokemonsController < ApplicationController
  POKEMON_API = "https://pokeapi.co/api/v2/pokemon"
  before_action :set_pokemon, only: [:update, :destroy]
  before_action :authenticate_user!

  def create
   @pokemon = Pokemon.new(pokemon_params)
   if @pokemon.save
     render json: @pokemon, status: :created
   else
     render json: @pokemon.errors, status: :unprocessable_entity
   end
  end

  def search
    name = params[:name]

    if name.blank? || name.is_a?(Integer) || name.match(/\d/)
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


  def list
    render json: Pokemon.all
  end

 def update
   if @pokemon.update(pokemon_params)
     render json: @pokemon
   else
     render json: @pokemon.errors, status: :unprocessable_entity
   end
 end

 def destroy
   @pokemon.destroy
   render json: { message: 'Pokemon was successfully destroyed.' }
 end

 def fetch_all_pokemon_data
   response = HTTParty.get("#{POKEMON_API}?limit=10000")
   if response.code == 200
     render json: JSON.parse(response.body)
   end
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
end
