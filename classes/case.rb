# frozen_string_literal: true

require_relative 'image'

class Case
  include ActiveAttr::Attributes
  include ActiveAttr::MassAssignment

  attribute :from
  attribute :to
  attribute :image_count
  attribute :images

  def initialize(level: 1, number: 0)
    self.images = []

    image_row = 0
    image_matrix = []

    File.readlines(input_filepath(level: level, number: number)).each_with_index do |line, i|
      i.zero? && (self.from, self.to, self.image_count = line.split) && next

      if image_row.zero?
        images.last.matrix = Matrix[*image_matrix] if image_matrix.any?

        image = Image.new
        image.timestamp, image.size_y, image.size_x = line.split.map(&:to_i)
        images << image

        image_matrix = []
        image_row = image.size_y
      else
        image_matrix << line.split.map(&:to_i)

        image_row -= 1
      end
    end
    images.last.matrix = Matrix[*image_matrix] if image_matrix.any?
  end
end
