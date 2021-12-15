def say_hi()
    puts "Hello World!"
end

say_hi()

class Fold_Paper
    @@point_coords = Array.new
    @@fold_instructions = Array.new
    @@max_y = 0
    @@max_x = 0
    def initialize()
        puts Dir.pwd
        File.foreach(File.dirname(__FILE__) + "/input.txt").with_index do |line, line_num|
            unless line.scan(/\d/).empty? 
                if line.include? "fold along"
                    @@fold_instructions.append(Array[(line.include? "x") ? "x" : "y", line.scan(/\d/).join("").to_i])
                else 
                    @@point_coords.append(line.split(',').map { |x| x.scan(/\d/).join("").to_i });
            
                end
            end
        end
        @@point_coords = @@point_coords.sort_by { |x| [x[1], x[0]]}
        findMax()

        @@fold_instructions.each do |line|
            fold(line[0], line[1])
        end
        print_paper()
    end
    def fold(axis, coord)
        @index = axis == "y" ? 1 : 0
        @slimmed_list = @@point_coords.select{ |x| x[@index] < coord }.map{ |x| Array [x[0], x[1]]}
        
        @offset = (axis == "y" ? 
            (@@max_y/2.0) - (@@max_y - coord) : 
            (@@max_x/2.0) - ( @@max_x - coord)
        )
        puts @offset
        @temp_list = @@point_coords.select { |x| x[@index] > coord }
        .map { |x| Array[
            (@index == 0 ? ((@@max_x - x[0] + @offset)) : x[0]), 
            (@index == 1 ? ((@@max_y - x[1] + @offset)) : x[1])
        ]}
        .sort_by { |x| [x[1], x[0]]}
        
        @@point_coords = (@temp_list | @slimmed_list).sort_by { |x| [x[1], x[0]]}
        if axis == "y"
            @@max_y = coord-1
        else
            @@max_x = coord-1
        end
        #print_paper()

    end

    def findMax() 
        @@max_x = @@point_coords.map { |x| x[0] }.max
        @@max_y = @@point_coords.map { |x| x[1]}.max
    end

    def print_paper()
        for y in 0..@@max_y
            for x in 0..@@max_x
                    if(@@point_coords.any? { |item| item[0] == x and item[1] == y})
                        print "#"
                    else
                        print " "
                    end
            end
            puts ""
        end
    end
end


point_coords = Fold_Paper.new()