class Api::UserSerializer < ActiveModel::Serializer
  attributes :name, :id

  has_one :detail, serializer: Api::UserDetailSerializer

  def id
    object.guid
  end
end
