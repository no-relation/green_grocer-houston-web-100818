require.pry

def consolidate_cart(cart)
  counted_cart = {}

  # cart is an array, so
  cart.each do |item|
    #each item in cart is a hash, so
    item.each do |k,v|      
      #if the key of the item isn't already in counted_cart
      if !counted_cart.key?(k)
        #create in counted_cart => {k => v, :count => 1}
        counted_cart[k] = v.merge({count: 1})
      #else, if the key IS in counted_cart
      elsif counted_cart.key?(k)
        #add 1 to :count
        counted_cart[k][:count] += 1

      end
    end
  end
  counted_cart
end

def apply_coupons(cart, coupons)

end

def apply_clearance(cart)

end

def checkout(cart, coupons)

end
