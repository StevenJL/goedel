module Goedel
  class Statement
    attr_reader :object, :indent, :force_attributes, :override_attributes

    def initialize(object, options={})
      @object = object
      @force_attributes = options[:force_attributes] || []
      @override_attributes = options[:override_attributes] || {}
      @indent = 2
    end

    def generate
      output_array = [model_instantiate]
      model_attributes.each do |prop, val|
        next unless val
        output_array << "#{" "*indent}#{attr_line(prop, val)}"
      end
      output_array << "#{instance_name}.save"
      output_array.join("\n")
    end

    private

    def attr_line(prop, val)
      Goedel::Line.new(instance_name, prop, val).generate
    end
    
    def model_attributes
      obj_attr = object.attributes
      force_attributes.each do |attr|
        prop = attr.to_s
        val = object.send(attr) 
        obj_attr[prop] = val
      end
      obj_attr.merge(override_attributes)
    end

    def model_instantiate
      "#{instance_name} = #{class_name}.new"
    end

    def class_name
      object.class.to_s 
    end

    def instance_name
      "my_#{object.class.to_s.downcase}"
    end
  end
end


