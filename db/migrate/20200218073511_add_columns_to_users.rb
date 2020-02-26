# frozen_string_literal: true

class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :topimage, :string
    add_column :users, :access_token, :string
    add_column :users, :access_secret, :string
  end
end
