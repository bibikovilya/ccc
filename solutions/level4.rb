class Level4
  class << self
    def solve
      lambda do |level_case|
        level_case.images.reject! { |image| image.matrix.zero? }
        level_case.images.each { |image| image.matrix.compact.binary }

        appears = {}
        level_case.images.each do |image|
          key = image.matrix.to_a
          added = false
          4.times do |i|
            if appears.keys.include? key
              appears[key] ||= []
              appears[key] << { timestamp: image.timestamp, rotate: (4-i)%4 }
              added = true
              break
            end
            key = rotate(key)
          end

          unless added
            appears[key] ||= []
            appears[key] << { timestamp: image.timestamp, rotate: 0 }
          end
        end

        output = []

        appears.values.map do |timestamps|
          output << find_sequence(timestamps)
        end

        output.flatten(1).map { |arr| [arr[0][:timestamp], arr[-1][:timestamp], arr.count] }.sort.map { |arr| arr.join(' ') }
      end
    end

    def find_sequence(arr)

      offset = 1

      while offset < arr.size
        gap = arr[offset][:timestamp] - arr[0][:timestamp]
        rotate = arr[offset][:rotate] - arr[0][:rotate]
        set = (arr.first[:timestamp]..arr.last[:timestamp]).step(gap).to_a
                .map.with_index{ |a, i| { timestamp: a, rotate: (arr[0][:rotate] + (i*rotate))%4 } }

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

    def rotate(matrix)
      matrix.first.zip(*matrix[1..-1]).map(&:reverse)
    end
  end
end
