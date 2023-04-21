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

    self.guiElements = {
        water = Bar{
            x = VIRTUAL_WIDTH - 32,
            y = 10,
            length = 20,
            direction = 'vertical',
            color = {0.2, 0.2, 0.8, 1}, -- // blue

            max = 1,
            value = math.max(0.2, math.min(math.random(), 0.5)),
        },
        food = Bar{
            x = VIRTUAL_WIDTH - 32 - 12,
            y = 10,
            length = 20,
            direction = 'vertical',
            color = {0.2, 0.8, 0.2, 1}, -- // green

            max = 1,
            value = math.max(0.2, math.min(math.random(), 0.5))
        },
        catInfo = GuiGroup{
            Backdrop{
                x = CENTER_X / 8 * 3,
                y = CENTER_Y,
                width = CENTER_X / 4 * 3,
                height = VIRTUAL_HEIGHT - 20,
            },
        },
    }

    self.guiElements.catInfo.display = false
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
                if self.guiElements.water.value < 1 then
                    self.guiElements.water:updateValue(1)

                    gSounds['water-splash']
                        [math.random(#gSounds['water-splash'])]:play()
                end
            else
                entity.stats.thirst = entity.stats.thirst - 0.2

                PlaySound(gSounds['water-splash']
                    [math.random(#gSounds['water-splash'])])
            end
        end
    }

    local fountainX = self.startX + 2 * TILE_SIZE + math.random(self.tileWidth - 5) * TILE_SIZE
    local fountainY = self.startY + 2 * TILE_SIZE + math.random(self.tileHeight - 5) * TILE_SIZE

    table.insert(self.objects, Object(fountainX, fountainY,
        GenerateTileMaps.join(OBJECT_DEFINTIONS['fountain'], fountain)
    ))

    for _ = 1, math.random(3) do
        local x = self.startX + 2 * TILE_SIZE + math.random(self.tileWidth - 5) * TILE_SIZE
        local y = self.startY + 2 * TILE_SIZE + math.random(self.tileHeight - 5) * TILE_SIZE

        local fridge = Object(x, y,
        GenerateTileMaps.join(OBJECT_DEFINTIONS['fridge-' .. OBJECT_DEFINTIONS['fridge-colors']
        [math.random(#OBJECT_DEFINTIONS['fridge-colors'])]], {
            onCollide = function(entity)
                if entity.typeOfEntity == 'player' then
                    if self.guiElements.food.value < 1 then
                        self.guiElements.food:updateValue(1)

                        gSounds['food-handled']
                            [math.random(#gSounds['food-handled'])]:play()
                    end
                else
                    entity.stats.hunger = entity.stats.hunger - 0.2

                    PlaySound(gSounds['meow' .. math.random(4)])
                end
            end
        }))

        local collides = true
        while collides do
            fridge.x = self.startX + 2 * TILE_SIZE + math.random(self.tileWidth - 5) * TILE_SIZE
            fridge.y = self.startY + 2 * TILE_SIZE + math.random(self.tileHeight - 5) * TILE_SIZE

            collides = false

            for k, object in pairs(self.objects) do
                if fridge:collides(object) then
                    collides = true
                    break
                end
            end
        end

        table.insert(self.objects, fridge)
    end
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

        local atX = self.startX + x * TILE_SIZE
        local atY = self.startY + y * TILE_SIZE

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

                    cat.x = self.startX + math.random(2, self.tileWidth - 2) * TILE_SIZE
                    cat.y = self.startY + math.random(2, self.tileHeight - 2) * TILE_SIZE

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

function Level:displayCatInfo(cat)
    -- TODO: update the catInfo group of elements to display the cat's information

    self.guiElements.catInfo.display = true
    self.guiElements.catInfo.cat = cat
end

function Level:update(deltaTime)
    for k, object in pairs(self.objects) do
        object:update(deltaTime)
    end

    self.player:update(deltaTime)

    if not self.catSelected then
        local catDisplayingKey
        local displayingKey = false
        for k, entity in pairs(self.entities) do
            entity:processAI(deltaTime)
            entity:update(deltaTime)

            local cat = entity.typeOfEntity == 'cat' and entity or nil
            if cat then
                local distanceFromPlayer = math.sqrt(math.pow(cat.x - self.player.x, 2) + math.pow(cat.y - self.player.y, 2))

                if not displayingKey and distanceFromPlayer < 32 then
                    catDisplayingKey = entity
                    displayingKey = true
                    cat.displayKey = true
                else
                    cat.displayKey = false
                end
            end
        end

        if catDisplayingKey and love.keyboard.wasPressed('e') then
            self.catSelected = catDisplayingKey

            self:displayCatInfo(self.catSelected)
        end
    else
        local distanceFromPlayer = math.sqrt(math.pow(self.catSelected.x - self.player.x, 2) + math.pow(self.catSelected.y - self.player.y, 2))
        if distanceFromPlayer > 32 then
            self.catSelected.displayKey = false
            self.catSelected = nil

            self.guiElements.catInfo.display = false
        end

        if self.catSelected then
            if love.keyboard.wasPressed('e') then
                self.catSelected = nil
                self.guiElements.catInfo.display = false
            else
                self:displayCatInfo(self.catSelected)
            end
        end
    end

    

    for k, element in pairs(self.guiElements) do
        element:update(deltaTime)
    end

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

    for k, entity in ipairs(self.renderOrder) do
        entity:render()
    end

    for k, element in pairs(self.guiElements) do
        element:render()
    end
end