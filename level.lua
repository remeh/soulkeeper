
Level = {
	size_h = 480,
	size_w = 640,
    -- Size in square
    height = nil,
    width = nil,
    sprite_size = nil,

	numEntrances = nil,
	traps = {},
	persons = {},
	forestSize = 3,
	roadSize = 4,
	wave = 1,
	canvas_Background = nil,

	-- Walkable/buildable zone
	zone = nil
}

function Level:drawForest()
	local x = 0
	local y = 0
	--local tree_sprite = love.graphics.newImage("sprites/tree.png")
	local tree_sprite = love.graphics.newImage("sprites/forest.png")
--	tree_sprite = love.Sprite.new("tree.png", 20, 20, VRAM)
	for x = 0, (self.size_w/self.sprite_size), 1 do
		for y = 0, (self.height-1), 1 do
			love.graphics.draw(tree_sprite, x*self.sprite_size, y*self.sprite_size)
--			tree_sprite:drawFrame(ecran, 0+x, 0+y, 1)
		end
	end
end

function Level:drawCamp()
	local x = 0
	local y = 0
	local ground_sprite = love.graphics.newImage("sprites/ground.png")
	for x = self.forestSize, (self.width-(1+self.forestSize)), 1 do
		for y = self.forestSize, (self.height-(1+self.forestSize)), 1 do
			self.zone[y+1][x+1] = 1
			love.graphics.draw(ground_sprite, x*self.sprite_size, y*self.sprite_size)
		end
	end
end

function Level:findRoad()
    local find = false
    while find == false do
        local side = math.random(0,1)
        local x = self.width/2
        local y = self.height/2

        local delta = math.random(0,1)
        if delta == 1 then
            delta = -1
        end

        if side == 1 then
            -- test on x  
            x = math.random(0,1)
            if x == 1 then
                x = self.width-1
            else
                x = 1
            end

            y = y + delta
        else
            -- test on y
            y = math.random(0,1)
            if y == 1 then
                y = self.height-1
            else
                y = 1
            end

            x = x + delta
        end

        --print("test on " .. x .. ":" .. y)
        if not self:isBlocking(x,y) then
            find = true
            return { findX = x, findY = y }
        end
    end
end

function Level:drawRoad()
	local x = 0
	local y = 0
	local ground_sprite = love.graphics.newImage("sprites/ground.png")
	--Road 1
	for x = 0,self.forestSize,1 do
		local tmp_size = math.floor((self.height-self.roadSize)/2)
		for y = tmp_size, tmp_size+self.roadSize,1 do
			love.graphics.draw(ground_sprite, x*self.sprite_size, y*self.sprite_size)
			self.zone[y+1][x+1] = 1
		end
	end
	--Road 2
	if self.numEntrances >= 2 then
		for x = (self.width-1-self.forestSize), (self.size_w/self.sprite_size-1), 1 do
			local tmp_size = math.floor((self.height-self.roadSize)/2)
			for y = tmp_size, tmp_size+self.roadSize,1 do
				love.graphics.draw(ground_sprite, x*self.sprite_size, y*self.sprite_size)
				self.zone[y+1][x+1] = 1
			end
		end
	end
	--Road 3
	if self.numEntrances >= 3 then
		local tmp_size = math.floor((self.width-self.roadSize)/2)
		for x = tmp_size, tmp_size+self.roadSize,1 do
			for y = 0,self.forestSize,1 do
				love.graphics.draw(ground_sprite, x*self.sprite_size, y*self.sprite_size)
				self.zone[y+1][x+1] = 1
			end
		end
	end
	--Road 4
	if self.numEntrances >= 4 then
		local tmp_size = math.floor((self.width-self.roadSize)/2)
		for x = tmp_size, tmp_size+self.roadSize,1 do
			for y = (self.height-1-self.forestSize),(self.height-1),1 do
				love.graphics.draw(ground_sprite, x*self.sprite_size, y*self.sprite_size)
				self.zone[y+1][x+1] = 1
			end
		end
	end
end

function Level:drawHut()
	local x
	local y
	local hut_sprite 
	local huts_pos = {
		{ 13 , 13, "sprites/hut4x4.png",4 },
		{ 23 , 23, "sprites/hut4x4.png",4 },
		{ 19 , 10, "sprites/hut4x4.png",4 },
		{ 7 , 3, "sprites/hut4x4.png",4 },
		{ 15 , 17, "sprites/fire1x1.png",1 },
		{ 7 , 26, "sprites/fire1x1.png",1 },
		{ 10 , 20, "sprites/fire1x1.png",1 },
		{ 7 , 15, "sprites/fire1x1.png",1 },
	}
	for k,pos in ipairs(huts_pos) do
		hut_sprite = love.graphics.newImage(pos[3])
		love.graphics.draw(hut_sprite, pos[1]*self.sprite_size, pos[2]*self.sprite_size)
		for x = pos[2],pos[2]+pos[4]-1 do
			for y = pos[1],pos[1]+pos[4]-1 do
				self.zone[x+1][y+1] = 0
			end
		end

	end
