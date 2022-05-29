require_relative 'colorize'
require_relative 'product'
require_relative 'cart'
require_relative 'discounts'

def is_valid (cart)
  valid = true

  cart.instance_variables.each do |attribute|
    value = cart.instance_variable_get(attribute)
    if value.nil? || value == ''
      valid = false
      # raise StandardError.new "Cart Class: attribute :#{attribute} can't be empty" 
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
puts 'Cart'

p1 = Product.new('AP1', 'Macbook Pro 13', 60)
p2 = Product.new('LN1', 'Lenovo Thinkpad', 41)
p3 = Product.new('HP1', 'HP 850 G5', 39)

c1 = Cart.new('ID1', [])
c2 = Cart.new('ID2', [p2])
c3 = Cart.new('ID3', [p2, p1])
c4 = Cart.new('ID4')

c_sale_11 = Cart.new('ID_sale_11', [p1, p1])
c_sale_111 = Cart.new('ID_sale_111', [p1, p1, p1])
c_sale_22 = Cart.new('ID_sale_22', [p2, p2])
c_sale_222 = Cart.new('ID_sale_222', [p2, p2, p2])
c_sale_112 = Cart.new('ID_sale_112', [p1, p1, p2])
c_sale_122 = Cart.new('ID_sale_122', [p1, p2, p2])
c_sale_1122 = Cart.new('ID_sale_1122', [p1, p1, p2, p2])
c_sale_2222 = Cart.new('ID_sale_2222', [p2, p2, p2, p2])
c_sale_11223 = Cart.new('ID_sale_11223', [p1, p1, p2, p2, p3])
c_sale_1233 = Cart.new('ID_sale_1233', [p1, p2, p3, p3])
c_sale_12333 = Cart.new('ID_sale_12333', [p1, p2, p3, p3, p3])

# Verify valid objects
parse_test do
  verify     true,   is_valid(c1), 'Cart c1 valid'
  verify     true,   is_valid(c2), 'Cart c2 valid'
  verify     true,   is_valid(c3), 'Cart c3 valid'
  verify     true,   is_valid(c4), 'Cart c4 valid'
end

# Verify valid cart prices
parse_test do
  c5 = Cart.new('ID3', [p1])
  c6 = Cart.new('ID3', [p3])
  c7 = Cart.new('ID3', [p3, p1])

  verify     60, c5.total, 'Cart c5 PRICE'
  verify_no  50, c5.total, 'Cart c5 no PRICE'
  verify     39, c6.total, 'Cart c6 PRICE'
  verify_no  40, c6.total, 'Cart c6 no PRICE'
  verify     41, c2.total, 'Cart c2 PRICE'
  verify_no  45, c2.total, 'Cart c2 no PRICE'
  verify     101, c3.total, 'Cart c3 PRICE'
  verify_no  111, c3.total, 'Cart c3 no PRICE'
  verify     99, c7.total, 'Cart c7 PRICE'
  verify_no  90, c7.total, 'Cart c7 no PRICE'
  verify     0,  c1.total, 'Cart c1 PRICE'
  verify_no  1,  c1.total, 'Cart c1 no PRICE'
end

# Verify valid cart prices with sales
parse_test do
  # c_sale_11
  # c_sale_111
  # c_sale_22
  # c_sale_222
  # c_sale_112
  # c_sale_1122
  # c_sale_2222
  # c_sale_11223
  verify     108, c_sale_11.total, 'Cart c_sale_11 PRICE'
  verify_no  120, c_sale_11.total, 'Cart c_sale_11 no PRICE'
  verify     162, c_sale_111.total, 'Cart c_sale_111 PRICE'
  verify_no  180, c_sale_111.total, 'Cart c_sale_111 no PRICE'
  verify     41,  c_sale_22.total, 'Cart c_sale_22 PRICE'
  verify_no  82,  c_sale_22.total, 'Cart c_sale_22 no PRICE'
  verify     82,  c_sale_222.total, 'Cart c_sale_222 PRICE'
  verify_no  123, c_sale_222.total, 'Cart c_sale_222 no PRICE'
  verify     149, c_sale_112.total, 'Cart c_sale_112 PRICE'
  verify_no  161, c_sale_112.total, 'Cart c_sale_112 no PRICE'
  verify     101, c_sale_122.total, 'Cart c_sale_122 PRICE'
  verify_no  142, c_sale_122.total, 'Cart c_sale_122 no PRICE'
  verify     149, c_sale_1122.total, 'Cart c_sale_1122 PRICE'
  verify_no  202, c_sale_1122.total, 'Cart c_sale_1122 no PRICE'
  verify     82, c_sale_2222.total, 'Cart c_sale_2222 PRICE'
  verify_no  164, c_sale_2222.total, 'Cart c_sale_2222 no PRICE'
  verify     188, c_sale_11223.total, 'Cart c_sale_11223 PRICE'
  verify_no  241, c_sale_11223.total, 'Cart c_sale_11223 no PRICE'
  verify     179, c_sale_1233.total, 'Cart c_sale_1233 PRICE'
  verify_no  180, c_sale_1233.total, 'Cart c_sale_1233 no PRICE'
  verify     203, c_sale_12333.total, 'Cart c_sale_12333 PRICE'
  verify_no  218, c_sale_12333.total, 'Cart c_sale_12333 no PRICE'
end

# Verify valid cart prices after add_to_cart
parse_test do
  c1.add_to_cart p1
  verify     60, c1.total, 'Cart c1 add_to_cart PRICE'
  verify_no  50, c1.total, 'Cart c1 add_to_cart no PRICE'

  c1.add_to_cart p1
  verify     108, c1.total, 'Cart c1 add_to_cart PRICE'
  verify_no  120, c1.total, 'Cart c1 add_to_cart no PRICE'

  c1.add_to_cart p2
  verify     149, c1.total, 'Cart c1 add_to_cart PRICE'
  verify_no  161, c1.total, 'Cart c1 add_to_cart no PRICE'

  c1.remove_from_cart p1
  verify     101, c1.total, 'Cart c1 remove_from_cart PRICE'
  verify_no  100, c1.total, 'Cart c1 remove_from_cart no PRICE'
end