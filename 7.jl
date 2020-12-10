using DataStructures



# Q1
function get_bag_dict(input)
    bag_dict = DefaultDict{String, Vector{Tuple}}([])
    for line in input
        key = split(line, " contain ")[1]
        key_adj = split(match(r"[a-z ]+", key).match, " ")[begin]
        key_colour = split(match(r"[a-z ]+", key).match, " ")[begin+1]
        key = string(key_adj, " ", key_colour)
        value = split(line, " contain ")[2]
        println(key, " ", value)
        # test for empty
        if value == "no other bags."
            push!(bag_dict[key], ("NO BAG", 0))
        else
            # break into nums and bags
            for bag in split(value[begin:end-1], ", ")
                num = parse(Int64, match(r"[0-9]*", bag).match)
                adj = split(match(r"[a-z ]+", bag).match, " ")[begin+1]
                colour = split(match(r"[a-z ]+", bag).match, " ")[begin+2]
                bag_type = string(adj, " ", colour)
                push!(bag_dict[key], (bag_type, num))
            end
        end
        println(key, ": ", bag_dict[key])
    end
    return(bag_dict)
end

function get_all_matches(bag_dict, bag_to_check = "shiny gold")
    all_matches = []
    new_array_to_check = []
    array_to_check = []
    push!(array_to_check, bag_to_check)
    while length(array_to_check) > 0
        for key in keys(bag_dict)
            for check in array_to_check
                if check in [a[1] for a in bag_dict[key]]
                    push!(new_array_to_check, key)
                    push!(all_matches, key)
                    println(key, " ", check)
                    println(new_array_to_check)
                end
            end
        end
        array_to_check = new_array_to_check
        new_array_to_check = []
    end
    return(length(Set(all_matches)))
end

input = readlines("7.txt")
bag_dict = get_bag_dict(input)
get_all_matches(bag_dict)

# Q2
function get_num_bags(target_bag, bag_dict, memo)
    num_bag = 0
    # base case: no other bags
    if bag_dict[target_bag][1][1] == "NO BAG" || !(target_bag in keys(bag_dict))
        num_bag = 1
        memo[target_bag] = 1
    else
        for new_target in bag_dict[target_bag]
            new_target_type = new_target[1]
            new_target_num  = new_target[2]
            if new_target_type in keys(memo)
                num_bags_in_target = memo[new_target_type]
            else
                output = get_num_bags(new_target_type, bag_dict, memo)
                num_bags_in_target = output[1]
                memo = output[2]
            end
            if bag_dict[new_target_type][1][1] == "NO BAG"
                num_bag += new_target_num * num_bags_in_target
            else
                num_bag += new_target_num + new_target_num * num_bags_in_target
            end
        end
    end
    memo[target_bag] = num_bag
    return(num_bag, memo)
end

input = readlines("7.txt")
bag_dict = get_bag_dict(input)
memo = DefaultDict{String, Int}(0)
output = get_num_bags("shiny gold", bag_dict, memo)

output[1]

# DEBUGGING:
# shiny gold
    # mirrored orange                   2*1 + 1*1 + (1 + 442)
        # 2 light brown                     1
        # 1 drab tomato                     1
        # 1 muted beige                     442 = 4 + (2 + 2*17) + (3 + 3*111) + (3 + 3*21)
            # 4 drab tomato                     4 = 4*1
            # 2 dull aqua                       17 = 2*8 + 1
                # 1 drab lavender                   8 = (2*1 + 1*1 + 5*1)
                    # 2 plaid blue                      1
                    # 1 drab tomato                     1
                    # 5 clear brown                     1
            # 3 pale tomato                     111 = 108 + 3
                # 3 wavy tan                        108 = 3 * (24 + 4 + 3*1 + 1*1 + 4*1)
                    # 4 dull olive                      24 = 4 * (2*1 + 2*1 + 2*1)
                        # 2 bright duchsia                  2*1    
                        # 2 faded cyan                      2*1
                        # 2 stripped crimson                2*1
                    # 3 faded cyan                      3*1
                    # 1 dim maroon                      1*1
                    # 4 stripped crimson                4*1
            # 3 drab coral                      21 = 3 * (3*1 + 4*1)
                # 3 light brown                     3*1
                # 4 stripped crimson                4*1

# output = get_num_bags("mirrored orange", bag_dict, memo)[1]



