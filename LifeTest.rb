require 'test/unit'
require_relative 'game_state_memory'
require_relative 'game'

class MyTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  #Returns the board of a given size with all cells dead

  def zeroBoard(nRows, nCols)
    Array.new(nRows) {Array.new(nCols, 0)}
  end

  def test_negativeNumberOfSteps
    # test that checks for the exception thrown in case if the number of simulation steps is < 1
    game = Game.new([[0]], GameStateMemory)
    assert_raise(ArgumentError, "Number of simulation steps should be bigger than zero") {game.run(-1)}
  end

  def test_SimpleTest010
    #check a simple case when board has only one row
    theBoard = [[0,1,0]]

    game = Game.new(theBoard, GameStateMemory)
    game.run(1)
    assert_equal(zeroBoard(1, 3), game.currentBoard)#board with all zeros
  end

  def test_SimpleTest010_101
    #another simple test case when a board has two rows
    theBoard = [[0, 1, 0], [1, 0, 1]]

    game = Game.new(theBoard, GameStateMemory)
    game.run(1)
    theBoardStep2 = [[0, 1, 0], [0, 1, 0]]
    assert_equal(game.currentBoard, theBoardStep2)

    game.run(1)
    assert_equal(zeroBoard(2,3), game.currentBoard)
  end

  def test_SimpleTest010_101Batch
    #run a simple test with a batch of steps
    theBoard = [[0, 1, 0], [1, 0, 1]]

    game = Game.new(theBoard, GameStateMemory)
    game.run(3)
    assert_equal(zeroBoard(2,3), game.currentBoard)
  end

  def test_Toad
    #run a simple test with a Toad pattern(period 2)
    # http://en.wikipedia.org/wiki/File:Game_of_life_toad.gif

    theToadBoard1 = [[0, 0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0, 0],
                [0, 0, 1, 1, 1, 0],
                [0, 1, 1, 1, 0, 0],
                [0, 0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0, 0]]

    theToadBoard2 = [[0, 0, 0, 0, 0, 0],
                     [0, 0, 0, 1, 0, 0],
                     [0, 1, 0, 0, 1, 0],
                     [0, 1, 0, 0, 1, 0],
                     [0, 0, 1, 0, 0, 0],
                     [0, 0, 0, 0, 0, 0]]

    game = Game.new(theToadBoard1, GameStateMemory)
    game.run
    assert_equal(theToadBoard2, game.currentBoard)

    game.run
    assert_equal(theToadBoard1, game.currentBoard)

    #now test a batch
    game.run(3)
    assert_equal(theToadBoard2, game.currentBoard)
  end
end