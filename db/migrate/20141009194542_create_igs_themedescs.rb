class CreateIgsThemedescs < ActiveRecord::Migration
  def change
    create_table :ig_themedescs do |t|
      t.integer :theme_id
      t.text :ig_theme_desc

      t.timestamps
    end
  end
end
