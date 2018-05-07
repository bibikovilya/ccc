class Level2
  def self.solve
    lambda do |level_case|
      level_case.images.reject! { |image| image.matrix.zero? }
      level_case.images.each { |image| image.matrix.compact.binary }

      output = {}
      level_case.images.each do |image|
        key = image.matrix.to_a
        if output.keys.include? key
          output[key][:to] = image.timestamp
          output[key][:count] += 1
        else
          output[key] = {
            from: image.timestamp,
            to: image.timestamp,
            count: 1
          }
        end
      end

      output.values.map(&:values).map { |r| r.join(' ') }
    end
  end
end
