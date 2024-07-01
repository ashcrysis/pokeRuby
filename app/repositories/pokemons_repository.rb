class PokemonsRepository
  require_relative "../presenters/pokemons_presenter"

  def initialize(model = Pokemon)
    @model = model
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
end
