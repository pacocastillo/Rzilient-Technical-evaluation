class Cart
  ATTRIBUTES = [:id, :products, :total]
  attr_accessor *ATTRIBUTES

  def initialize(id = nil, products = [])
    @id = id
    @products = products

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
    @products << product

    calculate_total
  end

  def remove_from_cart product
    @products.delete_at(@products.index product)

    calculate_total
  end

  private

  def calculate_total
    total = 0
    @products.each do |product|
      total += product.price
    end

    @total = total
  end
end