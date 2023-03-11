--[[
    GD50
    Super Mario Bros. Remake

    -- PlayState Class --
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.camX = 0
    self.camY = 0

    self.backgroundX = 0

    self.gravityOn = true
    self.gravityAmount = 6
end

function PlayState:enter(def)
    self.level = def.level or LevelMaker.generate(def.width + LEVEL_WIDTH_INCREMENT, 10)
    self.tileMap = self.level.tileMap
    self.background = def.background or math.random(3)

    self.player = Player({
        x = 0, y = 0,
        width = 16, height = 20,
        texture = 'green-alien',
        stateMachine = StateMachine {
            ['idle'] = function() return PlayerIdleState(self.player) end,
            ['walking'] = function() return PlayerWalkingState(self.player) end,
            ['jump'] = function() return PlayerJumpState(self.player, self.gravityAmount) end,
            ['falling'] = function() return PlayerFallingState(self.player, self.gravityAmount) end
        },
        map = self.tileMap,
        level = self.level,
        score = def.score,
    })

    self:spawnEnemies()
    self:spawnKeyandLock(self.player)

    self.player:changeState('falling')
end

function PlayState:update(dt)
    Timer.update(dt)

    -- remove any nils from pickups, etc.
    self.level:clear()

    -- update player and level
    self.player:update(dt)
    self.level:update(dt)
    self:updateCamera()

    -- constrain player X no matter which state
    if self.player.x <= 0 then
        self.player.x = 0
    elseif self.player.x > TILE_SIZE * self.tileMap.width - self.player.width then
        self.player.x = TILE_SIZE * self.tileMap.width - self.player.width
    end
end

function PlayState:render()
    love.graphics.push()
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX), 0)
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX),
        gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX + 256), 0)
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX + 256),
        gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)
    
    -- translate the entire view of the scene to emulate a camera
    love.graphics.translate(-math.floor(self.camX), -math.floor(self.camY))
    
    self.level:render()

    self.player:render()
    love.graphics.pop()
    
    -- render score
    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print(tostring(self.player.score), 5, 5)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(tostring(self.player.score), 4, 4)
end

function PlayState:spawnFlag()
    if self.flag then return end

    local level = self.level
    local tileMap = self.tileMap

    -- spawn flag at the end of the level
    local pole_base_x = math.random(tileMap.width - 4, tileMap.width - 2)
    -- flag spawns on top of ground level
    local y_start = 6

    local pole_type = math.random(6)
    local flag_type = math.random(4)
    for index = 0, 2 do
        local pole = GameObject {
            texture = 'poles',
            x = (pole_base_x - 1) * TILE_SIZE,
            y = (y_start - 1) * TILE_SIZE,
            width = 16,
            height = 16,
            frame = (pole_type - 1) * 3 + index + 1,
            collidable = false,
            consumable = false,
            solid = false,
            hit = false
        }
        table.insert(level.objects, pole)
        y_start = y_start - 1
    end

    local flag = GameObject {
        texture = 'flags',
        x = (pole_base_x - 1) * TILE_SIZE + (TILE_SIZE / 2),
        y = (y_start) * TILE_SIZE,
        width = 16,
        height = 16,
        collidable = false,
        consumable = true,
        solid = false,
        hit = false,
        onConsume = function(player, object)
            gStateMachine:change('play', {
                width = self.tileMap.width,
                score = player.score
            })
        end,
    }

    flag.currentAnimation = Animation {
        frames = {(flag_type - 1) * 3 + 1, (flag_type - 1) * 3 + 2, (flag_type - 1) * 3 + 3},
        interval = 0.25
    }

    function flag:update(dt)
        self.currentAnimation:update(dt)
    end

    function flag:render()
        love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrame()],
            self.x, self.y)
    end

    table.insert(level.objects, flag)
    self.flag = true
end

