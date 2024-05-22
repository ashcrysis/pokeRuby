
class PokemonApi
  def self.to_json
    pokemons = []

    response = HTTParty.get("https://pokeapi.co/api/v2/pokemon/charmander")
    response = JSON.parse(response.body)
  end

  def self.get_image_url(pokemon)
    response = HTTParty.get("https://pokeapi.co/api/v2/pokemon/#{pokemon.downcase}")
    if response.code == 200 # Check if the request was successful
      data = JSON.parse(response.body)
      image_url = data['sprites']['front_default']
      pokemon_name = data['name']
      type = response['types'][0]['type']['name']
      description = HTTParty.get("https://pokeapi.co/api/v2/pokemon-species/#{response['id']}")['flavor_text_entries'][0]['flavor_text']
      if response['types'].length > 1
        type += ", " +response['types'][1]['type']['name']
      end
      return image_url, pokemon_name,type,description
    else
      # If the request was not successful, return a default image URL and an error message
      default_image_url = 'https://example.com/default_image.png'
      error_message = "Pokemon not found"
      return default_image_url, error_message
    end
  end
end
