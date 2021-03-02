class CreateJmods < ActiveRecord::Migration[6.1]
  def change
    create_table :jmods do |t|
      t.string :name
      t.string :twitter_id

      t.timestamps
    end
  end
end
