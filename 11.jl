#Q1
input1 = readlines("test1.txt")
input2 = readlines("test2.txt")

for line in enumerate(input1)
    if line[2] == input2[line[1]]
        println("MATCH")
    else
        println("NOT MATCH: ROW ", line[1])
        println(line[2])
        println(input2[line[1]])
    end
end


input = readlines("11.txt")
# input = readlines("11-2.txt")

# pad input
# every existing row adds a dot to the start and end
padded = [string(".", a, ".") for a in input]
# first row is all dots
pushfirst!(padded, repeat(".", length(padded[1])))
# last row is all dots
push!(padded, repeat(".", length(padded[1])))

# simulate one step
    # for each position in input_seat_state
        # if floor, do nothing
        # if empty seat, check empty conditions, output new seat state
        # if full seat, check full conditions, output new seat state
    # return new seat state

function check_empty(seat_list)
    # if no occupied seats next to it, seat becomes occupied
    if all([a == '.' || a == 'L' for a in seat_list])
        new_seat = '#'
    else
        new_seat = 'L'
    end
    return(new_seat)
end

function check_full(seat_list)
    # if four or more seats adj are occupied, seat becomes empty
    if sum(seat_list .== '#') >= 4
        new_seat = 'L'
    else
        new_seat = '#'
    end
    return(new_seat)
end

function get_neighbours(padded, row_num, col_num)
    up_left = padded[row_num-1][col_num-1]
    up_cent = padded[row_num-1][col_num]
    up_right = padded[row_num-1][col_num+1]
    mid_left = padded[row_num][col_num-1]
    mid_right = padded[row_num][col_num+1]
    down_left = padded[row_num+1][col_num-1]
    down_cent = padded[row_num+1][col_num]
    down_right = padded[row_num+1][col_num+1]
    return([up_left, up_cent, up_right, mid_left, mid_right, down_left, down_cent, down_right])
end

let 
    input = readlines("11.txt")
    # pad input
    # every existing row adds a dot to the start and end
    padded = [string(".", a, ".") for a in input]
    # first row is all dots
    pushfirst!(padded, repeat(".", length(padded[1])))
    # last row is all dots
    push!(padded, repeat(".", length(padded[1])))
    empty_seats = repeat(".", length(padded[1]))
    next_padded = [empty_seats for a in 1:length(padded)]
    i = 0
    println("=========0============")
    for thing in padded
        println(thing)
    end
    while i < 100
    # for i in 1:6
        i += 1
        println("=========", i, "============")
        for line in enumerate(padded)
            row_num = line[1]
            seats = line[2]
            max_row_num = length(padded)
            max_col_num = length(padded[1])
            for col_num in 1:length(seats)
                if row_num == 1 || row_num == max_row_num || col_num == 1 || col_num == max_col_num
                    continue
                end
                if seats[col_num] == '.'
                    continue
                else
                    neighbours = get_neighbours(padded, row_num, col_num)
                    if seats[col_num] == 'L'
                        new_seat = check_empty(neighbours)
                    else
                        new_seat = check_full(neighbours)
                    end
                    next_padded[row_num] = string(next_padded[row_num][begin:col_num-1], new_seat, next_padded[row_num][col_num+1:end])
                end
            end
        end
        for thing in next_padded
            println(thing)
        end
        if padded == next_padded
            println("MATCH")
            occupied_seats = 0
            for line in padded
                for the_char in line
                    if the_char == '#'
                        occupied_seats +=1
                    end
                end
            end
            println(occupied_seats)
            break
        end
        padded = next_padded
        next_padded = [empty_seats for a in 1:length(padded)]
    end
end



test = ['.','L','.', 'O']
all([a == '.' || a == 'L' for a in test])

test2 = ['.','L','.']
all([a == '.' || a == 'L' for a in test2])

test = ['#', '#', '#', '#', 'L']
sum(test .== '#')

test2 = ['#', '#', '#', 'L', '.']
sum(test2 .== '#')

let
    sum = 0
    test = ".#.#L.L#.##."
    for a in test
        if a == '#'
            sum += 1
        end
    end
    println(sum)
end

# Q2

# line of sight until either end of max input or L or # reached -- changes get_neighbours

function check_empty(seat_list)
    # if no occupied seats next to it, seat becomes occupied
    if all([a == '.' || a == 'L' for a in seat_list])
        new_seat = '#'
    else
        new_seat = 'L'
    end
    return(new_seat)
end

function check_full(seat_list)
    # if four or more seats adj are occupied, seat becomes empty
    if sum(seat_list .== '#') >= 5
        new_seat = 'L'
    else
        new_seat = '#'
    end
    return(new_seat)
end

