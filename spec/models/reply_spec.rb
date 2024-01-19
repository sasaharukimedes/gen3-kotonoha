# frozen_string_literal: true

require 'rails_helper'
# 本来デプロイ前に確認するところを、もうデプロイして確認している関係もあってもっと細かくやるべきところをさっと書いてます。

RSpec.describe Reply, type: :model do
  context "Reply wasn't created successfully because of validation error" do
    it 'is invalid without a dear' do
      reply = Reply.new(
        dear: nil
      )
      expect(reply).to be_invalid
      p reply
    end
    it 'is invalid without a content' do
      reply = Reply.new(
        content: nil
      )
      expect(reply).to be_invalid
      p reply
    end
    it 'is invalid without a from' do
      reply = Reply.new(
        from: nil
      )
      expect(reply).to be_invalid
      p reply
    end
    it 'is invalid without a post_id' do
      reply = Reply.new(
        post_id: nil
      )
      expect(reply).to be_invalid
      p reply
    end
  end

  context 'User can receive notification of reply making by someone' do
    it 'returns a notification by making post' do
      user1 = User.new(
        id: 1,
        name: 'Yuji',
        email: 'jujutsu@email.com',
        birthday: '1995/02/03'
      )
      user1.save!
      user2 = User.new(
        id: 2,
        name: 'Deku',
        email: 'hiroaka@email.com',
        birthday: '1998/12/13'
      )
      user2.save!
      post = Post.new(
        id: 1,
        dear: 'Hello',
        content: 'my friend',
        from: 'bff',
        sender_id: user1.id,
        receiver_id: user2.id
      )
      post.save!
      reply = Reply.new(
        dear: 'deku',
        content: 'wello horld',
        from: 'teketeke',
        post_id: post.id
      )
      expect(reply).to be_valid
      p reply
    end
  end
end
