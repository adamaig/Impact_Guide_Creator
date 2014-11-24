class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :prompt_id
      t.integer :user_id
      t.integer :position
      t.integer :points
      t.text :text

    	

      t.timestamps
    end
  end
end
