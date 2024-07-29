class PokemonsApiRepository
  POKEMON_API = "https://pokeapi.co/api/v2/pokemon"
  POKEMON_SPECIES_API = "https://pokeapi.co/api/v2/pokemon-species"

  attr_reader :url, :limit

  def initialize(limit = 10000)
    @url = POKEMON_API
    @species_url = POKEMON_SPECIES_API
    @limit = limit
  end

  def fetch_all_as_json
    response = HTTParty.get("#{url}?limit=#{limit}")
    if response.code == 200
      response.body
    end
  end

  def fetch_species_data(name)
    response = HTTParty.get("#{@species_url}/#{name}")
    if response.code == 200
      JSON.parse(response.body)
    else
      { error: "Pokémon not found" }
    end
  end
end
