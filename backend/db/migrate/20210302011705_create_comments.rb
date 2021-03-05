class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.text :permalink
      t.belongs_to :jmod, null: false, foreign_key: true
    end
  end
end
