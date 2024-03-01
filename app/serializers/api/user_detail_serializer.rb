class Api::UserDetailSerializer < ActiveModel::Serializer
  attributes :email, :phone, :age, :title
end
