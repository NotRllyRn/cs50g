PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:processAI()
    -- // do nothing
end

function PlayerIdleState:update(deltaTime)
    if love.keyboard.wasPressed('a') or love.keyboard.wasPressed('d') or love.keyboard.wasPressed('w') or love.keyboard.wasPressed('s') 
        or love.keyboard.wasPressed('left') or love.keyboard.wasPressed('right') or love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        self.entity:changeState('walk')
    end
end

