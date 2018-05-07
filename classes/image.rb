class Image
  include ActiveAttr::Attributes
  include ActiveAttr::MassAssignment

  attribute :timestamp
  attribute :size_x
  attribute :size_y
  attribute :matrix
end
