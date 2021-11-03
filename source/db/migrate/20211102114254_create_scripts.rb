class CreateScripts < ActiveRecord::Migration[5.2]
  def change
    create_table :scripts do |t|
      t.string :name, limit: 100, null: false
      t.text :content
      t.string :external_url
    end
  end
end
