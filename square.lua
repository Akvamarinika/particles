Square = {}
Square.__index = Square

local rndSide = math.random(10, 25)

function Square:create(location)
    local square = {}
    setmetatable(square, Square)

    square.width = rndSide  --10
    square.height = rndSide
    square.location = location
    square.maxSize = 50
    square.clicked = false
    square.velocity = Vector:create(1, 1)
    square.acceleration = Vector:create(1, 1)    --100
    square.points = {up = {square.location.x, square.location.y, square.location.x + square.width, square.location.y}, 
                    left = {square.location.x, square.location.y, square.location.x, square.location.y + square.height}, 
                    right = {square.location.x + square.width, square.location.y, square.location.x + square.width, square.location.y + square.height}, 
                    bottom = {square.location.x + square.width, square.location.y + square.height, square.location.x, square.location.y + square.height}}
    square.systemParticle = ParticleSystem:create(square.location, 4, Particle)
    return square
end

function Square:update(dt)
    if self.width <= self.maxSize and self.height <= self.maxSize then
        self.width = self.width + self.velocity.x + (3 * dt)
        self.height = self.height + self.velocity.y + (3 * dt) 
        --love.graphics.setColor(get_red_blue_gradient_color(0.9)) 
    end

    if self.width >= self.maxSize then
        if next(self.systemParticle.particles) == nil then
            --print(self.points['up'])
            self.systemParticle:createParticles(self.points)
         end

        self.systemParticle:updateOne(dt)
    end



end

function Square:draw()
    love.graphics.line(self.points['up']) --верхняя
    love.graphics.line(self.points['left']) -- левая
    love.graphics.line(self.points['right']) --правая
    love.graphics.line(self.points['bottom']) -- нижняя

    
    if self.width <= self.maxSize and self.height <= self.maxSize then
        r, g, b, a = love.graphics.getColor()
        love.graphics.setColor(get_red_blue_gradient_color(0.9)) 
        
    end
       
    

    if self.width >= self.maxSize/2 and self.height >= self.maxSize/2  then
        local r, g, b, a = love.graphics.getColor()
        love.graphics.setColor(get_red_blue_gradient_color(0.2)) 
        self.systemParticle:draw()
        love.graphics.setColor(r, g, b, a)
    end

    

    if self.width >= self.maxSize then
        local r, g, b, a = love.graphics.getColor()
       love.graphics.setColor(0, 0, 0, 0)
       love.graphics.setColor(r, g, b, a)
    end
   -- love.graphics.setColor(r, g, b, a)
end


function Square:clickedFunc(mouseX, mouseY)
    print(mouseX, mouseY)
    if mouseX >= self.location.x and mouseX <= self.location.x + self.width then
        if mouseY >= self.location.y and mouseY < self.location.y + self.height then
            self.clicked = true
            love.graphics.setColor(r, g, b, a)
        end
    end

end