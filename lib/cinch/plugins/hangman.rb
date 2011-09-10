module Cinch::Plugins
  class Hangman
    include Cinch::Plugin
    match /hang (.*)/i,          :method => :guess
    match /hang new (.*) (.*)/i, :method => :new_game
    match /hang status/i,        :method => :status
    def new_game(m, channel, answer)
      @game = CinchHangman::Game.new(answer)
      Channel(channel).send(@game.describe)
    end
    def guess(m, guess)
      @game.guess(guess)
      m.reply @game.describe
    end
    def status(m)
      m.reply @game.describe
    end
  end
end
