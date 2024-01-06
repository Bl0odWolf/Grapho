# Grapho

 Grapho is a gui to display graphics easily it's can be used to debug
and display animation curves. created _january 06th 2024_ it's in the version
_0.0.3_.

## how to use?

### implementation
 - just fallow the implemtantion below
 ```lua
 function love.load()
     grapho = require("grapho")
     graphic = grapho.new()
 end
 
 function love.draw()
     graphic:draw()
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
 ```

### new line exemple

 ```lua
 function love.load()
     grapho = require("grapho")
     graphic = grapho.new()
     graphic:newLine("speed", {1, 1, 1, 1})
     count = 0
     speed = 0
     aceleration = 0
 end
 
 function love.update(deltaTime)
     count = count + deltaTime
     aceleration = aceleration + 30*deltaTime
     speed = speed + aceleration*deltaTime
     graphic:insertPositionInLine("speed", count, speeed)
 end
 ```
 
 ## User manual
 
 ### new (contructor)
 
 This function create a new graphic with some width and height  
 `grapho.new(x, y, width, height, gridSize)`
 
 ### newLine
  
 This one create a new line with a color in rgba to be displayed in the graphic  
 `newline(id, colorTable)`
 
 ### insertPositionInLine
 
 This one insert two values in the graphic x and y that are displayed like a line  
 `insertPositionInLine(id, x, y)`