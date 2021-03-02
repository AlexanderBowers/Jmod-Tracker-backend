class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :comment_id, :url
  has_one :jmod
end
