class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :name
      t.string :uri
      t.string :mime_type
      t.timestamps
    end
  end
end
