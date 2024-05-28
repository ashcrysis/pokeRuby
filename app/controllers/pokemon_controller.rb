class PokemonController < ApplicationController
  POKEMON_API = "https://pokeapi.co/api/v2/pokemon"
  def index
    fetch_pokemon_data(params[:pokemon_name] || 'mankey')
  end

  def show
    fetch_pokemon_data(params[:id])
  end

  private

  def fetch_pokemon_data(pokemon_name)
    response = HTTParty.get("#{POKEMON_API}/#{pokemon_name.downcase}")
    @favorites = Favorite.list
    if response.code == 200
      data = JSON.parse(response.body)
      pokemon_name = data['name']
      type = response['types'][0]['type']['name']
      species_data = fetch_species_data(pokemon_name)
      english_description = find_english_description(species_data)
      type = add_secondary_type(response, type)
      moves = data['moves']
      first_two_moves = select_random_moves(moves)
      image = fetch_image(data)
      pokemon_height = calculate_height(data)
      pokemon_weight = calculate_weight(data)
      stats_hash = calculate_base_stats(response['stats'])

      assign_instance_variables(data, pokemon_name, type, english_description, first_two_moves, image, pokemon_height, pokemon_weight, stats_hash)
    else
      set_error_defaults
    end
  end

  def fetch_species_data(pokemon_name)
    if pokemon_name.include?('-mega') || pokemon_name.include?('-gmax')
      species_call = HTTParty.get("#{POKEMON_API}-species/#{pokemon_name.strip().split('-')[0]}")
    else
      species_call = HTTParty.get("#{POKEMON_API}-species/#{pokemon_name}")
    end

    if species_call.code == 404
      set_error_defaults
    else
      JSON.parse(species_call.body)
    end
  rescue StandardError => e
    set_error_defaults
  end

  def find_english_description(species_data)
    if species_data.nil? || species_data.empty? || species_data.key?('error')
      set_error_defaults
    else
      english_description = species_data['flavor_text_entries'].find { |entry| entry['language']['name'] == 'en' }
      english_description ? english_description['flavor_text'] : "English description not found."
    end
  rescue StandardError => e
    set_error_defaults
  end

  def add_secondary_type(response, type)
    if response['types'].length > 1
      type += ", " + response['types'][1]['type']['name']
    end
    type
  end

  def select_random_moves(moves)
    move_names = moves.map { |move| move['move']['name'] }
    move_names.sample(2).map(&:capitalize).join(", ")
  end

  def fetch_image(data)
    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/#{data['id']}.png"
  end

  def calculate_height(data)
    data['height'].to_f * 10
  end

  def calculate_weight(data)
    data['weight'].to_f / 10
  end

  def calculate_base_stats(base_stats)
    stats_hash = {}
    base_stats.each do |stat|
      stat_name = stat['stat']['name']
      base_stat = stat['base_stat']
      stats_hash[stat_name] = base_stat
    end
    stats_hash
  end

  def assign_instance_variables(data, pokemon_name, type, english_description, first_two_moves, image, pokemon_height, pokemon_weight, stats_hash)
    @pokemon_name = pokemon_name
    @pokemon_type = type
    @flavor_text = english_description
    @pokemon_moves = first_two_moves
    @pokemon_id = data['id']
    @pokemon_image_url = image
    @pokemon_height = "#{pokemon_height}"
    @pokemon_weight = "#{pokemon_weight}"
    @stats = stats_hash
  end

  def set_error_defaults
    default_image_url = 'https://example.com/default_image.png'
    error_message = "Pokemon not found"
    @pokemon_image_url = default_image_url
    @pokemon_name = error_message
    @pokemon_type = ""
    @flavor_text = "Not found."
    @pokemon_height = ''
    @pokemon_weight = ''
    @pokemon_moves = ''
    @pokemon_id = ''
  end
end
