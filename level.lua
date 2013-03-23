Level = {
	-- Size in square
	height = nil,
	width = nil,
	sprite_size = nil,

	numEntrances = nil,
	traps = {},
	persons = {},

	forestSize = 3,
	roadSize = 4,

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
	for x = self.forestSize, (self.width-(1+self.forestSize)), 1 do
		for y = self.forestSize, (self.height-(1+self.forestSize)), 1 do
			self.zone[y+1][x+1] = 1
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
			self.zone[y+1][x+1] = 1
		end
	end
	--Road 2
	if self.numEntrances >= 2 then
		for x = (self.width-1-self.forestSize), (self.width-1), 1 do
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
	local hut_sprite = love.graphics.newImage("sprites/hut.png")
	local huts_pos = {
		{ 20 , 15 },
		{ 10 , 10 },
	}
	for k,pos in ipairs(huts_pos) do
		love.graphics.draw(hut_sprite, pos[1]*self.sprite_size, pos[2]*self.sprite_size)
		self.zone[pos[2]][pos[1]] = 0
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

	for x = 1, self.height do
		for y = 1, self.width do
			io.write(self.zone[x][y] .. " ")
		end
		print("")
	end

end

function Level:draw()
	love.graphics.draw(self.canvasBackground)
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
	self:draw()
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
