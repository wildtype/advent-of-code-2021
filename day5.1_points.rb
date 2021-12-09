require 'pry'

def eachable(from, to)
  if from < to
    (from..to)
  else
    from.downto(to)
  end
end

def lower_to_big(a, b)
  if a > b
    return b, a
  end

  return a, b
end

field = Array.new(1000){ Array.new(1000) {0} }
inputs = File.read('inputd5.txt')
  .split("\n")
  .map{|line| line.split(/,|\s\-\>\s/).map(&:to_i) }

inputs.each do |input|
  x1, y1, x2, y2 = input

  if x1 == x2
    if y1 != y2
      eachable(y1, y2).each do |y|
        field[x1][y] += 1
      end
    end
  elsif y1 == y2
    if x1 != x2
      eachable(x1, x2).each do |x|
        field[x][y1] += 1
      end
    end
  end

end


np = field.map do |xs|
  xs.filter{|point| point > 1}.size
end.sum

puts np
