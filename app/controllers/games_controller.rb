require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabet = 'abcdefghijklmnopqrstuvxwyz'
    @letters = alphabet.split('').sample(10).shuffle!
  end

  def score
    @word = params[:word]
    if letter_in_grid? && english_word?
      @result = "Acertou, mizeravi"
    else
      @result = "Errrrou"
    end
  end

  def letter_in_grid?
    array = @word.chars
    booleans = []
    array.each do |letter|
      booleans << params[:letters].include?(letter)
    end
    booleans.select { |boolean| boolean == true }.size == booleans.size
  end

  def english_word?
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    dictionary = URI.open(url)
    word = JSON.parse(dictionary.read)
    word["found"]
  end

end
