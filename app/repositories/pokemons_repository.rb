class PokemonsRepository
  require_relative "../presenters/pokemons_presenter"
  POKEMON_SPECIES_API = "https://pokeapi.co/api/v2/pokemon-species"
  def initialize(model = Pokemon)
    @model = model
    @species_url = POKEMON_SPECIES_API
    @presenter = ::PokemonsPresenter
  end

  def fetch_all_as_json
    pokemons = all
    {
      count: pokemons.count,
      next: nil,
      previous: nil,
      results: pokemons.map { |pokemon| @presenter.new(pokemon).as_json },
    }.to_json
  end

  def all
    @model.all
  end

  def find_by_name(name)
    @model.find_by(nome: name)
  end

  def find_by_id(id)
    @model.find(id)
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
