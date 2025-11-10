require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    alphabet_letters = ("a".."z").to_a
    @letters = Array.new(10) { alphabet_letters.sample }

  end

  def score
    word = params[:word]
    letters = params[:letters]
    in_the_grid = word.chars.all? { |char| letters.count(char) >= word.count(char) }

    url = "https://dictionary.lewagon.com/#{word}"
    uri = URI.parse(url)
    response = JSON.parse(URI.parse(uri).read)

    if in_the_grid && !response["found"]
      @result = "In the grid but not a word"
    elsif in_the_grid
      @result = "You Won"
    else
      @result = "You Lost"
    end
  end
end
