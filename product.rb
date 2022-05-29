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

P1 = Product.new('AP1', 'Macbook Pro 13', 60)
P2 = Product.new('LN1', 'Lenovo Thinkpad', 41)
P3 = Product.new('HP1', 'HP 850 G5', 39)
P4 = Product.new('', 'HP 850 G5', 39)
P5 = Product.new('HP1', '', 39)
P6 = Product.new('HP1', 'HP 850 G5')

PRODUCTS = [P1, P2, P3, P4, P5, P6]