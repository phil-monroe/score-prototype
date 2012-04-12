class CreateCalculationTimeHistories < ActiveRecord::Migration
  def change
    create_table :calculation_time_histories do |t|
      t.timestamp :time

      t.timestamps
    end
  end
end
