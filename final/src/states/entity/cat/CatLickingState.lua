CatLickingState = Class{__includes = EntityIdleState}

function CatLickingState:init(entity)
    self.entity = entity

    self.entity:changeAnimation('licking' .. math.random(2))

    self.waitDuration = 0
    self.waitTimer = 0
end

function CatLickingState:update(deltaTime)
    local stats = self.entity.stats
    self.entity:_updateStats(deltaTime)

    stats.hunger = stats.hunger + DECREASE_RATE * deltaTime
    stats.thirst = stats.thirst + 0.02 * deltaTime

    stats.energy = stats.energy + 0.01 * deltaTime
end

function CatLickingState:processAI(deltaTime)
    if self.waitDuration == 0 then
        self.waitDuration = math.random(5) + math.random() - 1
    else
        self.waitTimer = self.waitTimer + deltaTime

        if self.waitTimer > self.waitDuration then
            if math.random(5) == 1 then
                self.entity:changeState('sitting')
            else
                self.entity:changeState('idle')
            end
        end
    end
end

