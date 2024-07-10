class PokemonsApiRepository
  POKEMON_API = "https://pokeapi.co/api/v2/pokemon"

  attr_reader :url, :limit

  def initialize(limit = 10000)
    @url = POKEMON_API
    @limit = limit
  end

  def fetch_all_as_json
    response = HTTParty.get("#{url}?limit=#{limit}")
    if response.code == 200
      response.body
    end
  end
end
