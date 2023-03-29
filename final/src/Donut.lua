Donut = Class{}

function Donut:init(x, y)
    self.x = x or 0
    self.y = y or 0
    self.width = 32
    self.height = 32
    self.color = math.random(1, 9)
end

function Donut:render()
    love.graphics.draw(gTextures['tiles'], gFrames['donuts'][self.color], self.x, self.y)
end