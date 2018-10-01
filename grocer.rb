require "pry"

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
  couponed_cart = {}
  
  cart.collect do |thing, value|
    coupons.each do |single_coupon|
      if thing == single_coupon[:item]
        if !couponed_cart.key?("#{thing} W/COUPON")
          if cart[thing][:count] >= single_coupon[:num]
            cart[thing][:count] -= single_coupon[:num]
            couponed_cart["#{thing} W/COUPON"] = {
              price: single_coupon[:cost], 
              clearance: value[:clearance], 
              count: 1
            }
          end
        else
          if cart[thing][:count] >= single_coupon[:num]
            cart[thing][:count] -= single_coupon[:num]
            couponed_cart["#{thing} W/COUPON"][:count] += 1
          end
        end
      end
    end
  end
  cart.merge(couponed_cart)
end

def apply_clearance(cart)
  cart.collect do |item,data|
    if data[:clearance]
      cart[item][:price] -= cart[item][:price] * 0.2
    end
  end
  cart
end

def checkout(cart, coupons)
  total = 0

  consolidated = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidated, coupons)
  clearance_applied = apply_clearance(coupons_applied)
  
  clearance_applied.each do |item, details|
    total += details[:price] * details[:count]
  end
  
  
  if total > 100
    total -= total * 0.1
  else
    total
  end
end
