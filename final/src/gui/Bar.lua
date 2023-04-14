Bar = Class{}

function Bar:init(def)
    self.x = def.x
    self.y = def.y
    self.length = def.length
    self.color = def.color
    self.value = def.value
    self.max = def.max
    self.direction = def.direction

    self.tileLength = self.length / TILE_SIZE
    self.tiles = {}

    local under = self.y - TILE_SIZE
    local rotation = self.direction == 'verticle' and 90 or 0

    for i = 1, self.tileLength do
        local tile_length = (i - 1) * TILE_SIZE
        local tile

        if i == 1 then
            tile = Tile(
                self.x,
                self.y,
                602,
                'gui'
            )
        elseif i == #self.tileLength then
            tile = Tile(
                self.direction == 'horizontal' and self.x + tile_length or self.x,
                self.direction == 'verticle' and self.y + tile_length or self.y,
                602,
                'gui'
            )
        else
            tile = Tile(
                self.direction == 'horizontal' and self.x + tile_length or self.x,
                self.direction == 'verticle' and self.y + tile_length or self.y,
                603,
                'gui'
            )
        end

        function tile:render()
            love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.id],
                self.x, self.y, i == #self.tileLength and (rotation + 180) or rotation)

            print('rendering bar tile')
        end

        table.insert(self.tiles, tile)
    end
end

function Bar:update(dt) end

-- TODO: Make this render the bar because its broken

function Bar:render()
    for k, tile in pairs(self.tiles) do
        tile:render()
    end
end