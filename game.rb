require_relative 'game_state_memory'

#The game class, which is used as an interface to the outer world
class Game
  # To change this template use File | Settings | File Templates.

  attr_reader :initialBoard
  attr_reader :currentState

  # gameState parameter allows to choose different implementations of GameState.
  # Currently there's only one, but I will add some more in the future
  def initialize(theBoard, gameState)
    @initialBoard = theBoard
    @currentState = gameState.new(theBoard)
  end

  def run(nSteps = 1)
    @currentState.run(nSteps)
  end

  def currentBoard
    @currentState.currentBoard
  end
end