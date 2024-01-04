require 'rails_helper'

RSpec.describe Reply, type: :model do
  it "is invalid without a dear" do
    reply = Reply.new(
      dear: nil
    )
    expect(reply).to be_invalid
    p reply
  end
  it "is invalid without a content" do
    reply = Reply.new(
      content: nil
    )
    expect(reply).to be_invalid
    p reply
  end
  it "is invalid without a from" do
    reply = Reply.new(
      from: nil
    )
    expect(reply).to be_invalid
    p reply
  end
  it "is invalid without a post_id" do
    reply = Reply.new(
      post_id: nil
    )
    expect(reply).to be_invalid
    p reply
  end
end
