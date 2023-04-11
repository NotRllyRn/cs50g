CatStretchingState = Class{__includes = EntityIdleState}

-- TODO: test if this works only playing for 1 frame.

function CatStretchingState:init(entity)
    self.entity = entity

    self.entity:changeAnimation('stretching')
    self.entity.currentAnimation:refresh()

    self.waitDuration = 0
    self.waitTimer = 0
end

function CatStretchingState:enter(params)
    if params then
        if params.reverse then
            self.entity:changeAnimation('stretching-reverse')
            self.entity.currentAnimation:refresh()

            self.reverse = true
        end
    end
end

function CatStretchingState:update(deltaTime)
    local stats = self.entity.stats
    self.entity:_updateStats(deltaTime)

    stats.hunger = stats.hunger + DECREASE_RATE * deltaTime
    stats.thirst = stats.thirst + DECREASE_RATE * deltaTime

    stats.energy = stats.energy + 0.01 * deltaTime
end

function CatStretchingState:processAI(deltaTime)
    if self.waitDuration == 0 then
        self.waitDuration = math.random(5) + math.random() - 1
    else
        self.waitTimer = self.waitTimer + deltaTime

        if self.waitTimer > self.waitDuration then
            if self.entity.currentAnimation.timesPlayed > 0 then
                if self.reverse then
                    self.entity:changeState('idle')
                else
                    self.entity:changeState('stretching', {
                        reverse = true,
                    })
                end
            end
        end
    end
end