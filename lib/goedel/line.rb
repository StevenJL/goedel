require "active_support/all"

module Goedel
  class Line
    attr_reader :prop, :val

    def initialize(prop, val)
      @prop = prop 
      @val = val
    end

    def generate
      "#{prop}: #{present(val)}"
    end

    private

    def present(val)
      if val.is_a?(String)
        "\"#{val}\""
      elsif val.is_a?(ActiveSupport::TimeWithZone)
        time_str = val.utc.strftime("%Y-%m-%d %H:%M:%S")
        "Time.Zone.parse(\"#{time_str}\")"
      elsif val.is_a?(Time)
        time_int = val.to_i
        "Time.at(#{time_int})"
      elsif val.is_a?(DateTime)
        time_str = val.utc.strftime("%Y-%m-%d %H:%M:%S")
        "DateTime.parse(\"#{time_str}\")"
      else
        "#{val}"
      end
    end
  end
end

