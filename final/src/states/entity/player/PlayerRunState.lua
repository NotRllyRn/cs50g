PlayerRunState = Class{__includes = EntityWalkState}

function PlayerRunState:init(entity, level)
    EntityWalkState.init(self, entity, level)

    self.entity:changeAnimation('run')
end

function PlayerRunState:processAI()
    -- do nothing
end

function PlayerRunState:update(deltaTime)
    local shift = love.keyboard.isDown('lshift')

    if not shift then
        self.entity:changeState('walk')
        return
    end

    if love.keyboard.isDown('a') or love.keyboard.isDown('left') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('run')
    elseif love.keyboard.isDown('d') or love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('run')
    elseif love.keyboard.isDown('w') or love.keyboard.isDown('up') then
        self.entity.direction = 'up'
        self.entity:changeAnimation('run')
    elseif love.keyboard.isDown('s') or love.keyboard.isDown('down') then
        self.entity.direction = 'down'
        self.entity:changeAnimation('run')
    else
        self.entity:changeState('idle')
    end

    if self.entity.state == 'run' then
        local walkDistance = ENTITY_DEFINITIONS['player'].runSpeed * deltaTime

        if self.entity.direction == 'left' then
            self.entity.x = self.entity.x - walkDistance
        elseif self.entity.direction == 'right' then
            self.entity.x = self.entity.x + walkDistance
        elseif self.entity.direction == 'up' then
            self.entity.y = self.entity.y - walkDistance
        else
            self.entity.y = self.entity.y + walkDistance
        end

        EntityWalkState.checkWallCollisions(self)
    end
end