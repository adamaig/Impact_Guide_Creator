class CreateUserImpactGuideRoles < ActiveRecord::Migration
  def change
    create_table :user_impact_guide_roles do |t|
      t.integer :user_id
      t.integer :impact_guide_id
      t.integer :role

      t.timestamps
    end
  end
end
