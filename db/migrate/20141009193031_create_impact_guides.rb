class CreateImpactGuides < ActiveRecord::Migration
  def change
    create_table :impact_guides do |t|
      t.integer :creator_id
      t.integer :theme_id
      t.integer :game_id
      t.integer :category_id
      t.string :age
      t.string :time
      t.string :why_use_this_guide
      
      t.timestamps
    end
  end
end
