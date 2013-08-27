class CreateFetches < ActiveRecord::Migration
  def change
    create_table :fetches do |t|
      t.integer :feed_id
      t.foreign_key :feeds
      t.string :document_id, index: true
      t.datetime :created_at
    end
  end
end
