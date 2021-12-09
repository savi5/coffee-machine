class Machine 
include Beverages;
include Ingredients;
attr_accessor :outlets;
def initialize(n) #initialize machine with N outlets
    @outlets = n
end

def set_total_ingredient(ingredients) 
    #set total ingredients for Machine instance variable total_ingredents in Ingredients module
    set_total_ingredients(ingredients)
end

def add_beverages(name,ingredients)
    # Add beverages , used Strategy pattern to create beverages
     if name == "gingertea" then obj = Gingertea.new(name,ingredients);
     elsif name == "coffee" then obj = Coffees.new(name,ingredients);
     else obj = "Invalid beverage : #{name}"
    end
obj
end

def get_beverages(beverages) #runs in parallel based on N outlets
    begin
    if beverages.size > @outlets then
        raise "Invalid outlets. Maximum outlets : #{@outlets}, given #{beverages.size}"
    else 
        Parallel.map(beverages,in_threads:@outlets) do |beverage|  
        get_beverage(beverage);
        end
    end
    rescue => e
        return e.message
    end
end

def get_beverage(beverage)
ingredients = beverage.get_ingrediants() 
_total_quantity = get_total_ingredients 
_temp_quantity = _total_quantity.clone
for ele in ingredients 
    if ele[1] > _total_quantity[ele[0]] then #using Machine instance object @total_quantity for comparision
    puts "#{beverage.get_name} cannot be prepared as #{ele[0]} is insufficient\n"
    return false
    else
        _temp_quantity[ele[0]] = _temp_quantity[ele[0]] - ele[1];
    end
end
set_total_ingredients(_temp_quantity) #update total ingredients 
puts "#{beverage.get_name} is prepared.\n"
return true  
end

def refill_ingredients(name,quantity)
    refill_ingredient(name,quantity)
end

def running_low  #display ingredients that are running low
    low_quantity = []
    total_quantity = get_total_ingredients
    for ele in get_total_ingredients 
        if ele[1] < 10 then
         low_quantity << ele[0]
        end
    end
    low_quantity
end


end