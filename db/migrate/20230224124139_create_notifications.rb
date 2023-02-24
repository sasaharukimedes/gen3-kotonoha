class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null:false
      t.integer :visited_id, null:false
      t.integer :post_id
      t.integer :reply_id
      t.string :action, null:false, default:''
      t.boolean :checked, null:false, default:false

      t.timestamps
    end
    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :post_id
    add_index :notifications, :reply_id
  end
end
