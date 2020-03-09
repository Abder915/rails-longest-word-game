require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabet = ("a".."z").to_a
    letters_lowercase = alphabet.sample(10)
    @letters = letters_lowercase.map!(&:upcase)
  end

  def score
    # raise
    answer = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)

    answer_a = answer.split("").map!(&:upcase)
    letters_a = params[:letters].split
    @result = answer_a
    answer_a.each do |a|
      if !letters_a.include?(a)
        return @result = "Sorry!! the word doesn't use the letters proposed"
      end
    end

    if user['found'] == true
      @result = "Congratulations!! #{answer} is a valid word"
    else
      @result = "Sorry!! #{answer} is not a valid word"
    end
   end
end
