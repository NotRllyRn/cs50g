CatSleepingState = Class{__includes = BaseState}

function CatSleepingState:init(entity)
    self.entity = entity

    self.entity:changeAnimation('sleeping' .. math.random(2))

    self.waitDuration = 0
    self.waitTimer = 0
end

function CatSleepingState:update(deltaTime)
    local stats = self.entity.stats
    self.entity:_updateStats(deltaTime)

    stats.hunger = stats.hunger + DECREASE_RATE * deltaTime
    stats.thirst = stats.thirst + DECREASE_RATE * deltaTime

    stats.energy = stats.energy + 0.04 * deltaTime
end

function CatSleepingState:processAI(deltaTime)
    if self.waitDuration == 0 then
        self.waitDuration = math.random(5, 10) + math.random() - 1
    else
        self.waitTimer = self.waitTimer + deltaTime

        if self.waitTimer > self.waitDuration then
            if math.random(3) == 1 then
                self.entity:changeState('sitting')
            else
                self.entity:changeState('laying', {
                    reverse = true,
                })
            end
        end
    end
end