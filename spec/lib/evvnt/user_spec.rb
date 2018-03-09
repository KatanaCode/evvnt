require 'spec_helper'

describe Evvnt::User, type: :api do

  describe "::index" do

    before do
      stub_api_request(:get, "users")
    end

    it "returns an Arry" do
      expect(Evvnt::User.index).to be_an_instance_of(Array)
    end

    it "expects each item to be a User" do
      Evvnt::User.index.each do |user|
        expect(user).to be_an_instance_of(Evvnt::User)
      end
    end

    it "expects each user to have the correct attributes" do
      Evvnt::User.index.each do |user|
        expect(user).to respond_to :uuid
        expect(user).to respond_to :name
        expect(user).to respond_to :email
      end
    end

  end


  describe "::create" do

    let!(:attributes) { { name: "Gavin Morrice", email: "me@example.com" } }

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

  describe "::show" do

    before do
      stub_api_request(:get, "users/ffcdd57c-243e-4d71-ab50-a0ca765bbe54")
    end

    subject { Evvnt::User.show("ffcdd57c-243e-4d71-ab50-a0ca765bbe54") }

    it "returns a User" do
      expect(subject).to be_an_instance_of(Evvnt::User)
    end

    it "expects each user to have the correct attributes" do
      expect(subject).to respond_to :uuid
      expect(subject).to respond_to :name
      expect(subject).to respond_to :email
    end

  end

  describe "::update" do

    before do
      stub_api_request(:put, "users/ffcdd57c-243e-4d71-ab50-a0ca765bbe54",
                             params: { email: "new_email@example.com" })
    end

    subject { Evvnt::User.update("ffcdd57c-243e-4d71-ab50-a0ca765bbe54",
                                 email: "new_email@example.com" ) }

    it "doesn't raise an error" do
      expect { subject }.not_to raise_error
    end

    it "expects response user to be blank" do
      expect(subject.attributes).to be_empty
    end

  end

end
