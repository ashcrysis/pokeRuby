class PokemonsService

  def initialize(repository = PokemonsRepository.new)
    @repository = repository
  end


  def all_pokemons
    JSON.parse(@repository.fetch_all_as_json)
  end

  def pokemon_species(name)
    @repository.fetch_species_data(name)
  end
end
