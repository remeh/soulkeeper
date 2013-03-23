require "actor"
require "level"

-- The main game method which will contains
-- the different states.
Game = {
    -- starting state
    state = "main_menu",
    -- the level instance
    level = Level.new(30, 40, 16, 1), -- TODO see for the number entrance

    actorDrawables = ActorDrawables
}

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
    -- update the level
    self.level:update(delta)
end

function Game:updateGameOver(delta)
    
end

-- Constructor
function Game.new()
    game = Game
    game.state = "main_menu"
    return game
end
