class CreateImpactAreas < ActiveRecord::Migration
  def change
    create_table :impact_areas do |t|
      t.string :name

      t.timestamps
    end
  end
end
