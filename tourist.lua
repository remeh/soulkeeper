require "indian"

Tourist = {
    class = "Tourist",

    afraid = false,
	
	timeCaged = -1,
	cage = nil,

    update = function(self, delta)
		self.lastUpdate = self.lastUpdate + delta
		if self.lastUpdate >= self.timeToUpdate then
			if not self.isBlocked then
	            self:move(delta)
			end
            self.lastUpdate = self.lastUpdate - self.timeToUpdate
		end

        touchingObjects = game.level:whatIsTouching(self)
        for i, value in ipairs(touchingObjects) do
			--print(value.class .. " is touch by " .. self.class)
            if value.action ~= nil then
                value:action(self)
			else
				--print(value.class .. " has no action")
            end 
        end
		if self.timeCaged > 0 then
			print("TC "..self.timeCaged)
			self.timeCaged = self.timeCaged - 1*delta
		elseif self.timeCaged <= 0 and self.timeCaged>-1 then
			--creates the indian that will replace self
			local indian = Actor.new(Indian)
			indian.posX = self.posX
			indian.posY = self.posY
			-- adds it in the level

			game.level:addPerson(indian)
			game.point = game.point + 50
			
			-- resets cage
			self.cage.class = "cage"
			-- removes the tourist
			game.level:removePerson(self)
		end
    end,

    move = function(self, delta)
        local delta = math.random(1,4)

        -- TODO code took from Indian, to remove.
        local direction = math.random(4)
        local dx = 0
        local dy = 0

        if direction == Direction.UP then
            dy = -1    
        elseif direction == Direction.RIGHT then
            dx = 1 
        elseif direction == Direction.DOWN then
            dy = 1
        else 
            dx = -1
        end

        if not game.level:isBlocking(self.posX+dx, self.posY+dy) then
            self.posX = self.posX + dx
            self.posY = self.posY + dy
        end
        
        --[[ TODO
        if self.afraid then
            -- afraid behavior
            -- move randomly
        else
            -- regular behavior
            -- try to go to the center
            --if delta <= 2 then -- 50%
                local horizontal = math.random(1, 2)

                local xCenter = game.level.width/2
                local yCenter = game.level.height/2

                local dx = 0
                local dy = 0

                -- go to the center
                if horizontal == 1 then
                    if self.posX <= xCenter then
                        dx = -1
                    else
                        dx = 1
                    end
                else
                    if self.posY <= yCenter then
                        dy = -1
                    else
                        dy = 1
                    end
                end

                if not game.level:isBlocking(self.posX+dx, self.posY+dy) then
                    self.posX = self.posX + dx
                    self.posY = self.posY + dy
                end
            --end
        end
        ]]--

        self.lastUpdate = 0
    end,

    die = function(self, delta)
        -- TODO
    end,
}

