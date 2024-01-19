# frozen_string_literal: true

require 'rails_helper'
# 本来デプロイ前に確認するところを、もうデプロイして確認している関係もあってもっと細かくやるべきところをさっと書いてます。

RSpec.describe User, type: :model do
  context 'User was created successfully' do
    it 'is valid with a name, email, and birthday' do
      user = User.new(
        name: 'user1',
        email: 'xxx2gmail.com',
        birthday: '2000/11/18'
      )
      expect(user).to be_valid
      p user
    end
  end

  context "User wasn't created successfully" do
    it "is invalid if user's email is not unique" do
      user1 = User.new(
        id: '1',
        name: 'user1',
        email: 'xxx2gmail.com',
        birthday: '2000/11/18'
      )
      user1.save!
      user2 = User.new(
        id: '2',
        name: 'user2',
        email: 'xxx2gmail.com',
        birthday: '2012/10/14'
      )
      expect(user2.valid?).to be false
      p user1
      p user2
    end
    it 'is invalid without a received_at' do
      user = User.new(
        received_at: nil
      )
      expect(user).to be_invalid
      p user
    end
  end
end
