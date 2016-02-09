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
        "ssn" => nil,
        "created_at"=> Time.zone.parse("2015-01-01 12:43:11"),
        "updated_at"=> Time.zone.parse("2015-01-01 12:43:11")
      }
    end
  end

  it "generates create statement for active record object" do
    statement = Goedel::Statement.new(@user).generate
    expect(statement).to eq("my_user = User.new\n  my_user.id = 14\n  my_user.name = \"kurt\"\n  my_user.email = \"kurt@incompleteness.com\"\n  my_user.created_at = Time.zone.parse(\"2015-01-01 17:43:11\")\n  my_user.updated_at = Time.zone.parse(\"2015-01-01 17:43:11\")\nmy_user.save")
  end

  it "generates create statement for active record with force attribute option" do
    statement = Goedel::Statement.new(@user, force_attributes: [:address]).generate
    expect(statement).to eq("my_user = User.new\n  my_user.id = 14\n  my_user.name = \"kurt\"\n  my_user.email = \"kurt@incompleteness.com\"\n  my_user.created_at = Time.zone.parse(\"2015-01-01 17:43:11\")\n  my_user.updated_at = Time.zone.parse(\"2015-01-01 17:43:11\")\n  my_user.address = \"1234 Incomplete St., Princeton, New Jersey\"\nmy_user.save")
  end

  it "generates create state for active record with override attributes option" do
    statement = Goedel::Statement.new(@user, force_attributes: [:address], override_attributes: {"name" => "Hide My Name"}).generate
    expect(statement).to eq("my_user = User.new\n  my_user.id = 14\n  my_user.name = \"Hide My Name\"\n  my_user.email = \"kurt@incompleteness.com\"\n  my_user.created_at = Time.zone.parse(\"2015-01-01 17:43:11\")\n  my_user.updated_at = Time.zone.parse(\"2015-01-01 17:43:11\")\n  my_user.address = \"1234 Incomplete St., Princeton, New Jersey\"\nmy_user.save")
  end
end


