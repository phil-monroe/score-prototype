class CreatePillars < ActiveRecord::Migration
  def change
    create_table :pillars do |t|
      t.string :name
      t.integer :weight

      t.timestamps
    end
  end
end
