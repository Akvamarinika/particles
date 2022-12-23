require("utilsfunc")
require("vector")
require("square")
require("particle")
require("particlesystem")


function love.load(arg)
    widthField = love.graphics.getWidth()
    heightField = love.graphics.getHeight()
   -- local location = math.random(widthField - 100, heightField - 100)
    

    squareTable = {}

    for i = 1, 10 do
        local x = math.random(100, widthField-100)
        local y = math.random(100, heightField-100)
        table.insert(squareTable, Square:create(Vector:create(x, y)))
    end
 
 --   square = Square:create(location)




    
end

function love.update(dt)
 --   if square.clicked then
 --       square:update(dt)
 --   end

 for i = 1, #squareTable do
    local square1 = squareTable[i]
    if square1.clicked then
       square1:update(dt)
    end
 end
    

end

function love.draw(dt)
--    square:draw()
    for i = 1, #squareTable do
        local square1 = squareTable[i]
        local r, g, b, a = love.graphics.getColor()
           square1:draw()
       -- love.graphics.setColor(r, g, b, a)   
    end
end




function love.keypressed(key)
    --exit game:
    if key == "escape" then
        love.event.push("quit")
      end

end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then 
        for i = 1, #squareTable do
            local square1 = squareTable[i]
            square1:clickedFunc(x, y)
        end

        --square:clickedFunc(x, y)
    end
 end

