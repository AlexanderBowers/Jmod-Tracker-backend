class CreateJmods < ActiveRecord::Migration[6.1]
  def change
    create_table :jmods do |t|
      t.string :name
    end
  end
end
