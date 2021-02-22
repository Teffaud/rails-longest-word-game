class GamesController < ApplicationController
  def new
    chars = Array('A'..'Z')
    @letters = []
    10.times do
      @letters << chars.sample
    end
  end

  def score
    @words = params[:word]
    @letters = params[:token].split(",")
    @result = run_game(@word, @letters)
  end

  private
  def in_dictionary?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = open(url).read # IS A STRING
    word_parsed = JSON.parse(word_serialized) # IS A HASH
    return word_parsed["found"]
  end

  def run_game(attempt, grid)
    score = 0
    bool = grid_match(attempt, grid)
    if bool == true && in_dictionary?(attempt)
      message = "Well done!"
      score = attempt.length * 10
    end

    message = 'Not in the grid' if bool == false
    message = 'Not an english word' if in_dictionary?(attempt) == false
    { score: score, message: message }
  end

  def grid_match(attempt, grid)
    attempt.split('').all? do |letter|
      attempt.count(letter) <= grid.count(letter.upcase)
    end
  end
end
