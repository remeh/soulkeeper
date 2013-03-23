require "trap"
require "conf"
require "game"

game = Game

function love.load()
    -- Creates the main game var. Global.
end

function love.run()
    -- The main function
    while true do
        -- Process events.
        if love.event then
            love.event.pump()
            for e,a,b,c,d in love.event.poll() do
                if e == "quit" then
                    if not love.quit or not love.quit() then
                        if love.audio then
                            love.audio.stop()
                        end
                        return
                    end
                end
                love.handlers[e](a,b,c,d)
            end
        end

        -- Update dt, as we'll be passing it to update
        if love.timer then
            love.timer.step()
            -- computes the delta
            dt = love.timer.getDelta()
        end

        -- Call update and draw
        if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled
        if love.graphics then
            love.graphics.clear()
            if love.draw then love.draw() end
        end

        if love.timer then love.timer.sleep(0.001) end
        if love.graphics then love.graphics.present() end
    end
end

function love.draw()
    love.graphics.print("Soul Keeper", 290, 10)
end

-- The main loop update which take care of updating
-- the entities.
function love.update(delta)
    -- game.update(delta)
end

function love.keypressed(key, unicode)
    if key == 'escape' then
        if not love.quit or not love.quit() then
            if love.audio then
                love.audio.stop()
            end
            return
        end
    end
end

