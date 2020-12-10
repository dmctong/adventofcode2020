# Q1
input = readlines("10.txt")
input = [parse(Int64, a) for a in input]
input = sort(input)
pushfirst!(input, 0)

let 
    the_dict = DefaultDict{Int, Int}(0)
    for a in enumerate(input)
        if a[1] == length(input)
            break
        end
        the_diff = input[a[1]+1] - input[a[1]]
        if the_diff > 3
            break
        end
        the_dict[the_diff] += 1
        if the_diff == 3
            println(input[a[1]+1], " ", input[a[1]])
        end
    end
    the_dict[3] += 1 # last item has a +3
    println(the_dict)
end

# Q2
function get_num_path(input, ptr)
    # base case: if pointer is at end of input, then we are done
    num_path = 0
    if ptr >= length(input) - 1
        num_path = 1
    elseif length(input) == 1
        num_path = 1
    else
        for i in 1:min(3, length(input) - ptr)
            # check if next 3 numbers in input are within 3 (1, 2, or 3)
            if input[ptr + i] - input[ptr] > 3
                continue
            else
                num_path += get_num_path(input, ptr+i)
            end
        end
    end
    return(num_path)
end

input = readlines("10.txt")
input = [parse(Int64, a) for a in input]
input = sort(input)
pushfirst!(input, 0)
push!(input, input[length(input)] + 3)

let 
    the_list = []
    total_paths = 1
    # find every index in input where difference between two values is 3
    for a in enumerate(input)
        if a[1] == length(input)
            break
        end
        the_diff = input[a[1]+1] - input[a[1]]
        if the_diff == 3
            push!(the_list, a[1]+1)
        end
    end
    pushfirst!(the_list, 1) # first window starts from 1
    # for every sublist where |x-y|<3 for all x, y in sublist, find number of paths
    for b in enumerate(the_list)
        if b[2] != 1
            start_window = the_list[b[1] - 1]
            end_window = b[2]-1
            total_paths *= get_num_path(input[start_window:end_window], 1)
        end
    end
    println(total_paths)
end