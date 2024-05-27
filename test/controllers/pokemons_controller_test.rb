require "test_helper"

class PokemonsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pokemons_index_url
    assert_response :success
  end

  test "should get show" do
    get pokemons_show_url
    assert_response :success
  end

  test "should get new" do
    get pokemons_new_url
    assert_response :success
  end

  test "should get edit" do
    get pokemons_edit_url
    assert_response :success
  end

  test "should get create" do
    get pokemons_create_url
    assert_response :success
  end

  test "should get update" do
    get pokemons_update_url
    assert_response :success
  end

  test "should get destroy" do
    get pokemons_destroy_url
    assert_response :success
  end
end
