Minimenu = {
	ghostImage = love.graphics.newImage("sprites/ghost.png"),
	touristImage = love.graphics.newImage("sprites/tourist.png"),
	font = love.graphics.newFont("AtariSmall.ttf", 14),

	traps = {
		{"Trap", 544, 23, 630, 50, {230, 230, 230}, function(self) self:trap1() end,Trappe.soulNeeded},
		{"Totem", 545, 60, 630, 80, {230, 230, 230}, function(self) self:trap2() end,Totem.soulNeeded},
		{"Smoke", 544, 100, 630, 130, {230, 230, 230}, function(self) self:trap3() end,Slowdown.soulNeeded},
		{"Cage", 544, 137, 630, 160, {230, 230, 230}, function(self) self:trap4() end,Cage.soulNeeded},
        -- icons
		{"", 495, 16, 527, 47, {230, 230, 230}, function(self) self:trap1() end},
		{"", 495, 54, 527, 83, {230, 230, 230}, function(self) self:trap2() end},
		{"", 495, 92, 527, 122, {230, 230, 230}, function(self) self:trap3() end},
		{"", 495, 131, 527, 162, {230, 230, 230}, function(self) self:trap4() end},

		--{"Kill", 544, 176, 630, 190, {230, 230, 230}, function(self) self:trap5() end,1},
		--{"    Pause", 510, 300, 615, 320, {230, 230, 230}, function(self) self:pause() end}, ]]--
		{"Tourists ", 525, 275, 615, 280, {230, 230, 230}}
	},
}

--
--

MiniBack = love.graphics.newImage("sprites/menu_background.png")

function Minimenu:trap1()
	 print("Trappe")
	 piegeManager.changePiege(piegeManager, Trappe)
end

function Minimenu:trap2()
	 print("Totem")
	 piegeManager.changePiege(piegeManager, Totem)

end

function Minimenu:trap3()
	 print("Smoke")
	 piegeManager.changePiege(piegeManager, Slowdown)
end

function Minimenu:trap4()
	 print("Cage")
	 piegeManager.changePiege(piegeManager, Cage)
end

function Minimenu:trap5()
	 --print("Kill")
end

function Minimenu:pause()
	game:switchPause()
end

function Minimenu:draw()
	-- Draw the background
	love.graphics.draw(MiniBack, 480, 0)		
	-- Draw the menu
	love.graphics.setFont(self.font);
	for k,item in ipairs(self.traps) do
		love.graphics.setColor(item[6])
		love.graphics.print(item[1], item[2], item[3])
		if item[8] then
			love.graphics.print(item[8], item[2]+55, item[3])
		end
	end
	love.graphics.print("Nxt wave " .. game.gameplay:timeToNextWave(), 507, 246)
	love.graphics.print(game.level:getNumTypePerson("Tourist"), 591, 274)
	love.graphics.print("Score: " .. math.floor(game.point), 506, 333)
	love.graphics.print("Souls " ..game.soulCollected, 525, 304)
    
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.ghostImage,610,23)
	love.graphics.draw(self.ghostImage,610,60)
	love.graphics.draw(self.ghostImage,610,100)
	love.graphics.draw(self.ghostImage,610,137)
	love.graphics.draw(self.ghostImage,508,304)
	love.graphics.draw(self.touristImage,508,275)
end

function Minimenu:update(delta)
end

function Minimenu:mousereleased(x, y, button)
	 if button == 'l' then
	    	   for k, item in ipairs(self.traps) do
		       if item[2] <= x and item[4] >= x and item[3] <= y and item[5] >= y then
                if item[7] ~= nil then
		       	  	  item[7](self)
                end
			end
		end
	end
end	 

-- Constructor

function Minimenu.new(height, width)
	 minimenu = Minimenu
	 return minimenu
end
