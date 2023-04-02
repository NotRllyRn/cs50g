Object = Class{__includes = BaseState}

function Object:init(def)
    self.x = def.x
    self.y = def.y

    self.width = def.width
    self.height = def.height
    
    self.tiles = def.tiles

    self.onCollide = def.onCollide or function() end
    self.onConsume = def.onConsume or function() end

    self.collidable = def.collidable
    self.consumable = def.consumable

    self.solid = def.solid == nil and true or def.solid

    self.frame = def.frame
end

function Object:render()
    for y, row in pairs(self.tiles) do
        for x, tile_id in pairs(row) do
            love.graphics.draw(self.frame.texture, self.frame[tile_id], self.x + (x - 1) * TILE_SIZE, self.y + (y - 1) * TILE_SIZE)
        end
    end
end