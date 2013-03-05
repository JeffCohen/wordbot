class Game

  attr_accessor :puzzle
  attr_accessor :phrase

  def initialize(puzzle)
    @puzzle = puzzle
    @phrase = ""
    @position = 0
  end
  def self.run(puzzle, code)
    g = Game.new(puzzle)
    begin
      g.instance_eval(code)
      # code.split.each do |statement|
      #   g.instance_eval(statement)
      # end
      return g.phrase
    rescue => e
      Rails.logger.info e.message
      return e.message
    end
  end

  def keep
    @phrase << @puzzle[@position]
    skip
    @phrase
  end

  def chop
    @phrase.chop!
    @phrase
  end

  def skip
    @position += 1
  end
end
