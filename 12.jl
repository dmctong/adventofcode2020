# Q1
input = readlines("12.txt")

let
    x = 0
    y = 0
    face = 90 # east
    for line in input
        action = match(r"[A-Z]", line).match
        unit =  parse(Int64, match(r"\d{1,3}", line).match)
        if action == "N"
            y += unit
        elseif action == "S"
            y -= unit
        elseif action == "E"
            x += unit
        elseif action == "W"
            x -= unit
        end
        if action == "R"
            face += unit
            face = mod(face, 360)
        elseif action == "L"
            face -= unit
            face = mod(face, 360)
        end
        if action == "F"
            if face == 0
                y += unit
            elseif face == 90
                x += unit
            elseif face == 180
                y -= unit
            elseif face == 270
                x -= unit
            end
        end
        println(action, " ", unit, " : ", x, ",", y, " heading ", face)
    end
    println(abs(x) + abs(y))
end

# Q2
# waypoint relative to ship
x_wp = 10
y_wp = 1

# ship starts at 0,0
x_ship = 0
y_ship = 0

# when action is F, return relative amount of movement
# NB x_ship, y_ship is Cartesian (ie origin 0,0, not ship itself)
function do_F(unit, x_wp, y_wp)
    x_move = unit * x_wp
    y_move = unit * y_wp
    return(x_move, y_move)
end

# return position of waypoint relative to ship
function do_dir(action, unit, x_wp, y_wp)
    if action == "N"
        y_wp += unit
    elseif action == "S"
        y_wp -= unit
    elseif action == "E"
        x_wp += unit
    elseif action == "W"
        x_wp -= unit
    end
    return(x_wp, y_wp)
end

function do_rot(action, unit, x_wp, y_wp)
    if action == "R"
        if unit == 90
            x_wp_out = y_wp
            y_wp_out = -x_wp
        elseif unit == 180
            x_wp_out = -x_wp
            y_wp_out = -y_wp
        elseif unit == 270
            x_wp_out = -y_wp
            y_wp_out = x_wp
        else
            x_wp_out = x_wp
            y_wp_out = y_wp
        end
    elseif action == "L"
        if unit == 90
            x_wp_out = -y_wp
            y_wp_out = x_wp
        elseif unit == 180
            x_wp_out = -x_wp
            y_wp_out = -y_wp
        elseif unit == 270
            x_wp_out = y_wp
            y_wp_out = -x_wp
        else
            x_wp_out = x_wp
            y_wp_out = y_wp
        end
    end
    return(x_wp_out, y_wp_out)
end

input = readlines("12.txt")

let
    # waypoint relative to ship
    x_wp = 10
    y_wp = 1

    # ship starts at 0,0
    x_ship = 0
    y_ship = 0
    for line in input
        action = match(r"[A-Z]", line).match
        unit =  parse(Int64, match(r"\d{1,3}", line).match)
        if action == "N" || action == "S" || action == "E" || action == "W"
            (x_wp, y_wp) = do_dir(action, unit, x_wp, y_wp)
        elseif action == "R" || action == "L"
            (x_wp, y_wp) = do_rot(action, unit, x_wp, y_wp)
        elseif action == "F"
            (x_move, y_move) = do_F(unit, x_wp, y_wp)
            x_ship += x_move
            y_ship += y_move
        end
        println(action, " ", unit, " : SHIP ", x_ship, ",", y_ship, " || WAYPOOINT ", x_wp, ", ", y_wp)
    end
    println(abs(x_ship) + abs(y_ship))
end