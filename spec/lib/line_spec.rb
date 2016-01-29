require "active_support/all"
require "bigdecimal"

$root = File.expand_path("../../..", __FILE__)
require "#{$root}/spec/spec_helper"

describe Goedel::Line do
  it "generates line for str val" do
    result = Goedel::Line.new("name", "Kurt Goedel").generate
    expect(result).to eq("name: \"Kurt Goedel\",")
  end

  it "generates line for active_support timezone val" do
    Time.zone = 'Eastern Time (US & Canada)' 
    result = Goedel::Line.new("created_at", Time.zone.parse("2015-01-01 12:43:11")).generate
    expect(result).to eq("created_at: Time.zone.parse(\"2015-01-01 17:43:11\"),")
  end

  it "generates line for plain time val" do
    result = Goedel::Line.new("updated_at", Time.at(1454005975)).generate
    expect(result).to eq("updated_at: Time.at(1454005975),")
  end

  it "generates line for plain DateTime val" do
    result = Goedel::Line.new("updated_at", DateTime.parse("2015-01-01 12:00:00")).generate
    expect(result).to eq("updated_at: DateTime.parse(\"2015-01-01 12:00:00\"),")
  end

  it "generates line for big decimal val" do
    result = Goedel::Line.new("price", BigDecimal.new("0.25")).generate
    expect(result).to eq("price: BigDecimal.new(\"0.25\"),")
  end
end

