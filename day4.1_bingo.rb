require 'pry'

def append_transposed_columns_as_lines(board)
  transposed_columns = (0..4).map do |column_index|
    transposed_column = board.map do |line|
      line[column_index]
    end
  end

  board + transposed_columns
end

def mark(board, selected)
  board.map do |line|
    line.map do |element|
      if element == selected
        nil
      else
        element
      end
    end
  end
end

def bingo? board
  board.any? do |line|
    line.compact.empty?
  end
end

input = File.read("input4.1.txt").split("\n\n")
marking_inputs = input.first.split(",")
marked_numbers = []
raw_boards = input[1..].map { |board| board.split("\n").map(&:strip).map{|line| line.split(/\s+/) } }

boards = raw_boards.map{|board| append_transposed_columns_as_lines(board)}
marked_boards = boards

marking_inputs.each do |selected|
  marked_numbers.append(selected)

  temp_marked_boards = marked_boards.map do |board|
    mark(board, selected)
  end

  marked_boards = temp_marked_boards

  marked_boards.each do |marked_board|
    if bingo? marked_board
      sum_board = 0
      marked_board[0..4].each do |line|
        puts line.join(",")
        sum_board += line.map(&:to_i).sum
      end
      puts "\n\n"

      puts marked_numbers.join(" ")

      last_marked = marked_numbers.last.to_i

      puts sum_board
      puts last_marked

      puts sum_board * last_marked
      return
    end
  end
end
