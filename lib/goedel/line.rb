require "active_support/all"
require "bigdecimal"

module Goedel
  class Line
    attr_reader :prop, :val, :instance_name

    def initialize(instance_name, prop, val)
      @instance_name = instance_name
      @prop = prop 
      @val = val
    end

    def generate
      "#{instance_name}.#{prop} = #{classify(val)}"
    end

    private

    def classify(val)
      if val.is_a?(String)
        "\"#{val}\""
      elsif val.is_a?(ActiveSupport::TimeWithZone)
        time_str = val.utc.strftime("%Y-%m-%d %H:%M:%S")
        "Time.zone.parse(\"#{time_str}\")"
      elsif val.is_a?(Time)
        time_int = val.to_i
        "Time.at(#{time_int})"
      elsif val.is_a?(DateTime)
        time_str = val.utc.strftime("%Y-%m-%d %H:%M:%S")
        "DateTime.parse(\"#{time_str}\")"
      elsif val.is_a?(BigDecimal)
        "BigDecimal.new(\"#{val.to_f}\")" 
      else
        "#{val}"
      end
    end
  end
end

