class AddNullToModels < ActiveRecord::Migration[7.1]
  def change
    change_column :posts, :dear, :string, default: "", null: false
    change_column :posts, :content, :text, default: "", null: false
    change_column :posts, :from, :string, default: "", null: false
    change_column :posts, :sender_id, :integer, default: 0, null: false
    change_column :posts, :receiver_id, :integer, default: 0, null: false

    change_column :notifications, :visitor_id, :integer, default: 0
    change_column :notifications, :visited_id, :integer, default: 0
    change_column :notifications, :post_id, :integer, default: 0
    change_column :notifications, :reply_id, :integer, default: 0

    change_column :replies, :dear, :string, default: "", null: false
    change_column :replies, :content, :text, default: "", null: false
    change_column :replies, :from, :string, default: "", null: false
    change_column :replies, :post_id, :integer, default: 0, null: false

    change_column :users, :name, :string, default: "", null: false
    change_column :users, :email, :string, default: "", null: false
    change_column :users, :birthday, :date, null: false
    change_column :users, :received_at, :datetime, null: false
    change_column :users, :status, :string, default: "", null: false


  end
end
