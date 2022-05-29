require_relative 'cart_item'

class Cart
  ATTRIBUTES = [:id, :cart_items, :total]
  attr_accessor *ATTRIBUTES

  def initialize(id = nil, products = [])
    @id = id
    @cart_items = []
    
    products.each do |product|
      create_cart_item product
    end
    
    # @products = products

    calculate_total

  #   self.validates
  end

  def validates
      ATTRIBUTES.each do |attribute|
          if self.send(attribute).nil? || self.send(attribute) == ''
              raise StandardError.new "Cart Class: attribute :#{attribute} can't be empty" 
          end
      end
  end

  def add_to_cart product
    create_cart_item product

    calculate_total
  end

  def remove_from_cart product
    remove_cart_item product

    calculate_total
  end
  
  private
  
  def calculate_total
    total = 0
    @cart_items.each do |cart_item|
      total += cart_item.price
    end
    
    @total = total
  end

  def create_cart_item product
    @cart_items << CartItem.new("CI#{product.id}", self, product)
  end

  def remove_cart_item product
    temp_cart_items = @cart_items.reverse
    cart_item_to_remove = temp_cart_items.find {|ci| ci.product_id == product.id}

    temp_cart_items.delete_at(temp_cart_items.index cart_item_to_remove)

    @cart_items = temp_cart_items.reverse
  end
end