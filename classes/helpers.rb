def input_filepath(level: 1, number: 0)
  "inputs/l#{level}_#{format('%.3i', number)}.txt"
end

def output_filepath(level: 1, number: 0)
  "outputs/l#{level}_#{format('%.3i', number)}.txt"
end

def answer_filepath(level: 1, number: 0)
  "answers/l#{level}_#{format('%.3i', number)}.success.txt"
end
