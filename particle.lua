Particle = {}
Particle.__index = Particle

function Particle:create(position, origin)
    local particle = {}
    setmetatable(particle, Particle)
    particle.position = position
    particle.origin = origin
    particle.lifespan = 100
    particle.acceleration = Vector:create(0, 0.08)
    particle.velocity = Vector:create(math.random(-2, -300) / 100, math.random(2, 300) / 100)
    particle.r = random(0, -1*math.pi) + 1
    self.s = random(2, 3) 

    return particle
end

function Particle:update(dt)
    self.velocity:add(self.acceleration)
    self.position[1] = self.position[1] + self.velocity.x * math.cos(self.r)*dt 
    self.position[2]= self.position[2] + self.velocity.y * math.sin(self.r)*dt 
    self.position[3] = self.position[3] + self.velocity.x * math.cos(self.r)*dt 
    self.position[4]= self.position[4] + self.velocity.y * math.sin(self.r)*dt 
    self.lifespan = self.lifespan - 1
end

function Particle:draw()
    pushRotate(self.position[1], self.position[2], self.r)
   -- pushRotate(self.position[3], self.position[4], self.r)
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(get_red_blue_gradient_color(0.0))
    love.graphics.line(self.position[1], self.position[2], self.position[3], self.position[4])
   -- love.graphics.setColor(r, g, b, a)
    love.graphics.pop()
  --  love.graphics.pop()
   --print(self.position[1], self.position[2], self.position[3], self.position[4])
end

function Particle:isDead()
    if self.lifespan < 0 then
        return true
    end

    return false
end