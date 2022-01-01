local fieldDefinition =  require "fieldDefinition"

local field = {}
field.xScale = 0
field.yScale = 0

function field.init(fieldWallSizeX, fieldWallSizeY)
 --define maze
  field = fieldDefinition.stdField
  field.wall = {}
  field.wallCounter = 0
  
  local xFieldPixelDimension = fieldWallSizeX * #field[1]
  local yFieldPixelDimension = fieldWallSizeY * #field
  
  field.xScale = love.graphics.getWidth() / xFieldPixelDimension * 0.95
  field.yScale = love.graphics.getHeight() / yFieldPixelDimension * 0.95
    
  for yFieldPos, yrow in ipairs(field) do
		for xFieldPos, value in ipairs(yrow) do 
			if value == 0 then 
        field.wallCounter = field.wallCounter + 1
        field.wall[field.wallCounter] = {}
        field.wall[field.wallCounter].body = love.physics.newBody(world, fieldWallSizeX*xFieldPos, fieldWallSizeY*yFieldPos, "static")
        field.wall[field.wallCounter].shape = love.physics.newRectangleShape(fieldWallSizeX, fieldWallSizeY) 
        field.wall[field.wallCounter].fixture = love.physics.newFixture(field.wall[field.wallCounter].body, field.wall[field.wallCounter].shape, 1.0) 
      end
		end
  end
end
  
function field.update()
    --for i = 1, maze.wallCounter do
    --  keepInWindow(maze.wall[i])
    --end
end
  
  
function field.getXScale()
  return field.xScale
end

function field.getYScale()
  return field.yScale
end
  
function field.draw()
  love.graphics.setColor(0.9, 0.9, 0.9) 
  for i = 1, field.wallCounter do
    love.graphics.polygon("fill", field.wall[i].body:getWorldPoints(field.wall[i].shape:getPoints()))
  end
end

return field
