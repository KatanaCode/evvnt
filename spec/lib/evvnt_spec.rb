require "spec_helper"

describe Evvnt do

  describe "defaults" do

    subject { Evvnt.configuration }

    describe "#environment" do

      it "defaults to :sandbox" do
        expect(subject.environment).to eql(:sandbox)
      end

      it "accepts value :live" do
        new_subject = Evvnt.configure
        new_subject.environment = :live
        expect(new_subject.environment).to eql(:live)
      end

      it "raises an exception with any other value" do
        new_subject = Evvnt.configure
        expect { new_subject.environment = :foobar }.to raise_error(ArgumentError)
      end

    end

    describe "#logger" do

      it "defaults to new Logger" do
        expect(subject.logger).to be_an_instance_of(Logger)
      end

    end

    describe "#debug" do

      it "defaults to false" do
        expect(subject.debug).to eql(false)
      end

    end

    describe "#api_key" do

      it "defaults to nil" do
        expect(subject.api_key).to eql(nil)
      end

      it "can be set externally" do
        subject.api_key = "foobar"
        expect(subject.api_key).to eql("foobar")
      end

    end

    describe "#api_secret" do

      it "defaults to nil" do
        expect(subject.api_secret).to eql(nil)
      end

      it "can be set externally" do
        subject.api_secret = "foobar"
        expect(subject.api_secret).to eql("foobar")
      end

    end

  end
end
