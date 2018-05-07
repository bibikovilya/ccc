class Level1
  def self.solve(level_case)
    level_case.images.reject { |image| image.matrix.zero? }.map(&:timestamp)
  end
end
