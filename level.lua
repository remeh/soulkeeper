Level {
	-- Size in square
	height = nil,
	width = nil,

	numEntrances = nil,
	traps = {},
	persons = {},

	-- Walkable/buildable zone
	zone = nil
}

function Level:drawForest()
end

function Level:drawCamp()
end

function Level:drawRoad()
end

function Level:drawHut()
end

function Level:drawBase()
	--Init matrice
	zone = {}
	for i = 1, self.height do
		zone[i] = {}
		for j = 1, self.width do
			zone[i][j] = 1
		end
	end
	-- Draw Forest
	self.drawForest()
	-- Draw Camp
	self.drawCamp()
	--Def zone road in matrice
	self.drawRoad()
	--Def zone hut
	self.drawHut()
end

function Level:draw()
	-- Draw Base
	self.drawBase()
	-- Draw Trap
	self.drawTraps()
	-- Draw People
	self.drawPersons()
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

function Level.init(height,width,numEntrance)
	--Create a new level
	level = Level
	level.height = height
	level.width = width
	level.numEntrance = numEntrance
	return level
end
