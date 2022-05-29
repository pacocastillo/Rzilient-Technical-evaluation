require_relative 'colorize'
require_relative 'product'
require_relative 'cart'
require_relative 'cart_item'

def is_valid (cart_item)
  valid = true

  cart_item.instance_variables.each do |attribute|
    value = cart_item.instance_variable_get(attribute)
    if value.nil? || value == ''
      valid = false
      # raise StandardError.new "CartItem Class: attribute :#{attribute} can't be empty" 
    end
  end

  valid
end

def verify (expected, actual, method)
  if actual == expected
    puts "  #{colorize("#{method} passed", 'green')}"
  else
    puts "  #{colorize("#{method} failed", 'red')}"
    puts "    #{colorize("Expected : #{expected} but got : #{actual}", 'red')}"
  end
end

def verify_no (expected, actual, method)
  if actual != expected
    puts "  #{colorize("#{method} passed", 'green')}"
  else
    puts "  #{colorize("#{method} failed", 'red')}"
    puts "    #{colorize("Expected : #{expected} but got : #{actual}", 'red')}"
  end
end

def parse_test
  begin
    yield
  rescue StandardError => e
    puts "#{colorize("Got an exception with message: #{e.message}", 'red')}"
    puts "#{colorize(e.backtrace, 'red')}"
  end
end

puts ''
puts 'Cart Item'

c1 = Cart.new('ID1', [])

p1 = Product.new('AP1', 'Macbook Pro 13', 60)
p2 = Product.new('LN1', 'Lenovo Thinkpad', 41)
p3 = Product.new('HP1', 'HP 850 G5', 39)

ci1 =     CartItem.new('CI1', c1, p1)
ci2 =     CartItem.new('CI2', c1, p2)
ci3 =     CartItem.new('CI3', c1, p3)
ci1_no =  CartItem.new('CI1no', nil, p3)
ci2_no =  CartItem.new('CI2no', c1, nil)

# Verify valid objects
parse_test do
  verify     true,   is_valid(ci1), 'Cart Item ci1 valid'
  verify_no  false,  is_valid(ci1), 'Cart Item ci1 valid'
  verify     true,   is_valid(ci2), 'Cart Item ci2 valid'
  verify_no  false,  is_valid(ci2), 'Cart Item ci2 valid'
  verify     true,   is_valid(ci3), 'Cart Item ci3 valid'
  verify_no  false,  is_valid(ci3), 'Cart Item ci3 valid'
  verify     false,  is_valid(ci1_no), 'Cart Item ci1_no no valid'
  verify     false,  is_valid(ci2_no), 'Cart Item ci2_no no valid'
end

# Verify valid cart item prices and product_id
parse_test do
  verify     60,     ci1.price, 'Cart Item ci1 PRICE'
  verify_no  50,     ci1.price, 'Cart Item ci1 no PRICE'
  verify     'AP1',  ci1.product_id, 'Cart Item ci1 PRODUCT_ID'
  verify_no  'AP1n', ci1.product_id, 'Cart Item ci1 no PRODUCT_ID'
  verify     41,     ci2.price, 'Cart Item ci2 PRICE'
  verify_no  40,     ci2.price, 'Cart Item ci2 no PRICE'
  verify     'LN1',  ci2.product_id, 'Cart Item ci2 PRODUCT_ID'
  verify_no  'LN1n', ci2.product_id, 'Cart Item ci2 no PRODUCT_ID'
  verify     39,     ci3.price, 'Cart Item ci3 PRICE'
  verify_no  45,     ci3.price, 'Cart Item ci3 no PRICE'
  verify     'HP1',  ci3.product_id, 'Cart Item ci3 PRODUCT_ID'
  verify_no  'HP1n', ci3.product_id, 'Cart Item ci3 no PRODUCT_ID'
end