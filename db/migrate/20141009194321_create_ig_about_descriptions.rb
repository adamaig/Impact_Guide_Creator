class CreateIgAboutDescriptions < ActiveRecord::Migration
  def change
    create_table :ig_about_descriptions do |t|
      t.integer :game_id
      t.text :text

      t.timestamps
    end
  end
end
