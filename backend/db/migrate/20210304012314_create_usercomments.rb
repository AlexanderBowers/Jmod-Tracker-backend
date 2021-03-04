class CreateUsercomments < ActiveRecord::Migration[6.1]
  def change
    create_table :usercomments do |t|
      t.string :user_id
      t.string :comment_id

      t.timestamps
    end
  end
end
