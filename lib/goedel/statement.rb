module Goedel
  class Statement
    attr_reader :options

    def intialize(options)
      @options = options
      @indent = 2
    end

    def generate
      output_array = [model_create]
      model_attributes.each do |prop, val|
        output_array << attr_line(prop, val)
      end
      output_array << ")"
      output_array.join("\n")
    end

    private

    def attr_line(prop, val)
      Goedel::Line.new(
        property: prop,
        value: val
       ).generate
    end
    
    def object
      options[:object]
    end
    
    def model_attributes
      object.attributes
       
    end

    def model_create
      "#{options[:model]}.create("
    end
  end
end

