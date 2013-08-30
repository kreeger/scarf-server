class CreateFetches < ActiveRecord::Migration
  def change
    create_table :fetches do |t|
      t.integer :feed_id, index: true, null: false
      t.foreign_key :feeds
      t.integer :response_code, null: false, default: 200
      t.datetime :fetched_at, null: false
    end
  end
end
