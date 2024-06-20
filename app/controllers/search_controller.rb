class SearchController < ApplicationController
  def pokelist
    @favorites = Favorite.all
  end
end
