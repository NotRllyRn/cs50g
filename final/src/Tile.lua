Tile = Class{}

function Tile:init(x, y, id, texture)
    self.x = x
    self.y = y
    self.id = id

    self.texture = texture or 'housing'
end

function Tile:render()
    love.graphics.draw(gFrames[self.texture].texture, gFrames[self.texture][self.id], self.x, self.y)
end