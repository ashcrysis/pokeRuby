
function start_page(){
const searchInput = document.getElementById('searchInput');
const resultsContainer = document.getElementById('resultsContainer');
let allPokemonData = []; 
}

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
        name.textContent = capitalizeFirstLetter(pokemon.name);
        
        const img = document.createElement('img');
        const pokemonId = pokemon.url.split('/').slice(-2, -1)[0];
        img.src = `https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemonId}.png`;
        img.alt = pokemon.name;
        
        const anchor = document.createElement('a');
        anchor.href = `/v1/pokemon?pokemon_name=${pokemon.name.toLowerCase()}`;
        anchor.appendChild(card); 
        anchor.style="text-decoration: none;";
        const pokeballIcon = document.createElement('div');
        pokeballIcon.classList.add('pokeball-icon');
        card.appendChild(pokeballIcon);
        card.appendChild(name);
        card.appendChild(img);
        
        anchor.appendChild(card);
        resultsContainer.appendChild(anchor); 
    });
}


function handleSearch() {
    const query = searchInput.value;
    console.log(searchInput);
    const filteredPokemon = filterPokemon(query);
    displayResults(filteredPokemon);
}

searchInput.addEventListener('input', handleSearch);
fetchAllPokemon();
window.addEventListener('load', start_page);

const pokeballIcon = document.createElement('div');
pokeballIcon.classList.add('pokeball-icon');

document.addEventListener("DOMContentLoaded", function() {
  const favoriteCards = document.querySelectorAll('.card');
  favoriteCards.forEach(function(card) {
    const clonedPokeballIcon = pokeballIcon.cloneNode(true);
    card.insertBefore(clonedPokeballIcon, card.firstChild);
  });
});