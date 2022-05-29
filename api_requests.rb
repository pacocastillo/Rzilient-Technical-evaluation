require 'json'
require_relative 'colorize'
require_relative 'product'
require_relative 'cart'

class ApiRequest
    def self.call json
        puts "JSON request #{colorize(json)}"

        data = JSON.parse(json)

        products = []
        
        data['ids'].each do |product_id|
            products << PRODUCTS.find {|p| p.id == product_id}
        end

        cart = Cart.new('new_cart', products.flatten)

        {'total': cart.total}.to_json
    end
end

puts "Response #{colorize(ApiRequest.call('{"ids": ["AP1","LN1","HP1","HP1"]}'), 'green')}"

puts "Response #{colorize(ApiRequest.call('{"ids": ["AP1","AP1"]}'), 'green')}"

puts "Response #{colorize(ApiRequest.call('{"ids": ["AP1","LN1","LN1"]}'), 'green')}"

puts "#{colorize('New test with other Discount "Fixed price"')}"
puts "Response #{colorize(ApiRequest.call('{"ids": ["AP1","HP1","HP1","HP1"]}'), 'green')}"