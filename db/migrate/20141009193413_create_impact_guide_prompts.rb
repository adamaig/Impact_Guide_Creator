class CreateImpactGuidePrompts < ActiveRecord::Migration
  def change
    create_table :impact_guide_prompts do |t|
      t.integer  :impact_guide_id
      t.string :prompt, :limit => 1024
      t.integer :points
      t.integer :position
      t.string :prompt
      t.integer :category_id

      t.timestamps
    end
  end
end
