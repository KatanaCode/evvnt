require 'spec_helper'

describe Evvnt::User, type: :api do

  describe "::create" do

    let!(:attributes) {
      { first_name: "Gavin", last_name: "Morrice", email: "me@example.com" }
    }

    before do
      stub_api_request(:post, "users", params: attributes)
    end

    it "returns a single User" do
      expect(Evvnt::User.create(attributes)).to be_an_instance_of(Evvnt::User)
    end

    it "expects return object to have uuid" do
      expect(Evvnt::User.create(attributes)).to respond_to(:id)
    end

    it "expects return object to have uuid" do
      expect(Evvnt::User.create(attributes)).to respond_to(:hint)
    end

  end

end
