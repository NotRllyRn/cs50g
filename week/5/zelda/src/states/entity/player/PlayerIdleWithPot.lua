PlayerIdleWithPot = Class{__includes = EntityIdleState}

function PlayerIdleWithPot:enter(params)
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 5
    self.entity.offsetX = 0

    self.entity:changeAnimation('idle-pot-' .. self.entity.direction)
end

function PlayerIdleWithPot:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or love.keyboard.isDown('a') or love.keyboard.isDown('d') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') or love.keyboard.isDown('w') or love.keyboard.isDown('s') then
        self.entity:changeState('walk-pot')
    end

    if love.keyboard.wasPressed('space') then
        self.entity:changeState('idle')

        self.entity.pot:throw()
        self.entity.pot = nil
    end
end