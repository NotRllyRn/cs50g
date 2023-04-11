CatItchState = Class{__includes = EntityIdleState}

function CatItchState:init(entity)
    self.entity = entity

    self.entity:changeAnimation('itch')

    self.waitDuration = 0
    self.waitTimer = 0
end

function CatItchState:update(deltaTime)
    local stats = self.entity.stats
    self.entity:_updateStats(deltaTime)

    stats.hunger = stats.hunger + 0.02 * deltaTime
    stats.thirst = stats.thirst + DECREASE_RATE * deltaTime

    stats.energy = stats.energy + 0.01 * deltaTime
end

function CatItchState:processAI(deltaTime)
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

