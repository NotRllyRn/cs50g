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

    self:generateFloor()
    self:generateObjects()
    self:generateCats()

    self.renderOrder = {}
    for k, entity in ipairs(self.entities) do
        table.insert(self.renderOrder, entity)
    end
end

function Level:generateObjects()
    local right = self.startX + (-1 + self.tileWidth) * TILE_SIZE
    local bottom = self.startY + (-2 + self.tileHeight) * TILE_SIZE
    local top = self.startY - TILE_SIZE

    table.insert(self.objects, Object(self.startX, top,
        OBJECT_DEFINTIONS['bush' .. math.random(4)]))
    table.insert(self.objects, Object(right, top,
        OBJECT_DEFINTIONS['bush' .. math.random(4)]))
    table.insert(self.objects, Object(right, bottom,
        OBJECT_DEFINTIONS['bush' .. math.random(4)]))
    table.insert(self.objects, Object(self.startX, bottom,
        OBJECT_DEFINTIONS['bush' .. math.random(4)]))

    local fountain = {
        onCollide = function(entity)
            if entity.typeOfEntity == 'player' then
                entity.playerWater = 50

                print('replenished water')
            else
                print('cat drank water')
            end
        end
    }

    local fountainX = self.startX + 2 * TILE_SIZE + math.random(self.tileWidth - 5) * TILE_SIZE
    local fountainY = self.startY + 2 * TILE_SIZE + math.random(self.tileHeight - 5) * TILE_SIZE

    table.insert(self.objects, Object(fountainX, fountainY,
        GenerateTileMaps.join(OBJECT_DEFINTIONS['fountain'], fountain)
    ))
end

function Level:generateFloor()
    for y =  0, self.tileHeight - 1 do
        self.tiles[y + 1] = {}
        for x = 0, self.tileWidth - 1 do
            local atX = self.startX + x * TILE_SIZE
            local atY = self.startY + y * TILE_SIZE

            self.tiles[y + 1][x + 1] = Tile(atX, atY, FLOOR_TILE)

            self:generateWall(x, y, atX, atY)
        end
    end
end

function Level:generateCats()
    for cats = 1, 4 do
        local x = math.random(2, self.tileWidth - 2)
        local y = math.random(2, self.tileHeight - 2)

        local atX = self.startX + (x) * TILE_SIZE
        local atY = self.startY + (y) * TILE_SIZE

        local cat = Cat{
            x = atX,
            y = atY,
            level = self,
        }
        cat:changeState('idle')

        while true do
            local collides = false
            for k, object in pairs(self.objects) do
                if cat:collides(object) then
                    collides = true
                    break
                end
            end
            if not collides then
                break
            end
        end

        table.insert(self.entities, cat)
    end
end

function Level:generateWall(x, y, atX, atY)
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

function Level:update(deltaTime)
    for k, object in pairs(self.objects) do
        object:update(deltaTime)
    end

    for k, entity in pairs(self.entities) do
        entity:processAI(deltaTime)
        entity:update(deltaTime)
    end
    self.player:update(deltaTime)

    table.sort(self.renderOrder, function(a, b)
        return a.y + a.height / 2 < b.y + b.height / 2
    end)
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

    for k, a in ipairs(self.renderOrder) do
        a:render()
    end
end