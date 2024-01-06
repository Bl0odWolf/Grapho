local function math_multiply(_n, _s)
    return math.floor(_n/_s)*_s
end

function love.load(argc, argv)
    grapho = require("libaries/grapho")
    count = 0
    speed = 0
    aceleration = 0
    graphic = grapho.new(32, 32, 128, 128, 32)
    graphic:newLine("speed")
    graphic:newLine("aceleration", {1, 0, 0, 1})
end

function love.draw()
    graphic:draw()
end

function love.update(deltaTime)
    count = count + 32*deltaTime -- 32 pixels = 1 second
    aceleration = aceleration + 50*deltaTime
    speed = speed + aceleration*deltaTime
    graphic:insertPositionInLine("speed", count, speed)
    graphic:insertPositionInLine("aceleration", count, aceleration)
end

function love.touchpressed(id, x, y, dx, dy, pressure)
    graphic:touchpressed(id, x, y, dx, dy, pressure)
end

function love.touchmoved(id, x, y, dx, dy, pressure)
    graphic:touchmoved(id, x, y, dx, dy, pressure)
end

function love.touchreleased(id, x, y, dx, dy, pressure)
    graphic:touchreleased(id, x, y, dx, dy, pressure)
end