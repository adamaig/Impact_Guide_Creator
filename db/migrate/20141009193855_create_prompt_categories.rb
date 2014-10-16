class CreatePromptCategories < ActiveRecord::Migration
  def change
    create_table :prompt_categories do |t|
      t.string :moniker

      t.timestamps
    end
  end
end
