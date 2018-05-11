class FreeDirectionSerializer
  include FastJsonapi::ObjectSerializer

  attribute :origin do |object|
    object.origin
  end

  attribute :destination do |object|
    object.destination
  end
end
