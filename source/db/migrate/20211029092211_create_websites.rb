class CreateWebsites < ActiveRecord::Migration[5.2]
  def change
    create_table :websites do |t|
      t.string :name, limit: 100, null: false
      t.string :domain, limit: 100, null: false
      t.integer :port, limit: 2, unsigned: true
      t.string :protocol, limit: 5
    end
  end
end
