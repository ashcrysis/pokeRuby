const searchInput = document.getElementById('searchInput');
const resultsContainer = document.getElementById('resultsContainer');

let allPokemonData = []; 

async function fetchAllPokemon() {
    try {
        const response = await fetch('https://pokeapi.co/api/v2/pokemon?limit=10000');
        if (!response.ok) {
            throw new Error('Failed to fetch Pokémon data');
        }
        const data = await response.json();
        allPokemonData = data.results;
        handleSearch();
    } catch (error) {
        console.error(error);
    }
}

function filterPokemon(query) {
    return allPokemonData.filter(pokemon => {
        return pokemon.name.startsWith(query.toLowerCase().trim()) || pokemon.url.endsWith(`/${query}/`);
    });
}

function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

function displayResults(pokemonList) {
    resultsContainer.innerHTML = ''; 
    pokemonList.forEach(pokemon => {
        const card = document.createElement('div');
        card.classList.add('card');

        const name = document.createElement('h2');
        name.textContent = pokemon.name;
        name.textContent = capitalizeFirstLetter(name.textContent);
        
        const img = document.createElement('img');
        const pokemonId = pokemon.url.split('/').slice(-2, -1)[0];
        img.src = `https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemonId}.png`;
        img.alt = pokemon.name;

        card.appendChild(name);
        card.appendChild(img);
        resultsContainer.appendChild(card);
    });
}

function handleSearch() {
    const query = searchInput.value;
    const filteredPokemon = filterPokemon(query);
    displayResults(filteredPokemon);
}

searchInput.addEventListener('input', handleSearch);

//receber os dados dos pokemons quando a pagina carregar
window.addEventListener('load', fetchAllPokemon);
