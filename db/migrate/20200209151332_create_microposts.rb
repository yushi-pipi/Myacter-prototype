# frozen_string_literal: true

class CreateMicroposts < ActiveRecord::Migration[5.1]
  def change
    create_table :microposts do |t|
      t.text :memo
      t.text :tweet
      t.datetime :start_at
      t.datetime :finish_at
      t.time :act_itvl
      t.references :activity, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
