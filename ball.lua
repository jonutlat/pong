--local field = require "field"

local balls = {}
balls.listOfBalls = {} -- have to do this otherwise there is a mix of functions and ball-elements in balls

function balls.create(xPos,yPos,radius,physType, mass, bumpy, color, name)
  ball = {}
  ball.body = love.physics.newBody(world, xPos, yPos, physType) 
  ball.shape = love.physics.newCircleShape(radius) 
  ball.fixture = love.physics.newFixture(ball.body, ball.shape, mass) 
  ball.fixture:setRestitution(bumpy) 
  ball.fixture:setUserData(name)
  ball.color = color 
  table.insert(balls.listOfBalls,ball)
  ball.body:applyForce(460+love.math.random(300),360+love.math.random(600)) 
end

function balls.getBall(n)
  return balls.listOfBalls[n].body
end

function balls.anyOneOut()
  for _,ball in pairs(balls.listOfBalls) do
    if ball.body:getX() < 0 then
      return true
    end
 end
 return false
end

function balls.draw()
   for _,ball in pairs(balls.listOfBalls) do
      love.graphics.setColor(ball.color[1], ball.color[2], ball.color[3]) --set the drawing color to red for the ball
      love.graphics.circle("fill", ball.body:getX(), ball.body:getY(), ball.shape:getRadius())
  end
end
 
return balls