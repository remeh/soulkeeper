-- The main game method which will contains
-- the different states.
Game = {
    state = "main_menu"
}

function Game:init()
    self.state = "main_menu"
end

function Game:update(delta)
    local switch = {
        ["main_menu"] = function (delta) updateMainMenu(delta) end,
        ["game_screen"] = function (delta) updateGameScreen(delta) end,
        ["game_over"] = function (delta) updateGameOver(delta) end
    }

    print(self.state)

    -- call the switch
    switch[self.state](delta)
end

function Game:updateMainMenu(delta)

end

function Game:updateGameScreen(delta)

end

function Game:updateGameOver(delta)
    
end

