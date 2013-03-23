Minimenu = {
    bigFont = love.graphics.newFont(25),
    font = love.graphics.newFont(24),

	traps = {
		{"Trap1", 550, 20, 630, 50, {0, 0, 0}, function(self) self:trap1() end},
		{"Trap2", 550, 65, 630, 90, {0, 0, 0}, function(self) self:trap2() end},
		{"Trap3", 550, 115, 630, 150, {0, 0, 0}, function(self) self:trap3() end},
		{"Trap4", 550, 165, 630, 210, {0, 0, 0}, function(self) self:trap4() end},
	},
}

--
--

MiniBack = love.graphics.newImage("sprites/menu_background.png")

function Minimenu:trap1()
	 print("Trap1")
end

function Minimenu:trap2()
	 print("Trap2")
end

function Minimenu:trap3()
	 print("Trap3")
end

function Minimenu:trap4()
	 print("Trap4")
end

function Minimenu:draw()
	-- Draw the background
	love.graphics.draw(MiniBack, 480, 0)		
	-- Draw the menu
    love.graphics.setFont(self.font);
    love.graphics.setFont(self.bigFont);
	for k,item in ipairs(self.traps) do
		love.graphics.setColor(item[6])
		love.graphics.print(item[1], item[2], item[3])
	end
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
