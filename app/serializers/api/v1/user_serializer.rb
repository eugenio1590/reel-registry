class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :created_at, :updated_at, :auth_token

  def auth_token
    @instance_options[:auth_token]
  end
end
