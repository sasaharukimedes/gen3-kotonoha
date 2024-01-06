require 'rails_helper'

RSpec.describe Post, type: :model do
  it "is invalid without a dear" do
    post = Post.new(
      dear: nil
    )
    expect(post).to be_invalid
    p post
  end
  it "is invalid without a content" do
    post = Post.new(
      content: nil
    )
    expect(post).to be_invalid
    p post
  end
  it "is invalid without a from" do
    post = Post.new(
      from: nil
    )
    expect(post).to be_invalid
    p post
  end
  it "is invalid without a sender_id" do
    post = Post.new(
      sender_id: nil
    )
    expect(post).to be_invalid
    p post
  end
  it "is invalid without a receiver_id" do
    post = Post.new(
      receiver_id: nil
    )
    expect(post).to be_invalid
    p post
  end

  it "returns a notification by making post" do
    user1 = User.new(
      id: 1,
      name: "Yuji",
      email: "jujutsu@email.com",
      birthday: "1995/02/03"
    )
    user1.save!
    user2 = User.new(
      id: 2,
      name: "Deku",
      email: "hiroaka@email.com",
      birthday: "1998/12/13"
    )
    user2.save!
    post = Post.new(
    dear: "Hello",
    content: "my friend",
    from: "bff",
    sender_id: user1.id,
    receiver_id: user2.id
    )
    expect(post.create_notification_by(user1)).to eq true

    p post
  end

  it "is valid to making post by user1" do
    user1 = User.new(
      id: 1,
      name: "Yuji",
      email: "jujutsu@email.com",
      birthday: "1995/02/03"
    )
    user1.save!
    user2 = User.new(
      id: 2,
      name: "Deku",
      email: "hiroaka@email.com",
      birthday: "1998/12/13"
    )
    user2.save!
    post1 = Post.new(
    dear: "Hello",
    content: "my friend",
    from: "bff",
    sender_id: user1.id,
    receiver_id: user2.id
    )
    expect(post1).to be_valid
  end
end
