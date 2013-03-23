Menu = {
    bigFont = love.graphics.newFont(36),
    font = love.graphics.newFont(24),

	items = {
		{"New game", 200, 200, 390, 240, { 255, 255, 255}},
		{"About", 230, 240, 340, 280, {255, 0, 255}},
		{"Quit", 250, 280, 330, 320, {255, 255, 0}},
	},
}

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
				print(item[1])
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
