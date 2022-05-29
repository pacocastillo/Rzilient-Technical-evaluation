require_relative 'colorize'
require_relative 'test_methods'
require_relative 'product'
require_relative 'cart'
require_relative 'discounts'

puts ''
puts 'Discounts'

d11   = Discount.new('D11', 'fixed',   'AP1', 2, 5)
d12   = Discount.new('D12', 'percent', 'AP1', 2, 5)
d1no  = Discount.new('D12', 'other',   'AP1', 2, 5)
d21   = Discount.new('D21', 'fixed',   'LN1', 2, 5)
d22   = Discount.new('D22', 'percent', 'LN1', 2, 5)
d2no  = Discount.new('D22', 'other',   'LN1', 2, 5)
d31   = Discount.new('D31', 'fixed',   'HP1', 2, 5)
d32   = Discount.new('D32', 'percent', 'HP1', 2, 5)
d3no  = Discount.new('D32', 'other',   'HP1', 2, 5)

# Verify valid objects
parse_test do
  verify     true,   is_valid(d11),  'Discount d11 valid'
  verify     true,   is_valid(d12),  'Discount d12 valid'
  verify     false,  is_valid(d1no), 'Discount d1no no valid'
  verify     true,   is_valid(d21),  'Discount d21 valid'
  verify     true,   is_valid(d22),  'Discount d22 valid'
  verify     false,  is_valid(d2no), 'Discount d2no no valid'
  verify     true,   is_valid(d31),  'Discount d31 valid'
  verify     true,   is_valid(d32),  'Discount d32 valid'
  verify     false,  is_valid(d3no), 'Discount d3no no valid'
end