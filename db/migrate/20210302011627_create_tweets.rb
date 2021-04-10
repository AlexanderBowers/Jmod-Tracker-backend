class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.text :text
      t.string :tweet_id
      t.string :jmod_name
      t.belongs_to :jmod, null: false, foreign_key: true
    end
  end
end
