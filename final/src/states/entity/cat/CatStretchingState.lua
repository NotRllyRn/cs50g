CatStretchingState = Class{__includes = EntityIdleState}

-- TODO: test if this works only playing for 1 frame.

function CatStretchingState:init(entity)
    self.entity = entity

    self.entity:changeAnimation('stretching')
    self.entity.currentAnimation:refresh()

    self.waitDuration = 0
    self.waitTimer = 0
end

function CatStretchingState:update(deltaTime)
    local stats = self.entity.stats

    if stats.hunger + 0.2 > math.random() then
        if math.random(10) == 1 then
            stats.happiness = stats.happiness - 0.0166 * deltaTime
        end
    else
        stats.happiness = stats.happiness + 0.01 * deltaTime
    end

    if stats.thirst + 0.2 > math.random() then
        if math.random(10) == 1 then
            stats.happiness = stats.happiness - 0.0166 * deltaTime
        end
    else
        stats.happiness = stats.happiness + 0.01 * deltaTime
    end

    stats.hunger = stats.hunger + 0.01818 * deltaTime
    stats.thirst = stats.thirst + 0.01818 * deltaTime

    stats.energy = stats.energy + 0.01 * deltaTime

    if self.entity.currentAnimation.timesPlayed > 0 then
        self.entity:changeState('idle')
    end
end

function CatStretchingState:processAI(deltaTime)
    -- // do nothing
end