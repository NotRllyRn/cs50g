Level = Class{}

function Level:init(def)
    self.entities = {}
    self.player = def.player
    self.objects = {}

    self.tiles = {}
    self.walls = {}

    self.tileWidth = def.tileWidth
    self.tileHeight = def.tileHeight

    self.startX = CENTER_X - (self.tileWidth * TILE_SIZE) / 2
    self.startY = CENTER_Y - (self.tileHeight * TILE_SIZE) / 2

    for y =  0, self.tileHeight - 1 do
        self.tiles[y + 1] = {}
        for x = 0, self.tileWidth - 1 do
            local atX = self.startX + x * TILE_SIZE
            local atY = self.startY + y * TILE_SIZE

            self.tiles[y + 1][x + 1] = Tile(atX, atY, FLOOR_TILE)

            if y == 0 then
                table.insert(self.walls,
                    Tile(atX, atY - TILE_SIZE, 1828, 'walls')
                )
                table.insert(self.walls,
                    Tile(atX, atY - TILE_SIZE * 2, 1753, 'walls')
                )
                if x == 0 then
                    table.insert(self.walls,
                        Tile(atX - TILE_SIZE / 2, atY - TILE_SIZE, 1827, 'walls')
                    )
                    table.insert(self.walls,
                        Tile(atX - TILE_SIZE / 2, atY - TILE_SIZE * 2, 1752, 'walls')
                    )
                    table.insert(self.walls,
                        Tile(atX - TILE_SIZE / 2, atY, 2202, 'walls')
                    )
                elseif x == self.tileWidth - 1 then
                    table.insert(self.walls,
                        Tile(atX + TILE_SIZE / 2, atY - TILE_SIZE, 1835, 'walls')
                    )
                    table.insert(self.walls,
                        Tile(atX + TILE_SIZE / 2, atY - TILE_SIZE * 2, 1760, 'walls')
                    )
                    table.insert(self.walls,
                        Tile(atX + TILE_SIZE / 2, atY, 2210, 'walls')
                    )
                end
            elseif x == 0 then
                table.insert(self.walls,
                    Tile(atX - TILE_SIZE / 2, atY, 2202, 'walls')
                )
            elseif x == self.tileWidth - 1 then
                table.insert(self.walls,
                    Tile(atX + TILE_SIZE / 2, atY, 2210, 'walls')
                )
            end
        end
    end
end

function Level:update(deltaTime)
    for k, object in pairs(self.objects) do
        object:update(deltaTime)
    end

    for k, entity in pairs(self.entities) do
        entity:update(deltaTime)
    end

    self.player:update(deltaTime)
end

function Level:render()
    for y = 1, self.tileHeight do
        for x = 1, self.tileWidth do
            self.tiles[y][x]:render()
        end
    end

    for k, wall in pairs(self.walls) do
        wall:render()
    end

    for k, object in pairs(self.objects) do
        object:render()
    end

    for k, entity in pairs(self.entities) do
        entity:render()
    end

    self.player:render()
end