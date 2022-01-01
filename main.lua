
local player  = require "player"
local field = require "field"
local balls   = require "ball"

 GameOver = false 
  
function love.load()
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  GameOverPic = love.graphics.newImage("GameOver.png")
   
  love.graphics.setBackgroundColor( 0, 0, 0)
  world = love.physics.newWorld(0,0,true)
  world:setCallbacks(beginContact, endContact, preSolve, postSolve)
  
  player.init()
  field.init(10, 10)
  
  balls.create(110,110,5,"dynamic", 0.1, 1.04, {0.76, 0.18, 0.05}, "ball1" )
  balls.create(120,90,5,"dynamic", 0.1, 1.04, {1/255, 157/255, 131/255}, "ball2")
  balls.create(150,80,5,"dynamic", 0.1, 1.04, {1/255, 157/255, 131/255}, "ball3")
  balls.create(170,100,5,"dynamic", 0.1, 1.04, {1/255, 157/255, 131/255}, "ball4")

end -- load()


function love.update(dt)
  world:update(dt)
  player.update()
  --if balls.update() then os.exit() end
  GameOver = balls.anyOneOut()
end --update()


function love.draw()
  love.graphics.scale(field.getXScale(),field.getYScale())
  print(field.getXScale())
  if GameOver then
    love.graphics.draw(GameOverPic,20,20)
  end
  player.draw()
  balls.draw()
  field.draw()
end  --draw()


function love.keypressed(key, u)
    --Debug
    if key == "q" then debug.debug() end
    if key == "escape" then os.exit() end 
end

--[[
function beginContact(a, b, coll)

  if (a:getUserData() == "smallBall" and b:getUserData() == "player") or
    (a:getUserData() == "player" and b:getUserData() == "smallBall") then
        aB = a:getBody()
        bB = b:getBody()
        if jointExits == false then
      --   love.physics.newMotorJoint( aB, bB, 0.3)
          jointExits = true
        end
  end
end

]]