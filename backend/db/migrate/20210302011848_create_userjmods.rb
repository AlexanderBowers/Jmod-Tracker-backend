class CreateUserjmods < ActiveRecord::Migration[6.1]
  def change
    create_table :userjmods do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :jmod, null: false, foreign_key: true

      t.timestamps
    end
  end
end
