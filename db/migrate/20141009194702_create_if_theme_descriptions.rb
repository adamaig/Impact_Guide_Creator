class CreateIfThemeDescriptions < ActiveRecord::Migration
  def change
    create_table :ig_theme_descriptions do |t|
      t.string :text, :limit => 1024
      t.integer :themeId

      t.timestamps
    end
  end
end
