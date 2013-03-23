Level = {
	-- Size in square
	height = nil,
	width = nil,
	sprite_size = nil,

	numEntrances = nil,
	traps = {},
	persons = {},

	forestSize = 3,
	roadSize = 5,

	canvas_Background = nil,

	-- Walkable/buildable zone
	zone = nil
}

function Level:drawForest()
	local x = 0
	local y = 0
	local tree_sprite = love.graphics.newImage("sprites/tree.png")
--	tree_sprite = love.Sprite.new("tree.png", 20, 20, VRAM)
	for x = 0, (self.width-1), 1 do
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
	for x = self.forestSize, (self.width-1-self.forestSize), 1 do
		for y = self.forestSize, (self.height-1-self.forestSize), 1 do
			-- TODO DEBUG self.zone[x][y] = 1
			love.graphics.draw(ground_sprite, x*self.sprite_size, y*self.sprite_size)
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
		end
	end
	--Road 2
	if self.numEntrances >= 2 then
		for x = (self.width-1-self.forestSize), (self.width-1), 1 do
			local tmp_size = math.floor((self.height-self.roadSize)/2)
			for y = tmp_size, tmp_size+self.roadSize,1 do
				love.graphics.draw(ground_sprite, x*self.sprite_size, y*self.sprite_size)
			end
		end
	end
	--Road 3
	if self.numEntrances >= 3 then
		local tmp_size = math.floor((self.width-self.roadSize)/2)
		for x = tmp_size, tmp_size+self.roadSize,1 do
			for y = 0,self.forestSize,1 do
				love.graphics.draw(ground_sprite, x*self.sprite_size, y*self.sprite_size)
			end
		end
	end
	--Road 4
	if self.numEntrances >= 4 then
		local tmp_size = math.floor((self.width-self.roadSize)/2)
		for x = tmp_size, tmp_size+self.roadSize,1 do
			for y = (self.height-1-self.forestSize),(self.height-1),1 do
				love.graphics.draw(ground_sprite, x*self.sprite_size, y*self.sprite_size)
			end
		end
	end
end

function Level:drawHut()
end

function Level:drawBase()
	--Init matrice
	zone = {}
	for i = 1, self.height do
		zone[i] = {}
		for j = 1, self.width do
			zone[i][j] = 0
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
end

function Level:draw()
	-- Draw Base
	self:drawBase()
	-- Draw Trap
	self:drawTraps()
	-- Draw People
	self:drawPersons()
end

function Level:addTrap(trap)
	-- TODO Verifier que le piege est dans la zone constructible
	--
	--
	--
	-- Search souls to pay the trap
	local selectedPersons = {}
	for person in self.persons do
		if table.getn(selectedPersons) == trap.cost then
			break
		end
		if person.isSoul() and trap.contain(person) then
			table.insert(selectedPersons,person)
		end
	end

	if table.getn(selectedPersons) == trap.cost then
		-- They have enouth person in the trap zone
		for person in selectedPersons do
			-- For all personn to remove
			for k,v in ipairs(self.persons) do
				if v == person then
					-- delete the selected person of the game
					table.remove(self.persons,k)
					break -- TODO Check if break stop only once loop
				end
			end
		end
		-- Add the trap
		table.insert(self.traps,trap)
		return true
	else
		-- Can't add the trap
		return false
	end
end

function Level:addPerson(person)
	-- Add person
	table.insert(self.persons,person)
end

function Level:newWave()
	-- Launch a new wave of tourist
	local person = nil
	local num_tourist = 99
	-- Create "num_tourist" tourist
	for i=1,num_tourist,1 do
		person = Person.init('tourist') --TODO Check when the Person will be created
		self.addPerson(person)
	end
end

function Level:update(delta_time)
	love.graphics.draw(self.canvasBackground)
end

function Level:generateBackground()
	self.canvasBackground = love.graphics.newCanvas(1024,1024)
	--Replace the current canvas to the background
	love.graphics.setCanvas(self.canvasBackground)
	--Draw background part
	self:drawForest()
	self:drawCamp()
	self:drawRoad()
	self:drawHut()
	--Restore the default canvas
	love.graphics.setCanvas()
end

-- Returns which thing 
function Level:touches(actor)
end

-- Constructor

function Level.new(height,width,sprite_size,numEntrances)
	--Create a new level
	level = Level
	level.height = height
	level.width = width
	level.sprite_size = sprite_size
	level.numEntrances = numEntrances

	level:generateBackground()
	return level
end
