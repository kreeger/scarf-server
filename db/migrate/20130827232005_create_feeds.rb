class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :name, index: true, null: false
      t.string :uri, null: false
      t.string :mime_type, null: false
      t.timestamps
    end
  end
end