function PlayState:spawnKeyandLock(player)
    local level = self.level
    local tileMap = self.tileMap

    -- generate a random key somewhere in the level
    local keyX = nil
    local keyY = nil
    -- repeats until a key is placed in a valid location
    while not keyY do
        keyX = math.random(6, tileMap.width - 6)
        -- find the highest ground tile and place the key just above it
        for y = 1, tileMap.height do
            if tileMap.tiles[y][keyX].id == TILE_ID_GROUND then
                keyY = y - 1
                break
            end
        end
    end

    local key_lock_pair = math.random(#KEYS)

    -- create the key and place it in the level
    table.insert(level.objects,
        GameObject {
            texture = 'keys-and-locks',
            x = (keyX - 1) * TILE_SIZE,
            y = (keyY - 1) * TILE_SIZE,
            width = 16,
            height = 16,
            frame = KEYS[key_lock_pair],
            collidable = true,
            consumable = true,
            solid = false,
            onConsume = function(player, object)
                gSounds['pickup']:play()
                player.hasKey = true
            end
        }
    )

    -- generate a random lock somewhere in the level
    local lockX = nil
    local lockY = nil
    -- repeats until a lock is placed in a valid location
    while not lockY do
        lockX = math.random(7, tileMap.width - 7)
        -- find the highest ground tile and place the lock 2 tiles above it
        for y = 1, tileMap.height do
            if tileMap.tiles[y][lockX].id == TILE_ID_GROUND then
                lockY = y - 3
                break
            end
        end
    end

    -- create the lock and place it in the level
    table.insert(level.objects,
        GameObject {
            texture = 'keys-and-locks',
            x = (lockX - 1) * TILE_SIZE,
            y = (lockY - 1) * TILE_SIZE,
            width = 16,
            height = 16,
            frame = LOCKS[key_lock_pair],
            collidable = true,
            consumable = false,
            solid = true,
            onCollide = function(obj)
                if player.hasKey then
                    gSounds['pickup']:play()
                    player.hasKey = false
                    for k, object in pairs(level.objects) do
                        if object == obj then
                            table.remove(level.objects, k)
                        end
                    end

                    -- spawn the end level flag
                    self:spawnFlag()
                else
                    gSounds['empty-block']:play()
                end
            end
        }
    )
end

function PlayState:updateCamera()
    -- clamp movement of the camera's X between 0 and the map bounds - virtual width,
    -- setting it half the screen to the left of the player so they are in the center
    self.camX = math.max(0,
        math.min(TILE_SIZE * self.tileMap.width - VIRTUAL_WIDTH,
        self.player.x - (VIRTUAL_WIDTH / 2 - 8)))

    -- adjust background X to move a third the rate of the camera for parallax
    self.backgroundX = (self.camX / 3) % 256
end

--[[
    Adds a series of enemies to the level randomly.
]]
function PlayState:spawnEnemies()
    -- spawn snails in the level
    for x = 1, self.tileMap.width do

        -- flag for whether there's ground on this column of the level
        local groundFound = false

        for y = 1, self.tileMap.height do
            if not groundFound then
                if self.tileMap.tiles[y][x].id == TILE_ID_GROUND then
                    groundFound = true

                    -- random chance, 1 in 20
                    if math.random(20) == 1 then
                        
                        -- instantiate snail, declaring in advance so we can pass it into state machine
                        local snail
                        snail = Snail {
                            texture = 'creatures',
                            x = (x - 1) * TILE_SIZE,
                            y = (y - 2) * TILE_SIZE + 2,
                            width = 16,
                            height = 16,
                            stateMachine = StateMachine {
                                ['idle'] = function() return SnailIdleState(self.tileMap, self.player, snail) end,
                                ['moving'] = function() return SnailMovingState(self.tileMap, self.player, snail) end,
                                ['chasing'] = function() return SnailChasingState(self.tileMap, self.player, snail) end
                            }
                        }
                        snail:changeState('idle', {
                            wait = math.random(5)
                        })

                        table.insert(self.level.entities, snail)
                    end
                end
            end
        end
    end
end