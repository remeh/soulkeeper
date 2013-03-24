Minimenu = {
	ghostImage = love.graphics.newImage("sprites/ghost.png"),
    font = love.graphics.newFont(18),

	traps = {
		{"Repel", 545, 21, 630, 50, {230, 230, 230}, function(self) self:trap1() end,1},
		{"Totem", 545, 55, 630, 80, {230, 230, 230}, function(self) self:trap2() end,1},
		{"Smoke", 545, 98, 630, 130, {230, 230, 230}, function(self) self:trap3() end,1},
		{"Cage", 545, 136, 630, 160, {230, 230, 230}, function(self) self:trap4() end,1},
		--{"    Pause", 510, 300, 615, 320, {230, 230, 230}, function(self) self:pause() end},
		{"Tourists", 510, 272, 615, 280, {230, 230, 230}}
	},
}

--
--

MiniBack = love.graphics.newImage("sprites/menu_background.png")

function Minimenu:trap1()
	 print("Repel")
	 piegeManager.changePiege(piegeManager, Trappe)
end

function Minimenu:trap2()
	 print("Totem")
	 piegeManager.changePiege(piegeManager, Totem)

end

function Minimenu:trap3()
	 print("Smoke")
end

function Minimenu:trap4()
	 print("Cage")
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
			love.graphics.print(item[8], item[2]+80, item[3])
		end
	end
	love.graphics.print("Nxt wave: " .. game.gameplay:timeToNextWave(), 506, 243)
	love.graphics.print(game.level:getNumTypePerson("Tourist"), 590, 272)
	love.graphics.print(math.floor(game.point), 510, 328)
	love.graphics.print("Souls: " ..game.soulCollected, 510, 300)
    
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.ghostImage,623,5)
end

function Minimenu:update(delta)
end

function Minimenu:mousereleased(x, y, button)
	 if button == 'l' then
	    	   for k, item in ipairs(self.traps) do
		       if item[2] <= x and item[4] >= x and item[3] <= y and item[5] >= y then
		       	  	  item[7](self)
			end
		end
	end
end	 

-- Constructor

function Minimenu.new(height, width)
	 minimenu = Minimenu
	 return minimenu
end
