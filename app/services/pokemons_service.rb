class PokemonsService
  POKEMON_API = "https://pokeapi.co/api/v2/pokemon"
  API = false 

  def self.fetch_pokemon
    if API 
      fetch_all_pokemon_data_from_url
    else 
      fetch_all_pokemon_data_from_db
    end
  end

  private

  def self.fetch_all_pokemon_data_from_url
    response = HTTParty.get("#{POKEMON_API}?limit=10000")
    if response.code == 200
      JSON.parse(response.body)
    end
  end 

  def self.fetch_all_pokemon_data_from_db
    pokemons = Pokemon.all
    count = pokemons.count
    pokemon_data = pokemons.map do |pokemon|
      {
        "name" => pokemon.nome,
        "url" => pokemon.imagem
      }
    end
    {
      "count" => count,
      "next" => nil,
      "previous" => nil,
      "results" => pokemon_data
    }
  end 
end
