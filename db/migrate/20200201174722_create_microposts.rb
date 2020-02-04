# frozen_string_literal: true

class CreateMicroposts < ActiveRecord::Migration[5.0]
  def change
    create_table :microposts do |t|
      t.string :title
      t.string :category
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :microposts, %i[user_id created_at]
  end
end