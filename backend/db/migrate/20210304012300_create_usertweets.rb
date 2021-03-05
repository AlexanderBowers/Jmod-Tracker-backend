class CreateUsertweets < ActiveRecord::Migration[6.1]
  def change
    create_table :usertweets do |t|
      t.string :user_id
      t.string :tweet_id
    end
  end
end
