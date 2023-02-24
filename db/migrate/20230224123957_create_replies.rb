class CreateReplies < ActiveRecord::Migration[7.0]
  def change
    create_table :replies do |t|
      t.string :dear
      t.text :content
      t.string :from
      t.integer :post_id
      t.boolean :sender_archives, null:false, default:false
      t.boolean :receiver_archives, null:false, default:false

      t.timestamps
    end
  end
end
