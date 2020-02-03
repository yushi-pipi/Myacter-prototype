# frozen_string_literal: true

class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.string :title
      t.string :category
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :activities, %i[user_id created_at]
  end
end
