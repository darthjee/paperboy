# frozen_string_literal: true

class CreateWebsiteScripts < ActiveRecord::Migration[5.2]
  def change
    create_table :website_scripts do |t|
      t.bigint :website_id, null: false
      t.bigint :script_id, null: false
      t.string :path

      t.index %i[script_id website_id], unique: true
      t.index :website_id
    end

    add_foreign_key :website_scripts, :websites
    add_foreign_key :website_scripts, :scripts
  end
end
