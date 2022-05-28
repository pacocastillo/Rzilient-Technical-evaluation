class Product
    ATTRIBUTES = [:id, :name, :price]
    attr_accessor *ATTRIBUTES

    def initialize(id = nil, name = nil, price = nil)
      @id = id
      @name = name
      @price = price

    #   self.validates
    end

    def validates
        ATTRIBUTES.each do |attribute|
            if self.send(attribute).nil? || self.send(attribute) == ''
                raise StandardError.new "Product Class: attribute :#{attribute} can't be empty" 
            end
        end
    end
end