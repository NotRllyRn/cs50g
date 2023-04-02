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
    for k, object in pairs(self.level.objects) do
        if object.solid and self.entity:collides(object) then
            if self.entity.direction == 'left' then
                self.entity.x = object.x + object.width + self.entity.width / 2
            elseif self.entity.direction == 'right' then
                self.entity.x = object.x - self.entity.width / 2
            elseif self.entity.direction == 'up' then
                self.entity.y = object.y + object.height + self.entity.height / 2
            elseif self.entity.direction == 'down' then
                self.entity.y = object.y - self.entity.height / 2
            end

            self.bumped = true
        end
    end
end

function EntityWalkState:checkWallCollisions()
    local leftX = self.level.startX
    local topY = self.level.startY + TILE_SIZE / 4
    local rightX = leftX + self.level.tileWidth * TILE_SIZE
    local bottomY = topY + self.level.tileHeight * TILE_SIZE - TILE_SIZE / 4

    -- // check for collisions with walls
    if self.entity.direction == 'left' then
        if self.entity.x - self.entity.width / 2 <= leftX then
            self.entity.x = leftX + self.entity.width / 2
            self.bumped = true
        end
    elseif self.entity.direction == 'right' then
        if self.entity.x + self.entity.width / 2 >= rightX then
            self.entity.x = rightX - self.entity.width / 2
            self.bumped = true
        end
    elseif self.entity.direction == 'up' then
        if self.entity.y - self.entity.height / 2 <= topY - TILE_SIZE then
            self.entity.y = topY - TILE_SIZE + self.entity.height / 2
            self.bumped = true
        end
    elseif self.entity.direction == 'down' then
        if self.entity.y + self.entity.height / 2 >= bottomY then
            self.entity.y = bottomY - self.entity.height / 2
            self.bumped = true
        end
    end
end