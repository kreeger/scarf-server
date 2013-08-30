class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :fetch_id, index: true, null: false
      t.foreign_key :fetches
      t.string :document_id, index: true
      t.timestamps
    end
  end
end
