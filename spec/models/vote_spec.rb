require 'rails_helper'
describe Vote do

  before do
    @user = create(:user)
    @post = create(:post, user: @user)
  end

  describe "validations" do
    it "only allows -1 or 1 as values" do

      v = Vote.new(value: 1)
      expect(v.valid?).to eq(true)

      v2 = Vote.new(value: -1)
      expect(v2.valid?).to eq(true)

      bad = Vote.new(value: 2)
      expect(bad.valid?).to eq(false)

    end
  end

  describe 'after_save' do
    it "calls `Post#update_rank` after save" do
      vote = Vote.new(value: 1, post: @post)
      expect(@post).to receive(:update_rank)
      vote.save
    end
  end

end