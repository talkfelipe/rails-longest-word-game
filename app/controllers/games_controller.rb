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

    if in_the_grid && response["error"] == "word not found"
      @result = "#{word.capitalize}is in the grid but is not a valid English word"
    elsif !in_the_grid || word != nil
      @result = "Word is not in the grid, Try again!"
    elsif in_the_grid
      @result = "Congratulations! #{word.capitalize} is a valid English word!"
    else
      @result = "#{word.capitalize} is not a valid English word! You Lost!"
    end
  end
end
