Menu = {
	fonts = {
		love.graphics.newFont("AtariSmall.ttf", 36),
		love.graphics.newFont("AtariSmall.ttf", 24),
		love.graphics.newFont("AtariSmall.ttf", 64),
	},

	menu_items = {
		{"Easy", 490, 180, 550, 209, 2, { 255, 255, 255}, function(self) self:newGame(1) end },
		{"Medium", 490, 210, 590, 239, 2, { 255, 255, 255}, function(self) self:newGame(2) end },
		{"Hard", 490, 240, 550, 269, 2, { 255, 255, 255}, function(self) self:newGame(4) end },
		{"About", 450, 270, 560, 309, 1, {255, 255, 255}, function(self) self:about() end },
		{"Quit", 450, 310, 530, 349, 1, {255, 255, 255}, function(self) self:quit() end},
	},
	static_items = {
		{"Soul Keeper", 63, 185, 3, { 0, 0, 0}},
		{"New game", 450, 140, 1, { 255, 255, 255}},
	},
}

function Menu:newGame(difficult)
--	print("NewGame")
	game:createdLevel(difficult)
	game.started = 1
	game.state = GameState.GAME_SCREEN
end

function Menu:about()
	print("About")
end

function Menu:quit()
	love.event.quit()
end

function Menu:draw()
	-- Draw a background
	game.level:draw()

	-- Draw the menu
	for k,item in ipairs(self.menu_items) do
		love.graphics.setFont(self.fonts[item[6]])
		love.graphics.setColor(item[7])
		love.graphics.print(item[1], item[2], item[3])
	end

	for k,item in ipairs(self.static_items) do
		love.graphics.setFont(self.fonts[item[4]])
		love.graphics.setColor(item[5])
		love.graphics.print(item[1], item[2], item[3])
	end

	love.graphics.setColor(255,255,255)
end

function Menu:update(delta)
	local x = love.mouse.getX()
	local y = love.mouse.getY()
	for k,item in ipairs(self.menu_items) do
		if item[2] <= x and item[4] >= x and item[3] <= y and item[5] >= y then
			self.menu_items[k][7] = {0,0,0}
		else
			self.menu_items[k][7] = {255,255,255}
		end
	end
end

function Menu:mousereleased(x, y, button)
	if button == 'l' then
		for k,item in ipairs(self.menu_items) do
			if item[2] <= x and item[4] >= x and item[3] <= y and item[5] >= y then
				item[8](self)
			end
		end
	end
end

-- Constructor

function Menu.new(height, width)
	--Create a new level
	menu = Menu	
	return menu
end
