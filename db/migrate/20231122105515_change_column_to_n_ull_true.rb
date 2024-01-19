# frozen_string_literal: true

class ChangeColumnToNUllTrue < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :birthday, :date, null: true
  end
end
