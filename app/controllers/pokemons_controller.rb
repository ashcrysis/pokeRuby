class PokemonsController < ApplicationController
  POKEMON_API = "https://pokeapi.co/api/v2/pokemon"
  before_action :set_pokemon, only: [:update, :destroy]

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
    render json: fetch_pokemon_data(name)
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

  private
  def fetch_all_pokemon_data
    response = HTTParty.get("#{POKEMON_API}?limit=10000")
    if response.code == 200
      data = JSON.parse(response.body)
    end
  end
  def fetch_pokemon_data(pokemon_name)
    response = HTTParty.get("#{POKEMON_API}/#{pokemon_name}")
    if response.code == 200
      JSON.parse(response.body)
    else
      { error: "Pokémon not found" }
    end
  end

  def set_pokemon
    @pokemon = Pokemon.find(params[:id])
  end

  def pokemon_params
    params.require(:pokemon).permit(:nome, :moves, :tipo, :imagem)
  end
end
