module Ingredients
    attr_accessor :total_quantity;

    def set_total_ingredients(ingredients)
        @total_quantity = ingredients;
    end


    def get_total_ingredients
        @total_quantity
    end

    def refill_ingredient(name,quantity)
        @total_quantity[name] = @total_quantity[name]+quantity;
        return [name,@total_quantity[name]]
    end
end