class DepthFinder
    def initialize()

    end

    def load_list() 
        @number_list = Array.new
        File.foreach(File.dirname(__FILE__) + "/input.txt").with_index do |line, line_num|
            @number_list.push line.to_i
        end
        @summed_list = Array.new(3, @number_list[0])
        for i in 1..@number_list.size - 3
            @summed_list[i] += @number_list[i]
            @summed_list[i+1] += @number_list[i]
            @summed_list.append @number_list[i]
        end

        return @summed_list
    end

    def find_increase(array)
        @count_increase = 0
        for i in 1..array.length-1
            if array[i-1] < array[i]
                @count_increase += 1
            end
        end
        return @count_increase
    end
end
@depth_finder = DepthFinder.new
puts "#{@depth_finder.find_increase  @depth_finder.load_list}"