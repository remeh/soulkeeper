Minimenu = {
    font = love.graphics.newFont(18),

	traps = {
		{"Repel", 545, 21, 630, 50, {0, 0, 0}, function(self) self:trap1() end},
		{"Totem", 545, 68, 630, 90, {0, 0, 0}, function(self) self:trap2() end},
		{"Smoke", 545, 118, 630, 150, {0, 0, 0}, function(self) self:trap3() end},
		{"Cage", 545, 168, 630, 210, {0, 0, 0}, function(self) self:trap4() end},
		{"    Pause", 510, 242, 615, 265, {0, 0, 0}, function(self) self:pause() end},
	},
}

--
--

MiniBack = love.graphics.newImage("sprites/menu_background.png")

function Minimenu:trap1()
	 print("Repel")
end

function Minimenu:trap2()
	 print("Totem")
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
	end
	love.graphics.print(math.floor(game.point), 510, 328)
	love.graphics.setColor(255,255,255)
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
