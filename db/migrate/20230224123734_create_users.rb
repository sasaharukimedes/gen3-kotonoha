class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.date :birthday
      t.datetime :received_at

      t.timestamps
    end
  end
end
