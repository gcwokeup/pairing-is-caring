class CreateAvailabilities < ActiveRecord::Migration[6.0]
  def change
    create_table :availabilities do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :mentor
      t.string :timezone
      t.string :location

      t.timestamps
    end
  end
end
