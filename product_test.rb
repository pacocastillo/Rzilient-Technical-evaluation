require_relative 'colorize'
require_relative 'product'

def is_valid (product)
  valid = true

  product.instance_variables.each do |attribute|
    value = product.instance_variable_get(attribute)
    if value.nil? || value == ''
      valid = false
      # raise StandardError.new "Product Class: attribute :#{attribute} can't be empty" 
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
puts 'Product'

p1 = Product.new('AP1', 'Macbook Pro 13', 60)
p2 = Product.new('LN1', 'Lenovo Thinkpad', 41)
p3 = Product.new('HP1', 'HP 850 G5', 39)
p4 = Product.new('', 'HP 850 G5', 39)
p5 = Product.new('HP1', '', 39)
p6 = Product.new('HP1', 'HP 850 G5')

# Verify valid objects
parse_test do
  verify     true,   is_valid(p1), 'Product p1 valid'
  verify_no  false,  is_valid(p1), 'Product p1 valid'
  verify     true,   is_valid(p2), 'Product p2 valid'
  verify_no  false,  is_valid(p2), 'Product p2 valid'
  verify     true,   is_valid(p3), 'Product p3 valid'
  verify_no  false,  is_valid(p3), 'Product p3 valid'
  verify     false,  is_valid(p4), 'Product p4 invalid'
  verify_no  true,   is_valid(p4), 'Product p4 invalid'
  verify     false,  is_valid(p5), 'Product p5 invalid'
  verify_no  true,   is_valid(p5), 'Product p5 invalid'
  verify     false,  is_valid(p6), 'Product p6 invalid'
  verify_no  true,   is_valid(p6), 'Product p6 invalid'
end

# Verify valid attributes values
parse_test do
  verify     'AP1',              p1.id, 'Product p1 ID'
  verify_no  'AP12',             p1.id, 'Product p1 no ID'
  verify     'Macbook Pro 13',   p1.name, 'Product p1 NAME'
  verify_no  'Macbook Pro 13 2', p1.name, 'Product p1 no NAME'
  verify     60,                 p1.price, 'Product p1 PRICE'
  verify_no  59,                 p1.price, 'Product p1 no PRICE'

  verify     'LN1',               p2.id, 'Product p2 ID'
  verify_no  'LN12',              p2.id, 'Product p2 no ID'
  verify     'Lenovo Thinkpad',   p2.name, 'Product p2 NAME'
  verify_no  'Lenovo Thinkpad 2', p2.name, 'Product p2 no NAME'
  verify     41,                  p2.price, 'Product p2 PRICE'
  verify_no  39,                  p2.price, 'Product p2 no PRICE'

  verify     'HP1',               p3.id, 'Product p3 ID'
  verify_no  'HP12',              p3.id, 'Product p3 no ID'
  verify     'HP 850 G5',         p3.name, 'Product p3 NAME'
  verify_no  'HP 850 G5 2',       p3.name, 'Product p3 no NAME'
  verify     39,                  p3.price, 'Product p3 PRICE'
  verify_no  41,                  p3.price, 'Product p3 no PRICE'
end