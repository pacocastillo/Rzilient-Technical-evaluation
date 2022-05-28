class Cart
    ATTRIBUTES = [:id, :products, :total]
    attr_accessor *ATTRIBUTES

    def initialize(id = nil, products = [])
      @id = id
      @products = products

      @total = 0
      products.each do |product|
        @total += product.price
      end

    #   self.validates
    end

    def validates
        ATTRIBUTES.each do |attribute|
            if self.send(attribute).nil? || self.send(attribute) == ''
                raise StandardError.new "Cart Class: attribute :#{attribute} can't be empty" 
            end
        end
    end
end