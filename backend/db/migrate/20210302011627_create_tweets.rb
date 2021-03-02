class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.text :body
      t.string :tweet_id
      t.text :url
      t.belongs_to :jmod, null: false, foreign_key: true

      t.timestamps
    end
  end
end
