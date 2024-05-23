
class PokemonApi
  def self.to_json
    pokemons = []

    response = HTTParty.get("https://pokeapi.co/api/v2/pokemon/charmander")
    response = JSON.parse(response.body)
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
