module Goedel
  class Statement
    attr_reader :object, :indent, :force_attributes

    def initialize(object, options={})
      @object = object
      @force_attributes = options[:force_attributes] || []
      @indent = 2
    end

    def generate
      output_array = [model_create]
      model_attributes.each do |prop, val|
        output_array << "#{" "*indent}#{attr_line(prop, val)}"
      end
      output_array << ")"
      output_array.join("\n")
    end

    private

    def attr_line(prop, val)
      Goedel::Line.new(prop, val).generate
    end
    
    def model_attributes
      obj_attr = object.attributes
      force_attributes.each do |attr|
        prop = attr.to_s
        val = object.send(attr) 
        obj_attr[prop] = val
      end
      obj_attr
    end

    def model_create
      "#{object.class}.create("
    end
  end
end

