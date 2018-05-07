class Level3
  def self.solve(level_case)
    level_case.images.reject! { |image| image.matrix.zero? }
    level_case.images.each { |image| image.matrix.compact.binary }

    appears = {}
    level_case.images.each do |image|
      key = image.matrix.to_a
      appears[key] ||= []
      appears[key] << image.timestamp
    end

    output = []

    appears.values.map do |timestamps|
      output << find_sequence(timestamps)
    end

    output.flatten(1).sort.map! { |arr| [arr[0], arr[-1], arr.count].join(' ') }
  end

  def self.find_sequence(arr)
    offset = 1

    while offset < arr.size
      gap = arr[offset] - arr[0]
      set = (arr.first..arr.last).step(gap).to_a

      if set.count >= 4 && (set & arr == set)
        if (rest = arr - set).any?
          prev_set = find_sequence(rest)
          if prev_set
            return prev_set << set
          else
            offset += 1
            next
          end
        else
          return [set]
        end
      end

      offset += 1
    end

    false
  end
end
