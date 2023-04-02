PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(entity)
    EntityWalkState.init(self, entity)
end

function PlayerWalkState:processAI()
    -- do nothing
end

function PlayerWalkState:update(deltaTime)
    if love.keyboard.isDown('a') or love.keyboard.isDown('left') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('walk')
    elseif love.keyboard.isDown('d') or love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('walk')
    elseif love.keyboard.isDown('w') or love.keyboard.isDown('up') then
        self.entity.direction = 'up'
        self.entity:changeAnimation('walk')
    elseif love.keyboard.isDown('s') or love.keyboard.isDown('down') then
        self.entity.direction = 'down'
        self.entity:changeAnimation('walk')
    else
        self.entity:changeState('idle')
    end

    if self.entity.state == 'walk' then
        local walkDistance = ENTITY_DEFINITIONS['player'].walkSpeed * deltaTime

        if self.entity.direction == 'left' then
            self.entity.x = self.entity.x - walkDistance
        elseif self.entity.direction == 'right' then
            self.entity.x = self.entity.x + walkDistance
        elseif self.entity.direction == 'up' then
            self.entity.y = self.entity.y - walkDistance
        else
            self.entity.y = self.entity.y + walkDistance
        end
    end
end