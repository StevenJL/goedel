require "active_support/all"
require "bigdecimal"
require "pry"

$root = File.expand_path("../../..", __FILE__)
require "#{$root}/spec/spec_helper"

describe Goedel::Statement do
  before(:each) do
    Time.zone = 'Eastern Time (US & Canada)' 

    class User;end
    @user = double

    @user.stub(:class) { User }
    @user.stub(:address) {"1234 Incomplete St., Princeton, New Jersey"}
    @user.stub(:attributes) do   
      {
        "id"=>14,
        "name"=>"kurt",
        "email"=>"kurt@incompleteness.com",
        "created_at"=> Time.zone.parse("2015-01-01 12:43:11"),
        "updated_at"=> Time.zone.parse("2015-01-01 12:43:11")
      }
    end
  end

  it "generates create statement for active record object" do
    statement = Goedel::Statement.new(@user).generate
    expect(statement).to eq("User.create(\n  id: 14,\n  name: \"kurt\",\n  email: \"kurt@incompleteness.com\",\n  created_at: Time.Zone.parse(\"2015-01-01 17:43:11\"),\n  updated_at: Time.Zone.parse(\"2015-01-01 17:43:11\"),\n)")
  end

  it "generates create statement for active record with force attribute option" do
    statement = Goedel::Statement.new(@user, force_attributes: [:address]).generate
    expect(statement).to eq("User.create(\n  id: 14,\n  name: \"kurt\",\n  email: \"kurt@incompleteness.com\",\n  created_at: Time.Zone.parse(\"2015-01-01 17:43:11\"),\n  updated_at: Time.Zone.parse(\"2015-01-01 17:43:11\"),\n  address: \"1234 Incomplete St., Princeton, New Jersey\",\n)")
  end
end

