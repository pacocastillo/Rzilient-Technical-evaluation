class CartItem
  ATTRIBUTES = [:id, :cart, :product_id, :name, :price, :sale_price, :discount]
  attr_accessor *ATTRIBUTES

  def initialize(id = nil, cart = nil, product = nil)
    @id = id
    @cart = cart
    @product_id = !product.nil? ? product.id : nil
    @name = !product.nil? ? product.name : nil
    @price = !product.nil? ? product.price : nil
    @sale_price = nil

  #   self.validates
  end

  def validates
      ATTRIBUTES.each do |attribute|
          if self.send(attribute).nil? || self.send(attribute) == ''
              raise StandardError.new "Cart Item Class: attribute :#{attribute} can't be empty" 
          end
      end
  end
end