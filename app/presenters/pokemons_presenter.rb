class PokemonsPresenter
    def initialize(pokemon)
      @pokemon = pokemon
    end
  
    def as_json
      {
        name: @pokemon.nome,
        url: @pokemon.imagem
      }
    end
  end