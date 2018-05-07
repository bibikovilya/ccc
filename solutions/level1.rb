class Level1
  def self.solve
    lambda do |level_case|
      level_case.images.reject { |image| image.matrix.zero? }.map(&:timestamp)
    end
  end
end
