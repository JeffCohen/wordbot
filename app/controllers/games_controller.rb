class GamesController < ApplicationController

  PUZZLES = {
    "easy" => { start: "Hxxexxlxxlxxoxx", solution: 'Hello' },
    "medium" => { start: "Ayyuyyysyytyyyiyynyyy", solution: 'Austin' },
    "hard" => { start: "SzzzXzSzzzWz", solution: 'SXSW' }
   }

  def index
    @levels = ["Easy", "Medium", "Hard"]
  end

  def show
    @level = (params[:level] || "").downcase
    @level = "easy" unless %w(easy medium hard).include?(@level)
    @puzzle = PUZZLES[@level][:start]
    @solution = PUZZLES[@level][:solution]
    @result = ""
  end

  def evaluate
    @level = (params[:level] || "").downcase
    @level = "easy" unless %w(easy medium hard).include?(@level)
    @puzzle = PUZZLES[@level][:start]
    @solution = PUZZLES[@level][:solution]
    @code = params[:code]
    @result = Game.run(@puzzle, @code)
    @result.sub!(/ for.+$/,'')
    @result.sub!(/undefined local variable or method/, "Unknown: ")
    logger.info "Result: #{@result}"
    respond_to do |format|
      format.js
      format.html { render 'show' }
    end

  end
end
