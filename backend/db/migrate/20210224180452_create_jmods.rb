class CreateJmods < ActiveRecord::Migration[6.1]
  def change
    create_table :jmods do |t|
      t.string :reddit
      t.string :twitter

      t.timestamps
    end
  end
end