end

function Level:drawBase()
	local x
	local y
	--Init matrice
	self.zone = {}
	for x = 1, self.height do
		self.zone[x] = {}
		for y = 1, self.width do
			self.zone[x][y] = 0
		end
	end
	-- Draw Forest
	self:drawForest()
	-- Draw Camp
	self:drawCamp()
	--Def zone road in matrice
	self:drawRoad()
	--Def zone hut
	self:drawHut()

	--[[
	for x = 1, self.height do
		for y = 1, self.width do
			io.write(self.zone[x][y] .. " ")
		end
		print("")
	end
	]]--

end

function Level:draw()
	love.graphics.draw(self.canvasBackground)
	Game.piegeManager.drawPiegeArea(Game.piegeManager)
	for _,person in ipairs(self.persons) do
		love.graphics.draw(ActorDrawables[person.class],person.posX*self.sprite_size,person.posY*self.sprite_size)
	end

	for _,trap in ipairs(self.traps) do
		love.graphics.draw(PiegeDrawables[trap.class],trap.posX*self.sprite_size,trap.posY*self.sprite_size)
	end
end

function Level:addTrap(trap)
	-- TODO Verifier que le piege est dans la zone constructible
	--
	--
	--
	-- Search souls to pay the trap
	local selectedPersons = {}
	for _,person in ipairs(self.persons) do
		if table.getn(selectedPersons) == trap.soulNeeded then
			break
		end

		if person.class=="Indian" and trap:contains(person) then
			table.insert(selectedPersons,person)
		end
	end
	if table.getn(selectedPersons) == 1 then
		-- Add the trap
		table.insert(self.traps,trap)
		return true
	else
		-- Can't add the trap
		return false
	end
end

function Level:removePerson(person)
    for i, value in ipairs(self.persons) do
        if value == person then
            table.remove(self.persons, i) 
            break
        end
    end
end

function Level:addPerson(person)
	-- Add person
	table.insert(self.persons,person)
end

function Level:addPersonRandomly(person)
    local x = math.random(0,self.width-1)
    local y = math.random(0,self.height-1)


    if not self:isBlocking(x,y) then
        person.posX = x
        person.posY = y
        self:addPerson(person)
    end
end

function Level:isBlocking(x, y)
    if x < 1 or x > self.width-1 or y < 1 or y > self.height-1 then
        return true
    end

    return self.zone[y+1][x+1] == 0
end

function Level:update(delta_time)
	for k,person in ipairs(self.persons) do
		person:update(delta_time)
	end
end

-- Returns case number from a pixel position
function Level:getCase(pixel)
	return math.floor(pixel/self.sprite_size)
end

function Level:generateBackground()
	self.canvasBackground = love.graphics.newCanvas(1024,1024)
	--Replace the current canvas to the background
	love.graphics.setCanvas(self.canvasBackground)
	--Draw background part
	self:drawBase()
	--Restore the default canvas
	love.graphics.setCanvas()
end

-- Returns which thing 

function Level:touches(actor)
    
end

-- Returns the roads position

function Level:isOutside(x, y)
	 if x > (self.width - 1)  or y > (self.height - 1) then
	    return true
	 end
	 if x < 1 or y < 1 then
	    return true
	 end
	 return false
end

-- Returns what is touches this actor. 
function Level:whatIsTouching(actor)
    local results = {}

    -- contacts between actors
    for i, value in ipairs(self.persons) do
        if value ~= actor and value.class ~= actor.class then
            if value:contains(actor) then
                table.insert(results, value)
            end
        end
    end

    -- contacts between actors and traps
    for i, value in ipairs(self.traps) do
        if value:contains(actor) and value.class ~= actor.class  then
            table.insert(results, value)
        end
    end

    return results
end

-- Constructor

function Level.new(height,width,sprite_size,numEntrances)
	--Create a new level
	local level = Level
	level.height = height
	level.width = width
	level.sprite_size = sprite_size
	level.numEntrances = numEntrances

	level:generateBackground()

    indiansPosition = {
        { x = math.random(10,14), y = math.random(14,23) },
        { x = 04, y = 07 },
        { x = 20, y = 9 }
    }

	for i,value in ipairs(indiansPosition) do
        indian = Actor.new(Indian)
        indian.posX = value.x
        indian.posY = value.y
        level:addPerson(indian)
	end

	return level
end

