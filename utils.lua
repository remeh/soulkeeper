function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
            copy = orig
    end
    return copy
end

function distanceFrom(x1,y1,x2,y2) 
	return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2) 
end
