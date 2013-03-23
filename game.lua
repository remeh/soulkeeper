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
        ["main_menu"] = function (delta) self:updateMainMenu(delta) end,
        ["game_screen"] = function (delta) self:updateGameScreen(delta) end,
        ["game_over"] = function (delta) self:updateGameOver(delta) end
    }

    -- call the switch
    switch[self.state](delta)
end

function Game:updateMainMenu(delta)

end

function Game:updateGameScreen(delta)

end

function Game:updateGameOver(delta)
    
end

