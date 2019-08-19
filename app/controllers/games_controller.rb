require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @letters = []
    10.times do
      @letters << alphabet.sample
    end
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters]
    @grid = grid?(@word, @letters)
    @english = english?(@word)
  end

  def grid?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = open(url).read
    json = JSON.parse(response, symbolize_names: true)
    json[:found]
  end


end
