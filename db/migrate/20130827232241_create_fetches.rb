class CreateFetches < ActiveRecord::Migration
  def change
    create_table :fetches do |t|

      t.timestamps
    end
  end
end
