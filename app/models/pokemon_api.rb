
class PokemonApi
  def self.to_json
    pokemons = []

    response = HTTParty.get("https://pokeapi.co/api/v2/pokemon/charmander")
    response = JSON.parse(response.body)
  end

  def self.get_image_url(pokemon)
    response = HTTParty.get("https://pokeapi.co/api/v2/pokemon/#{pokemon.downcase}")

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
      return image, pokemon_name,type,description
    else
      default_image_url = 'https://example.com/default_image.png'
      error_message = "Pokemon not found"
      return default_image_url, error_message
    end
  end
end
=begin
will be useful later
https://stackoverflow.com/questions/69138854/filter-multiple-pokemons-of-pokeapi

To get a list of all possible pokemon names, you can make a request to https://pokeapi.co/api/v2/pokemon?limit=100000 (where 100000 is larger than the number of pokemon that exist. There appear to be only 1118 pokemon as of now.)

The result looks like this:

[
  {
    name:"bulbasaur",
    url:"https://pokeapi.co/api/v2/pokemon/1/"
  },
  {
    name:"ivysaur",
    url:"https://pokeapi.co/api/v2/pokemon/2/"
  },
  {
    name:"venusaur",
    url:"https://pokeapi.co/api/v2/pokemon/3/"
  },
  ...
]


=end
