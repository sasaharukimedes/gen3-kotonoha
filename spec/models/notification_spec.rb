require 'rails_helper'

RSpec.describe Notification, type: :model do
  it "is invalid without a visitor_id" do
    notification = Notification.new(visitor_id: nil)
    notification.valid?
    expect(notification.errors[:visitor_id]).to include("を入力してください")
    p notification
  end

  it "is invalid without a visited_id" do
    notification = Notification.new(visited_id: nil)
    notification.valid?
    expect(notification.errors[:visited_id]).to include("を入力してください")
    p notification
  end

  it "is invalid without an action" do
    notification = Notification.new(action: nil)
    notification.valid?
    expect(notification.errors[:action]).to include("を入力してください")
    p notification
  end

  it "is invalid without a checked" do
    notification = Notification.new(checked: nil)
    notification.valid?
    expect(notification.errors[:checked]).to include("は一覧にありません")
    p notification
  end
end


