require_relative 'game_state'

class GameStateMemory < GameState
  # The class that implements iteration over the states of the board using as less memory as possible
  # The memory is saved due to the fact that we don't need to store the copy of the whole board at each iteration
  # We can use just two extra rows where we store the updated state of the previous row and the other one for the
  # current one.

  protected
  def simulationRun(nSteps = 1)

    nSteps.times do
      previousRow = Array.new
      @currentBoard.each_with_index do |row, row_index|
        currentRow = row.dup
        row.each_index do |column_index|
          neighbours_alive = 0

          neighbours_alive += (@currentBoard[row_index - 1][column_index - 1]) if row_index > 0 && column_index > 0# left, top
          neighbours_alive += (@currentBoard[row_index - 1][column_index]) if row_index > 0# left, center
          neighbours_alive += (@currentBoard[row_index - 1][column_index + 1] || 0) if row_index > 0# left, right
          neighbours_alive += (@currentBoard[row_index][column_index - 1] || 0) if column_index > 0# center, left
          neighbours_alive += (@currentBoard[row_index][column_index + 1]  || 0)# center, right
          begin
            neighbours_alive += (@currentBoard[row_index + 1][column_index - 1] || 0) if column_index > 0# bottom, left
            neighbours_alive += (@currentBoard[row_index + 1][column_index] || 0)# bottom, center
            neighbours_alive += (@currentBoard[row_index + 1][column_index + 1] || 0)# bottom, right
          rescue
          end

          case
            when neighbours_alive < 2 || neighbours_alive > 3
              currentRow[column_index] = 0
            when neighbours_alive == 3
              currentRow[column_index] = 1
          end

        end
        @currentBoard[row_index - 1] = previousRow if row_index > 0
        previousRow = currentRow
      end

      @currentBoard[-1] = previousRow
    end

  end

end