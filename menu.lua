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

	about_items = {
		{"New game", 450, 140, 1, { 255, 255, 255}},
		{"Soul Keeper", 63, 40, 3, { 0, 0, 0}},
		{"Developed by :", 70, 100, 1, { 0, 0, 0}},
		{"Emeric Caramanna", 90, 140, 2, { 255, 255, 255}},
		{"Jean Coudon", 90, 160, 2, { 255, 255, 255}},
		{"Youri Gicquel", 90, 180, 2, { 255, 255, 255}},
		{"Thomas Martin", 90, 200, 2, { 255, 255, 255}},
		{"Remy Mathieu", 90, 220, 2, { 255, 255, 255}},
		{"Boris Sabatier", 90, 240, 2, { 255, 255, 255}},
	},

	about_enable = 0,
}

function Menu:newGame(difficult)
--	print("NewGame")
	game:createdLevel(difficult)
	game.started = 1
	game.state = GameState.GAME_SCREEN
end

function Menu:about()
	self.about_enable = 1
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

	if self.about_enable == 1 then
		for k,item in ipairs(self.about_items) do
			love.graphics.setFont(self.fonts[item[4]])
			love.graphics.setColor(item[5])
			love.graphics.print(item[1], item[2], item[3])
		end
	else
		for k,item in ipairs(self.static_items) do
			love.graphics.setFont(self.fonts[item[4]])
			love.graphics.setColor(item[5])
			love.graphics.print(item[1], item[2], item[3])
		end
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
