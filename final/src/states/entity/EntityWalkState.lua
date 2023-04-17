--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

EntityWalkState = Class{__includes = BaseState}

function EntityWalkState:init(entity, level)
    self.entity = entity
    self.entity:changeAnimation('walk')

    self.level = level

    -- used for AI control
    self.moveDuration = 0
    self.movementTimer = 0

    -- keeps track of whether we just hit a wall
    self.bumped = false
end

function EntityWalkState:update(deltaTime)
    self.bumped = false

    local walkDistance = ENTITY_DEFINITIONS[self.entity.typeOfEntity].walkSpeed * deltaTime

    if self.entity.direction == 'left' then
        self.entity.x = self.entity.x - walkDistance
    elseif self.entity.direction == 'right' then
        self.entity.x = self.entity.x + walkDistance
    elseif self.entity.direction == 'up' then
        self.entity.y = self.entity.y - walkDistance
    elseif self.entity.direction == 'down' then
        self.entity.y = self.entity.y + walkDistance
    end

    self:checkWallCollisions()
    if not self.bumped then
        self:checkObjectCollisions()
    end
end

function EntityWalkState:processAI(deltaTime)
    local directions = {'left', 'right', 'up', 'down'}

    if self.moveDuration == 0 or self.bumped then
        
        -- set an initial move duration and direction
        self.moveDuration = math.random(5)
        self.entity.direction = directions[math.random(#directions)]
        self.entity:changeAnimation('walk')
    elseif self.movementTimer > self.moveDuration then
        self.movementTimer = 0

        -- chance to go idle
        if math.random(3) == 1 then
            self.entity:changeState('idle')
        else
            self.moveDuration = math.random(5)
            self.entity.direction = directions[math.random(#directions)]
            self.entity:changeAnimation('walk')
        end
    end

    self.movementTimer = self.movementTimer + deltaTime
end

function EntityWalkState:render()
    self.entity:render()
end

function EntityWalkState:checkObjectCollisions()
    local isPlayer = self.entity.typeOfEntity == 'player'
    local left = isPlayer and (love.keyboard.isDown('left') or love.keyboard.isDown('a')) or self.entity.direction == 'left'
    local right = isPlayer and (love.keyboard.isDown('right') or love.keyboard.isDown('d')) or self.entity.direction == 'right'
    local up = isPlayer and (love.keyboard.isDown('up') or love.keyboard.isDown('w')) or self.entity.direction == 'up'
    local down = isPlayer and (love.keyboard.isDown('down') or love.keyboard.isDown('s')) or self.entity.direction == 'down'

    for k, object in pairs(self.level.objects) do
        if object.solid and self.entity:collides(object) then
            local horizontal = math.floor(math.abs(object.x + object.width / 2 - self.entity.x) + 0.5)
            local vertical = math.floor(math.abs(object.y + object.height / 2 - self.entity.y) + 0.5)

            local sideways = nil
            if (left or right) and (up or down) then
                sideways = horizontal < vertical
            end

            -- TODO: i need to fix this so that the character doesn't get teleported back to another corner.
            -- it's not a huge deal, but it's a little annoying
            -- i can fix it by calculating each distance the character gets teleported and check which one is the smallest then use that one
            -- but i'm not sure if that's the best way to do it

            if (sideways == nil and left) or (not sideways and left) then
                self.entity.x = object.x + object.width + self.entity.width / 2
            elseif (sideways == nil and right) or (not sideways and right) then
                self.entity.x = object.x - self.entity.width / 2
            end
            if (sideways == nil and up) or (sideways and up) then
                self.entity.y = object.y + object.height + self.entity.height / 2
            elseif (sideways == nil and down) or (sideways and down) then
                self.entity.y = object.y - self.entity.height / 2
            end

            object:touched(self.entity)

            self.bumped = true
        end
    end
end

function EntityWalkState:checkWallCollisions()
    local leftX = self.level.startX
    local topY = self.level.startY + TILE_SIZE / 4
    local rightX = leftX + self.level.tileWidth * TILE_SIZE
    local bottomY = topY + self.level.tileHeight * TILE_SIZE - TILE_SIZE / 4

    local isPlayer = self.entity.typeOfEntity == 'player'
    local left = isPlayer and (love.keyboard.isDown('left') or love.keyboard.isDown('a')) or self.entity.direction == 'left'
    local right = isPlayer and (love.keyboard.isDown('right') or love.keyboard.isDown('d')) or self.entity.direction == 'right'
    local up = isPlayer and (love.keyboard.isDown('up') or love.keyboard.isDown('w')) or self.entity.direction == 'up'
    local down = isPlayer and (love.keyboard.isDown('down') or love.keyboard.isDown('s')) or self.entity.direction == 'down'

    -- // check for collisions with walls
    if left then
        if self.entity.x - self.entity.width / 2 <= leftX then
            self.entity.x = leftX + self.entity.width / 2
            self.bumped = true
        end
    elseif right then
        if self.entity.x + self.entity.width / 2 >= rightX then
            self.entity.x = rightX - self.entity.width / 2
            self.bumped = true
        end
    end
    if up then
        if self.entity.y - self.entity.height / 2 <= topY - TILE_SIZE then
            self.entity.y = topY - TILE_SIZE + self.entity.height / 2
            self.bumped = true
        end
    elseif down then
        if self.entity.y + self.entity.height / 2 >= bottomY then
            self.entity.y = bottomY - self.entity.height / 2
            self.bumped = true
        end
    end
end