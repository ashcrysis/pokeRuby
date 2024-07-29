require 'httparty'

namespace :db do
  desc 'Seed Pokémon data from PokéAPI'
  task seed_pokemons: :environment do
    pokemon_api_url = "https://pokeapi.co/api/v2/pokemon"
    species_api_url = "https://pokeapi.co/api/v2/pokemon-species"

    response = HTTParty.get("#{pokemon_api_url}?limit=200")
    pokemons = response.parsed_response['results']

    pokemons.each do |pokemon|
      pokemon_data = HTTParty.get(pokemon['url']).parsed_response
      species_data = HTTParty.get("#{species_api_url}/#{pokemon_data['id']}").parsed_response

      name = pokemon_data['name']
      types = pokemon_data['types'].map { |t| t['type']['name'] }
      image = pokemon_data['sprites']['front_default']
      moves = pokemon_data['moves'].map { |m| m['move']['name'] }
      description = species_data['flavor_text_entries'].find { |entry| entry['language']['name'] == 'en' }['flavor_text']

      Pokemon.create!(
        nome: name,
        tipo: types,
        imagem: image,
        moves: moves
      )
    end

    puts "Seeded #{pokemons.count} Pokémon"
  end
end
