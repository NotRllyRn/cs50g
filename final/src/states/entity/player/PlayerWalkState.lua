PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:processAI()
    -- do nothing
end

function PlayerWalkState:update(deltaTime)
    self.bumped = false
    local shift = love.keyboard.isDown('lshift')

    if shift then
        self.entity:changeState('run')
        return
    end

    local left = love.keyboard.isDown('a') or love.keyboard.isDown('left')
    local right = love.keyboard.isDown('d') or love.keyboard.isDown('right')
    local up = love.keyboard.isDown('w') or love.keyboard.isDown('up')
    local down = love.keyboard.isDown('s') or love.keyboard.isDown('down')

    if left then
        self.entity.direction = 'left'
        self.entity:changeAnimation('walk')
    elseif right then
        self.entity.direction = 'right'
        self.entity:changeAnimation('walk')
    elseif up then
        self.entity.direction = 'up'
        self.entity:changeAnimation('walk')
    elseif down then
        self.entity.direction = 'down'
        self.entity:changeAnimation('walk')
    else
        self.entity:changeState('idle')
    end

    if self.entity.state == 'walk' then
        local walkDistance = ENTITY_DEFINITIONS['player'].walkSpeed * deltaTime

        if (left or right) and (up or down) then
            walkDistance = walkDistance * 0.7
        end

        if left then
            self.entity.x = self.entity.x - walkDistance
        elseif right then
            self.entity.x = self.entity.x + walkDistance
        end
        if up then
            self.entity.y = self.entity.y - walkDistance
        elseif down then
            self.entity.y = self.entity.y + walkDistance
        end
    end

    self:checkWallCollisions()
    if not self.bumped then
        self:checkObjectCollisions()
    end
end