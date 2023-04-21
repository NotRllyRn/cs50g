Bar = Class{}

function Bar:init(def)
    self.x = def.x
    self.y = def.y
    self.length = def.length
    self.color = def.color
    self.value = def.value
    self.max = def.max
    self.direction = def.direction

    self.fill = self.value and self.max and self.length and (self.length * TILE_SIZE - 22) * (self.value / self.max) or 0

    self.tiles = {}

    local under = self.y - TILE_SIZE
    local rotation = self.direction == 'vertical' and math.pi/2 or 0

    for i = 1, self.length do
        local tile_length = (i - 1) * TILE_SIZE
        local tile

        if i == 1 then
            tile = Tile(
                self.x,
                self.y,
                602,
                'gui'
            )
        elseif i == self.length then
            tile = Tile(
                self.direction == 'horizontal' and self.x + tile_length or self.x,
                self.direction == 'vertical' and self.y + tile_length or self.y,
                602,
                'gui'
            )
        else
            tile = Tile(
                self.direction == 'horizontal' and self.x + tile_length or self.x,
                self.direction == 'vertical' and self.y + tile_length or self.y,
                603,
                'gui'
            )
        end

        local bar = self
        function tile:render()
            local vertical = bar.direction == 'vertical'
            local horizontal = bar.direction == 'horizontal'
            local last = bar.length == i
            local horizontal_last = horizontal and last

            love.graphics.draw(gFrames[self.texture].texture, gFrames[self.texture][self.id],
                self.x + ((vertical and not last or horizontal_last) and TILE_SIZE or 0),
                self.y + (last and TILE_SIZE or 0), rotation, last and -1 or 1)

            -- // border for debugging
            --love.graphics.setColor(1, 0, 0, 1)
            --love.graphics.rectangle('line', self.x, self.y, TILE_SIZE, TILE_SIZE)
            --love.graphics.setColor(1, 1, 1, 1)
        end

        table.insert(self.tiles, tile)
    end
end

function Bar:update(deltaTime) end

function Bar:updateValue(value)
    self.value = value

    local percent = self.value / self.max

    self.fill = (self.length * TILE_SIZE - 22) * percent
end

function Bar:render()
    local horizontal = self.direction == 'horizontal'
    local vertical = self.direction == 'vertical'

    if self.color then
        love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.color[4])
    else
        love.graphics.setColor(0, 1, 0, 1)
    end

    love.graphics.rectangle('fill', self.x + (vertical and TILE_SIZE / 4 or 12), self.y + (horizontal and TILE_SIZE / 4 or 12),
        self.direction == 'horizontal' and self.fill or TILE_SIZE / 2, self.direction == 'vertical' and self.fill or TILE_SIZE / 2)

    love.graphics.setColor(1, 1, 1, 1)
    for k, tile in pairs(self.tiles) do
        tile:render()
    end
end