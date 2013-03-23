Menu = {
    bigFont = love.graphics.newFont(36),
    font = love.graphics.newFont(24)
}

function Menu:draw()
    -- Draw a background
    game.level:draw()

	-- Draw the menu
    love.graphics.setFont(self.font);
    love.graphics.print("Soul Keeper", 220, 10);
    love.graphics.setFont(self.bigFont);
    love.graphics.print("New game", 200, 200);
    love.graphics.print("About", 230, 240);
    love.graphics.print("Quit", 250, 280);
end

function Menu:update(delta)
end

function Menu:mousereleased(x, y, button)
	if button == 'l' then
	end
end

-- Constructor

function Menu.new(height, width)
	--Create a new level
    menu = Menu	
	return menu
end
