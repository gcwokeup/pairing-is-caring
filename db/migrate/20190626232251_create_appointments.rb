class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :mentee
      t.references :mentor
      t.string :timezone
      t.string :location

      t.timestamps
    end
  end
end
