class CreateExperiments < ActiveRecord::Migration
  def change
    create_table :experiments do |t|
      t.text :json

      t.timestamps
    end
  end
end
