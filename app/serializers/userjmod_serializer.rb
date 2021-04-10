class UserjmodSerializer < ActiveModel::Serializer
  attributes :id
  has_one :user
  has_one :jmod
end
