class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def guess(letter)
    raise ArgumentError if letter.nil? || letter.empty? || letter[/[a-zA-Z]+/]  != letter
    if @guesses.upcase.include?(letter.upcase) || @wrong_guesses.upcase.include?(letter.upcase)
      return false
    end
    if @word.upcase.include?(letter.upcase)
      @guesses += letter
    else
      @wrong_guesses += letter
    end
    return true
  end

  def word_with_guesses
    display_word = ''
    for i in 0..(@word.size - 1)
      display_word += '-'
    end
    return display_word if @guesses.empty?
    pattern = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.gsub(/[#{@guesses}]/, '')
    display_word = @word.gsub(/[#{pattern}]/, '-')
    return display_word
  end

  def check_win_or_lose
    return :win if ((test_word = word_with_guesses) == @word)
    return :lose if @wrong_guesses.size >= 7
    return :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
