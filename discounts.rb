class Discount
  DISCOUNT_TYPES = %w[fixed percent].freeze

  ATTRIBUTES = [:id, :discount_type, :product_id, :product_quantity_to_apply, :amount]
  attr_accessor *ATTRIBUTES

  def initialize( id = nil,
                  discount_type = 'fixed', 
                  product_id = nil, 
                  product_quantity_to_apply = 2, 
                  amount = 0)
    @id = id
    @discount_type = DISCOUNT_TYPES.include?(discount_type) ? discount_type : nil
    @product_id = product_id
    @product_quantity_to_apply = product_quantity_to_apply
    @amount = amount
  #   self.validates
  end

  def validates
      ATTRIBUTES.each do |attribute|
          if self.send(attribute).nil? || self.send(attribute) == ''
              raise StandardError.new "Discount Class: attribute :#{attribute} can't be empty" 
          end
      end
  end 
end