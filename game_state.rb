#The skeleton of the classes that implement iteration over the state of the board in a Game of Life

class GameState
  # There's more than one way to do calculations for the Game of Life problem.
  # So let's define some common methods (though as it appears dynamic languages don't need abstract classes)
  # Defined it anyways to make code more readable and less repeatable, since maybe will have to add some common methods
  # for different implementations of game state iterations that I would come up with

  attr_accessor :currentBoard


  def initialize(theBoard)
    @currentBoard = theBoard
  end

  #The method that performs the specified number of iterations for the Game

  def run(nSteps = 1)
    puts "nSteps: #{nSteps}"
    raise ArgumentError,"Number of simulation steps should be bigger than zero" if nSteps < 1
    simulationRun(nSteps)
  end

  protected
  def simulationRun(nSteps = 1)

  end
end