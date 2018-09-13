def move_zeroes(array)
  moved_base = array.select do |num|
    num != 0
  end
  num_zeroes = array.length - moved_base.length
  moved_base + [0]*num_zeroes
end

def two_sum(numbers, target)
  numbers.each_with_index do |number,index|
    binding.pry
    if (number + numbers[index + 1]) == target
      index1 = index
      index2 = index1 + 1
    end
  end
  [index1,index2]
end
