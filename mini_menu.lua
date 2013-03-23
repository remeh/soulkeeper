Minimenu = {
    bigFont = love.graphics.newFont(36),
    font = love.graphics.newFont(24),

	traps = {
		{"Trap1", 490, 200, 630, 230, {255, 255, 255}, function(self) self:trap1() end},
		{"Trap2", 490, 240, 630, 270, {255, 255, 255}, function(self) self:trap2() end},
		{"Trap3", 490, 280, 630, 310, {255, 255, 255}, function(self) self:trap3() end},
	},
}

function Minimenu:trap1()
	 print("Trap1")
end

function Minimenu:trap2()
	 print("Trap2")
end

function Minimenu:trap3()
	 print("Trap3")
end

function Minimenu:draw()
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
