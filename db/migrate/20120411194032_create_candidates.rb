class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :name
      t.float :score, default: 0

      t.timestamps
    end
  end
end
