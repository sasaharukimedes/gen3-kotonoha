# frozen_string_literal: true

require 'rails_helper'
# 本来デプロイ前に確認するところを、もうデプロイして確認している関係もあってもっと細かくやるべきところをさっと書いてます。

RSpec.describe Notification, type: :model do
  context "Notification wasn't created successfully" do
    it 'is invalid without a visitor_id' do
      notification = Notification.new(visitor_id: nil)
      notification.valid?
      expect(notification.errors[:visitor_id]).to include('を入力してください')
      p notification
    end

    it 'is invalid without a visited_id' do
      notification = Notification.new(visited_id: nil)
      notification.valid?
      expect(notification.errors[:visited_id]).to include('を入力してください')
      p notification
    end

    it 'is invalid without an action' do
      notification = Notification.new(action: nil)
      notification.valid?
      expect(notification.errors[:action]).to include('を入力してください')
      p notification
    end

    it 'is invalid without a checked' do
      notification = Notification.new(checked: nil)
      notification.valid?
      expect(notification.errors[:checked]).to include('は一覧にありません')
      p notification
    end
  end
end
