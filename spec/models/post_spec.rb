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
end
