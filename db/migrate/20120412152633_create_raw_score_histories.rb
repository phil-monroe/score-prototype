class CreateRawScoreHistories < ActiveRecord::Migration
  def change
    create_table :raw_score_histories do |t|
      t.integer :candidate_id
      t.float :score
      t.string :pillars

      t.timestamps
    end
  end
end
