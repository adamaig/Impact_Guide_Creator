class CreateIgsAbouts < ActiveRecord::Migration
  def change
    create_table :ig_abouts do |t|
      t.integer :ig_id
      t.integer :ig_about_id

      t.timestamps
    end
  end
end
