class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :user_type
      t.integer :user_id

      t.timestamps
    end
  end
end
