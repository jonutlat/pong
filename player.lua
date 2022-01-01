--local field = require "field"

local player = {}

player.width = 5
player.height = 35
player.instance = 1
player.image = nil
player.Move = {}


function player.init()
  player.create()
end

function player.create()  
  player.body = love.physics.newBody(world, 5, 100, "dynamic") 
  player.shape = love.physics.newRectangleShape(player.width, player.height) 
  player.fixture = love.physics.newFixture(player.body, player.shape, 5000.0) 
  player.body:setFixedRotation( true )
  player.fixture:setRestitution(1.0)
  player.fixture:setUserData("player")
end

function player.getBody()
  return player.body
end

function player.getHeight()
  return player.height
end

function player.draw()
    love.graphics.setColor(1, 0.51, 1)
    love.graphics.polygon("fill", player.body:getWorldPoints(player.shape:getPoints()))
    -- Visualize bounding collision box   
    -- local topLeftX, topLeftY, bottomRightX, bottomRightY = player.fixture:getBoundingBox()
    -- love.graphics.rectangle("line", topLeftX,topLeftY,bottomRightX-topLeftX,bottomRightY-topLeftY)
end


function player.update()
  player.kybControl()
end

function player.kybControl()
  -- Player Control
  local maxAcc = 200
 -- if love.keyboard.isDown("right")  then player.body:applyForce(maxAcc,0) end
 -- if love.keyboard.isDown("left")   then player.body:applyForce(maxAcc*-1,0) end
 if love.keyboard.isDown("up")     then player.body:setPosition(10,player.body:getY()-5) end
 if love.keyboard.isDown("down")   then player.body:setPosition(10,player.body:getY()+5) end

-- if love.keyboard.isDown("up")     then player.body:applyForce(0,maxAcc*-1) end
  --if love.keyboard.isDown("down")   then player.body:applyForce(0,maxAcc) end
end

return player