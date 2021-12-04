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

boards = raw_boards.map do |board|
  {
    is_bingo: false,
    bingo_order: nil,
    bingo_at_number: nil,
    matrix: append_transposed_columns_as_lines(board)
  }
end


marking_inputs.each_with_index do |selected, input_index|
  boards.each do |board, board_index|
    unless board[:is_bingo]
      board[:matrix] = mark(board[:matrix], selected)

      if bingo?(board[:matrix])
        board[:is_bingo] = true
        board[:bingo_order] = input_index
        board[:bingo_at_number] = selected
      end
    end
  end
end

last_bingo_board = boards.filter{|board| board[:is_bingo]}.sort_by{|board| board[:bingo_order]}.last

sum_board = 0
last_bingo_board[:matrix][0..4].each do |line|
  puts line.join(",")
  sum_board += line.map(&:to_i).sum
end

puts sum_board
puts last_bingo_board[:bingo_at_number]

puts sum_board * last_bingo_board[:bingo_at_number].to_i
