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

  def self.apply_discounts temp_cart_items
    DISCOUNTS.each do |discount|
      if !temp_cart_items[discount.product_id].nil? # we have products on cart that maybe we can apply discount
        quantity_to_apply = 0
        type = nil
        if discount.product_quantity_to_apply.to_s.include?('+')
          type = 'plus'
          quantity_to_apply = discount.product_quantity_to_apply.delete('+').to_i
        else
          quantity_to_apply = discount.product_quantity_to_apply
        end

        # Maybe on remove_cart_item no apply previous sale_price
        temp_cart_items[discount.product_id].collect do |c_item|
          c_item.sale_price = nil
        end

        if temp_cart_items[discount.product_id].size >= quantity_to_apply
          temp_cart_items[discount.product_id].each_with_index.collect do |c_item, i|
            
            if (type == 'plus') || ( (i+1)%quantity_to_apply == 0 )
                if discount.discount_type == 'fixed'
                  c_item.sale_price = c_item.price - discount.amount               
                elsif discount.discount_type == 'percent'
                  c_item.sale_price = c_item.price * (1 - discount.amount.to_f/100)
                end
            end

            c_item.sale_price = nil unless !c_item.sale_price.nil? && c_item.sale_price >= 0
          end
        end
      end
    end

    temp_cart_items
  end
end

dln1   = Discount.new('DLN1', 'percent', 'LN1', 2, 100)
dap1   = Discount.new('DAP1', 'percent', 'AP1', '2+', 10)
dhp1   = Discount.new('DHP1', 'fixed', 'HP1', '3+', 5)

DISCOUNTS = [dln1, dap1, dhp1]