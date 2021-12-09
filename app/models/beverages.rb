module Beverages
    class Beverages 
        attr_accessor :name,:ingredients;
        
        def initialize(name,ingredients)
            @name =name;
            @ingredients = ingredients;
        end
        def get_beverage_ingrediants()
            return get_ingrediants
        end
    end
    
end


class Gingertea < Beverages::Beverages 
    attr_accessor :name,:ingredients;
    def initialize(name,ingredients)
        @name =name;
        @ingredients = ingredients;
        super(name,ingredients)
    end
    def get_ingrediants
        @ingredients
    end

    def get_name 
        @name
    end
    
end

class Coffees < Beverages::Beverages 
    attr_accessor :name,:ingredients;
    def initialize(name,ingredients)
        @name = name;
        @ingredients = ingredients;
        super(name,ingredients)
    end

    def get_ingrediants
        @ingredients
    end

    def get_name 
        @name
    end
end







  