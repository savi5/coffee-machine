require 'rails_helper'

describe 'Machine' do
    context 'Valid Parallel execution' do
        it 'Valid two parallel coffee execution for machine with 2 outlets' do
            puts "\n\nValid two parallel coffee execution for machine with 2 outlets"
            m=Machine.new(2)
            m.set_total_ingredient({"ginger"=>10,"coffee"=>10,"water"=>200,"hot_milk"=>100})
            coffee = m.add_beverages("coffee",{"coffee"=>5,"water"=>50,"hot_milk"=>50})
            ginger = m.add_beverages("gingertea",{"ginger"=>5,"water"=>50,"hot_milk"=>50})
            expect(m.get_beverages([coffee,coffee])).to eql [true,true]
        end

        it 'Valid single gingertea execution for machine with 2 outlets' do
            puts "\n\nValid single gingertea execution for machine with 2 outlets"
            m=Machine.new(2)
            m.set_total_ingredient({"ginger"=>10,"coffee"=>10,"water"=>200,"hot_milk"=>100})
            gingertea = m.add_beverages("gingertea",{"ginger"=>5,"water"=>50,"hot_milk"=>50})
            expect(m.get_beverages([gingertea])).to eql [true]
        end

        it 'Setting total ingredients' do
            puts "\n\nSetting total ingredients"
            m=Machine.new(2)
            m.set_total_ingredient({"ginger"=>10,"coffee"=>10,"water"=>200,"hot_milk"=>100})
            expect(m.get_total_ingredients).to eql ({"ginger"=>10,"coffee"=>10,"water"=>200,"hot_milk"=>100})
        end

        it 'Refilling ginger ingredient' do
            puts "\n\nRefilling ginger ingredient"
            m=Machine.new(2)
            m.set_total_ingredient({"ginger"=>10,"coffee"=>10,"water"=>200,"hot_milk"=>100})
            expect(m.refill_ingredients("ginger",10)).to eql ["ginger",20]
        end

        it 'Running low ginger ingredient' do
            puts "\n\nRunning low ginger ingredient"
            m=Machine.new(2)
            m.set_total_ingredient({"ginger"=>5,"coffee"=>10,"water"=>200,"hot_milk"=>100})
            expect(m.running_low).to eql ["ginger"]
        end

        it 'Ginger tea beverage object creation' do
            puts "\n\nGinger tea beverage object creation"
            m=Machine.new(2)
            expect(m.add_beverages("gingertea",{"ginger"=>5,"water"=>50,"hot_milk"=>50})).to be_instance_of Gingertea
        end

        it 'Coffee beverage object creation' do
            puts "\n\nCoffee beverage object creation"
            m=Machine.new(2)
            expect(m.add_beverages("coffee",{"coffee"=>5,"water"=>50,"hot_milk"=>50})).to be_instance_of Coffees
        end

        it 'Executing different beverages parallely' do
            puts "\n\nExecuting different beverages parallely"
            m=Machine.new(3)
            m.set_total_ingredient({"ginger"=>10,"coffee"=>10,"water"=>300,"hot_milk"=>200})
            coffee = m.add_beverages("coffee",{"coffee"=>5,"water"=>50,"hot_milk"=>50})
            ginger = m.add_beverages("gingertea",{"ginger"=>5,"water"=>50,"hot_milk"=>50})
            expect(m.get_beverages([ginger,coffee,coffee])).to eql [true,true,true]
        end
    end
    
    context 'Invalid executions' do
        it 'InValid 3 parallel coffee execution for machine with 2 outlets' do
            puts "\n\nInValid 3 parallel coffee execution for machine with 2 outlets"
            m=Machine.new(2)
            m.set_total_ingredient({"ginger"=>10,"coffee"=>10,"water"=>200,"hot_milk"=>100})
            coffee = m.add_beverages("coffee",{"coffee"=>5,"water"=>50,"hot_milk"=>50})
            expect(m.get_beverages([coffee,coffee,coffee])).to eql ("Invalid outlets. Maximum outlets : 2, given 3")
        end

        it 'Insufficient coffee' do
            puts "\n\nInsufficient coffee"
            m=Machine.new(3)
            m.set_total_ingredient({"ginger"=>10,"coffee"=>10,"water"=>200,"hot_milk"=>100})
            coffee = m.add_beverages("coffee",{"coffee"=>5,"water"=>50,"hot_milk"=>50})
            expect(m.get_beverages([coffee,coffee,coffee]).sort_by{|e| e ? 1 : 0}).to eql [false,true,true]
        end

        it 'Refilling ginger ingredient' do
            puts "\n\nRefilling ginger ingredient"
            m=Machine.new(2)
            m.set_total_ingredient({"ginger"=>10,"coffee"=>10,"water"=>200,"hot_milk"=>100})
            expect(m.refill_ingredients("ginger",10)).not_to eql ["ginger"]
        end

        it 'Invalid beverage object creation' do
            puts "\n\nInvalid beverage object creation"
            m=Machine.new(2)
            expect(m.add_beverages("abcss",{"askdje"=>5,"asd"=>50,"adj"=>50})).to eql ("Invalid beverage : abcss")
        end

        it 'Executing same beverages parallely with insufficient ingredient coffee' do
            puts "\n\nExecuting same beverages parallely with insufficient ingredient coffee"
            m=Machine.new(3)
            m.set_total_ingredient({"ginger"=>10,"coffee"=>10,"water"=>100,"hot_milk"=>200})
            coffee = m.add_beverages("coffee",{"coffee"=>5,"water"=>50,"hot_milk"=>50})
            expect(m.get_beverages([coffee,coffee,coffee]).sort_by{|e| e ? 1 : 0}).to eql [false,true,true]
        end

        it 'Executing different beverages parallely with insufficient common ingredient water' do
            puts "\n\nExecuting different beverages parallely with insufficient common ingredient water"
            m=Machine.new(3)
            m.set_total_ingredient({"ginger"=>10,"coffee"=>10,"water"=>100,"hot_milk"=>200})
            coffee = m.add_beverages("coffee",{"coffee"=>5,"water"=>50,"hot_milk"=>50})
            ginger = m.add_beverages("gingertea",{"ginger"=>5,"water"=>50,"hot_milk"=>50})
            expect(m.get_beverages([ginger,coffee,ginger]).sort_by{|e| e ? 1 : 0}).to eql [false,true,true]
        end
    end

end