function get_unlimited_neighbours(padded, row_num, col_num)
    up_left = get_up_left(padded, row_num, col_num)
    up_cent = get_up_cent(padded, row_num, col_num)
    up_right = get_up_right(padded, row_num, col_num)
    mid_left = get_mid_left(padded, row_num, col_num)
    mid_right = get_mid_right(padded, row_num, col_num)
    down_left = get_down_left(padded, row_num, col_num)
    down_cent = get_down_cent(padded, row_num, col_num)
    down_right = get_down_right(padded, row_num, col_num)
    return([up_left, up_cent, up_right, mid_left, mid_right, down_left, down_cent, down_right])
end

function get_up_left(padded, row_num, col_num)
    up_left = '.'
    for i in 1:min(row_num-1, col_num-1)
        if padded[row_num - i][col_num - i] != '.'
            up_left = padded[row_num - i][col_num - i]
            break
        else
            continue
        end
    end
    return(up_left)
end

function get_up_cent(padded, row_num, col_num)
    up_cent = '.'
    for i in 1:min(row_num-1)
        if padded[row_num - i][col_num] != '.'
            up_cent = padded[row_num - i][col_num]
            break
        else
            continue
        end
    end
    return(up_cent)
end

function get_up_right(padded, row_num, col_num)
    up_right = '.'
    max_col_num = length(padded[1])
    for i in 1:min(row_num-1, max_col_num-col_num-1)
        if padded[row_num - i][col_num + i] != '.'
            up_right = padded[row_num - i][col_num + i]
            break
        else
            continue
        end
    end
    return(up_right)
end

function get_mid_left(padded, row_num, col_num)
    mid_left = '.'
    max_col_num = length(padded[1])
    for i in 1:(col_num-1)
        if padded[row_num ][col_num - i] != '.'
            mid_left = padded[row_num][col_num - i]
            break
        else
            continue
        end
    end
    return(mid_left)
end


function get_mid_right(padded, row_num, col_num)
    mid_right = '.'
    max_col_num = length(padded[1])
    for i in 1:(max_col_num-col_num-1)
        if padded[row_num][col_num + i] != '.'
            mid_right = padded[row_num][col_num + i]
            break
        else
            continue
        end
    end
    return(mid_right)
end

function get_down_left(padded, row_num, col_num)
    down_left = '.'
    max_row_num = length(padded)
    for i in 1:min(max_row_num - row_num - 1, col_num-1)
        if padded[row_num + i][col_num - i] != '.'
            down_left = padded[row_num + i][col_num - i]
            break
        else
            continue
        end
    end
    return(down_left)
end

function get_down_cent(padded, row_num, col_num)
    down_cent = '.'
    max_row_num = length(padded)
    for i in 1:min(max_row_num - row_num - 1)
        if padded[row_num + i][col_num] != '.'
            down_cent = padded[row_num + i][col_num]
            break
        else
            continue
        end
    end
    return(down_cent)
end

function get_down_right(padded, row_num, col_num)
    down_right = '.'
    max_col_num = length(padded[1])
    max_row_num = length(padded)
    for i in 1:min(max_row_num - row_num-1, max_col_num-col_num-1)
        if padded[row_num + i][col_num + i] != '.'
            down_right = padded[row_num + i][col_num + i]
            break
        else
            continue
        end
    end
    return(down_right)
end



let 
    input = readlines("11.txt")
    # pad input
    # every existing row adds a dot to the start and end
    padded = [string(".", a, ".") for a in input]
    # first row is all dots
    pushfirst!(padded, repeat(".", length(padded[1])))
    # last row is all dots
    push!(padded, repeat(".", length(padded[1])))
    empty_seats = repeat(".", length(padded[1]))
    next_padded = [empty_seats for a in 1:length(padded)]
    i = 0
    println("=========0============")
    for thing in padded
        println(thing)
    end
    while i < 100
    # for i in 1:4
        i += 1
        println("=========", i, "============")
        for line in enumerate(padded)
            row_num = line[1]
            seats = line[2]
            max_row_num = length(padded)
            max_col_num = length(padded[1])
            for col_num in 1:length(seats)
                if row_num == 1 || row_num == max_row_num || col_num == 1 || col_num == max_col_num
                    continue
                end
                if seats[col_num] == '.'
                    continue
                else
                    neighbours = get_unlimited_neighbours(padded, row_num, col_num)
                    if seats[col_num] == 'L'
                        new_seat = check_empty(neighbours)
                    else
                        new_seat = check_full(neighbours)
                    end
                    next_padded[row_num] = string(next_padded[row_num][begin:col_num-1], new_seat, next_padded[row_num][col_num+1:end])
                end
            end
        end
        for thing in next_padded
            println(thing)
        end
        if padded == next_padded
            println("MATCH")
            occupied_seats = 0
            for line in padded
                for the_char in line
                    if the_char == '#'
                        occupied_seats +=1
                    end
                end
            end
            println(occupied_seats)
            break
        end
        padded = next_padded
        next_padded = [empty_seats for a in 1:length(padded)]
    end
end
