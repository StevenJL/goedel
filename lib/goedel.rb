$:.unshift File.expand_path("../", __FILE__)

module Goedel
  autoload :VERSION, "goedel/version"
  autoload :Statement, "goedel/statement"
  autoload :Line, "goedel/line"

  def self.goedel(object)
    result_string = Goedel::Statement.new(object).generate
    puts result_string
    result_string
  end
end

