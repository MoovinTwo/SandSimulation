
require("gen")

function love.load()
    gridBuilder:init(200,200)
end

function love.draw()
    gridBuilder:draw()
end

function love.update()
    gridBuilder:update()
end