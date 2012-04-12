class CreateAvailableEvents < ActiveRecord::Migration
  def change
    create_table :available_events do |t|
      t.string :user_type
      t.string :event_name
      t.integer :pillar_id
      t.float :multiplier, default: 1

      t.timestamps
    end
  end
end
