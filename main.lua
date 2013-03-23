require "trap"
require "conf"

function love.load()
    -- Ici, on va charger nos ressources.
end

function love.draw()
    love.graphics.print("Soul Keeper", 290, 10)
end


function love.keypressed(key, unicode)
    if key == 'a' then
        trap = Trap
        trap.trigger(trap)
    end
end

