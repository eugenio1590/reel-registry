class Api::V1::MovieSerializer
  include JSONAPI::Serializer
  attributes :title, :release_at, :director, :genre, :synopsis, :duration, :created_at, :updated_at
end
