
    def load_list
        @direction_list = [0,0,0]
        File.foreach(File.dirname(__FILE__) + "/input.txt").with_index do |line, line_num|
            line.split(" ").each_slice(2) do |direction, number|
                case direction
                    when "up"
                            @direction_list[0] -= number.to_i
                    when "down"
                        @direction_list[0] += number.to_i
                    when "forward" 
                        @direction_list[1] += number.to_i
                        @direction_list[2] += @direction_list[0] * number.to_i
                    end
                end
        end
        return @direction_list[2] * @direction_list[1]
    end

puts load_list