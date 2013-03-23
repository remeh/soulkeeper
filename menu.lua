Menu = {
    bigFont = love.graphics.newFont(36),
    font = love.graphics.newFont(24),

	items = {
		{"New game", 200, 200, 390, 240, { 255, 255, 255}, function(self) self:newGame() end },
		{"About", 230, 240, 340, 280, {255, 0, 255}, function(self) self:about() end },
		{"Quit", 250, 280, 330, 320, {255, 255, 0}, function(self) self:quit() end},
	},
}

function Menu:newGame()
	print("NewGame")
	game.state = GameState.GAME_SCREEN --TODO DEBUG
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
	love.graphics.setFont(self.font);
	love.graphics.print("Soul Keeper", 220, 10);
	love.graphics.setFont(self.bigFont);
	for k,item in ipairs(self.items) do
		love.graphics.setColor(item[6])
		love.graphics.print(item[1], item[2], item[3])
	end
	love.graphics.setColor(255,255,255)
end

function Menu:update(delta)
end

function Menu:mousereleased(x, y, button)
	if button == 'l' then
		for k,item in ipairs(self.items) do
			if item[2] <= x and item[4] >= x and item[3] <= y and item[5] >= y then
				item[7](self)
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
