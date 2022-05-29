require_relative 'colorize'
require_relative 'test_methods'
require_relative 'product'

puts ''
puts 'Product'

# Verify valid objects
parse_test do
  verify     true,   is_valid(P1), 'Product p1 valid'
  verify_no  false,  is_valid(P1), 'Product p1 valid'
  verify     true,   is_valid(P2), 'Product p2 valid'
  verify_no  false,  is_valid(P2), 'Product p2 valid'
  verify     true,   is_valid(P3), 'Product p3 valid'
  verify_no  false,  is_valid(P3), 'Product p3 valid'
  verify     false,  is_valid(P4), 'Product p4 invalid'
  verify_no  true,   is_valid(P4), 'Product p4 invalid'
  verify     false,  is_valid(P5), 'Product p5 invalid'
  verify_no  true,   is_valid(P5), 'Product p5 invalid'
  verify     false,  is_valid(P6), 'Product p6 invalid'
  verify_no  true,   is_valid(P6), 'Product p6 invalid'
end

# Verify valid attributes values
parse_test do
  verify     'AP1',              P1.id, 'Product p1 ID'
  verify_no  'AP12',             P1.id, 'Product p1 no ID'
  verify     'Macbook Pro 13',   P1.name, 'Product p1 NAME'
  verify_no  'Macbook Pro 13 2', P1.name, 'Product p1 no NAME'
  verify     60,                 P1.price, 'Product p1 PRICE'
  verify_no  59,                 P1.price, 'Product p1 no PRICE'

  verify     'LN1',               P2.id, 'Product p2 ID'
  verify_no  'LN12',              P2.id, 'Product p2 no ID'
  verify     'Lenovo Thinkpad',   P2.name, 'Product p2 NAME'
  verify_no  'Lenovo Thinkpad 2', P2.name, 'Product p2 no NAME'
  verify     41,                  P2.price, 'Product p2 PRICE'
  verify_no  39,                  P2.price, 'Product p2 no PRICE'

  verify     'HP1',               P3.id, 'Product p3 ID'
  verify_no  'HP12',              P3.id, 'Product p3 no ID'
  verify     'HP 850 G5',         P3.name, 'Product p3 NAME'
  verify_no  'HP 850 G5 2',       P3.name, 'Product p3 no NAME'
  verify     39,                  P3.price, 'Product p3 PRICE'
  verify_no  41,                  P3.price, 'Product p3 no PRICE'
end