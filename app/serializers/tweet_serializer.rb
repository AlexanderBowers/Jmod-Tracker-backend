class TweetSerializer < ActiveModel::Serializer
  attributes :id, :body, :tweet_id, :url
  has_one :jmod
end
