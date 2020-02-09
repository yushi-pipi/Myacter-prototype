class CreateMicroposts < ActiveRecord::Migration[5.1]
  def change
    create_table :microposts do |t|
      t.text :memo
      t.time :start_at
      t.time :finish_at
      t.time :act_itvl
      t.references :activity, foreign_key: true

      t.timestamps
    end
  end
end
