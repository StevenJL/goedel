require "pry"
$:.unshift File.expand_path("../", __FILE__)
require "goedel/version"

module Goedel
  autoload :VERSION, "goedel/version"
  autoload :Statement, "goedel/statement"

  def self.goedel(options)
    model = options[:model]
    excludes = options[:excludes]
    data = options[:data]

    result_string = Goedel::Statement.new(options).generate
    puts result_string
    result_string
  end
end

