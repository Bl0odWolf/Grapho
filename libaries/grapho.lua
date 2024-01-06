local grapho = {} --module
grapho.__index = grapho

--$_point ia a table
--$_rectangle is a table
local function pointRectangleCheckCollision(_point, _rectangle)
    return _point.x <= _rectangle.x + _rectangle.w and
    _point.y <= _rectangle.y + _rectangle.h and 
    _point.x >= _rectangle.x and 
    _point.y >= _rectangle.y
end

--$_gridX is a number
--$_gridY is a number
--$_gridWidth is a number
--$_gridHeight is a number
--$_gridSizeX is a number
--$_gridSizeY is a number
local function drawGrid(_gridX, _gridY, _gridWidth, _gridHeight, _gridSizeX, _gridSizeY)
    --&horizontal
    for lineX = _gridX, _gridX + _gridWidth, _gridSizeX do
        love.graphics.line(lineX, _gridY, lineX, _gridY + _gridHeight)
    end
    --&vertical
    for lineY = _gridY, _gridY + _gridHeight, _gridSizeY do
        love.graphics.line(_gridX, lineY, _gridX +  _gridWidth, lineY)
    end
end

--&_graphic is a table
--&_index is a number
local function drawGraphicInfos(_graphic, _index)
    if _index < #_graphic.linesList then
        drawGraphicInfos(_graphic, (_index or 1) + 1)
    end
    local line = _graphic.linesList[_index or 1]
    local font = love.graphics.getFont()
    if #line.vectors > 3 then
        love.graphics.push()
        --its prevet the line leave the graphic
        --&x
        if line.vectors[#line.vectors - 1] < _graphic.positionX then
            love.graphics.translate(-line.vectors[#line.vectors - 1], 0)
        elseif line.vectors[#line.vectors - 1] > _graphic.width then
            love.graphics.translate(_graphic.width - line.vectors[#line.vectors - 1], 0)
        end
        --&y
        if line.vectors[#line.vectors] < _graphic.positionY then
            love.graphics.translate(0, -line.vectors[#line.vectors])
        elseif line.vectors[#line.vectors] > _graphic.height then
            love.graphics.translate(0, _graphic.height - line.vectors[#line.vectors])
        end
        love.graphics.setColor(line.color)
        love.graphics.line(line.vectors)
        love.graphics.pop()
    end
end

--$_graphicPositionX is a number
--$_graphicPositionY is a number
--$_graphicWidth is a number
--$_graphicHeight is a number
--$_graphicGridSize is a number
--$_graphicColor is an array
function grapho.new(_gridPositionX, _gridPositionY, _graphicWidth, _graphicHeight, _graphicGridSize) --constuctor
    return setmetatable({
        linesList = {},
        positionX = _gridPositionX or 0,
        positionY = _gridPositionY or 0,
        width = _graphicWidth or 128,
        height = _graphicHeight or 128,
        graphic = love.graphics.newCanvas(_graphicWidth or 128, _graphicHeight or 128),
        gridSize = _graphicGridSize or 32,
        isDrag = nil
    }, grapho)
end

--draw the graphic, lines, grid and etc
function grapho:draw()
    --&grid
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(23/255, 28/255, 43/255, 1)
    love.graphics.rectangle("fill", self.positionX, self.positionY, self.width, self.height)
    love.graphics.setColor(1, 1, 1, 0.5)
    drawGrid(self.positionX, self.positionY, self.width, self.height, self.gridSize, self.gridSize)
    --&lines
    love.graphics.setCanvas(self.graphic)
    love.graphics.clear(0, 0, 0, 0)
    
    if #self.linesList > 0 then
        drawGraphicInfos(self, 1)
    end
    love.graphics.setCanvas()
    local font = love.graphics.getFont()
    for _, line in ipairs(self.linesList) do
        love.graphics.setColor(line.color)
        love.graphics.print("x: " .. line.vectors[#line.vectors - 1] .. "/y: " .. line.vectors[#line.vectors], self.positionX + self.width, self.positionY + font:getHeight()*(_ - 1))
    end
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.graphic, self.positionX, self.positionY)
    love.graphics.setColor(r, g, b, a)
end

function grapho:touchpressed(id, x, y, dx, dy, pressure)
    if pointRectangleCheckCollision({x = x, y = y}, {x = self.positionX, y = self.positionY, w = self.width, h = self.height}) then
        self.isDrag = id
    end
end

function grapho:touchmoved(id, x, y, dx, dy, pressure)
    if pointRectangleCheckCollision({x = x, y = y}, {x = self.positionX, y = self.positionY, w = self.width, h = self.height}) then
        if self.isDrag == id then
            self.positionX = self.positionX + dx
            self.positionY = self.positionY + dy
        end
    end
end

function grapho:touchreleased(id, x, y, dx, dy, pressure)
    if self.isDrag == id then
        self.isDrag = nil
    end
end

--$_name is a string
--$_color is an array
function grapho:newLine(_name, _color)
    --it create a newList of vectors that are repesented like a line
    table.insert(self.linesList, {
        id = _name,
        color = _color or {1, 1, 1, 1},
        vectors = {}
    })
end
    
--$_name is a string
--$_x is a number
--$_y is a number
function grapho:insertPositionInLine(_name, _x, _y)
    for _, line in ipairs(self.linesList) do
        if line.id == _name then
            table.insert(self.linesList[_].vectors, _x)
            table.insert(self.linesList[_].vectors, self.width - _y)
        end
    end
end

return grapho