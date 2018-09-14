def move_zeroes(array)
  moved_base = array.select do |num|
    num != 0
  end
  num_zeroes = array.length - moved_base.length
  moved_base + [0]*num_zeroes
end

def two_sum(numbers, target)
  index1 = 0
  index2 = 0
  sum = 0
  numbers.each_with_index do |number,index|
    binding.pry
    sum = number + numbers[index+1]
    if sum == target.to_i
      index1 = index
      index2 = index1 + 1
    end
  end
  [index1,index2]
end
