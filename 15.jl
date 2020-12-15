#Q1
input_array = [7,14,0,17,11,1,2]

let
    answer = 0
    for i in 8:2020
        # has last number been spoken? if it has, what position was it spoken in?
        last_match_index = indexin(input_array[i-1], reverse(input_array[begin:i-2]))[]
        if last_match_index == nothing
            answer = 0
        else
            answer = last_match_index
        end
        push!(input_array, answer)
    end
    println(input_array[end])
end

# Q2

# fine we'll do it with a dict
input_array = [7, 14, 0, 17, 11, 1, 2]

let
    in_dict = DefaultDict{Int, Int}(0) 
    for i in 1:length(input_array)-1
        in_dict[input_array[i]] = i
    end
    consider_num = input_array[end]
    next_num = 0
    for i in length(input_array)+1:30000000
        if in_dict[consider_num] == 0
            next_num = 0
        else
            next_num = i - in_dict[consider_num] - 1
        end
        in_dict[consider_num] = i-1
        consider_num = next_num
    end
    println(next_num)
end