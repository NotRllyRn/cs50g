CatLayingState = Class{__includes = EntityIdleState}

function CatLayingState:init(entity)
    self.entity = entity

    self.entity:changeAnimation('laying')
    self.entity.currentAnimation:refresh()
end

function CatLayingState:processAI(deltaTime)
    if self.entity.currentAnimation.timesPlayed > 0 then
        if self.reverse then
            self.entity:changeState('idle')
        elseif self.sleep then
            self.entity:changeState('sleeping')
        else
            self.entity:changeState('laying', {
                reverse = true,
            })
        end
    end
end

function CatLayingState:enter(params)
    if params then
        if params.reverse then
            self.entity:changeAnimation('laying-reverse')
            self.entity.currentAnimation:refresh()

            self.reverse = true
        end
        self.sleep = params.sleep
    end
end

function CatLayingState:update(deltaTime)
    local stats = self.entity.stats
    self.entity:_updateStats(deltaTime)

    stats.hunger = stats.hunger + 0.01818 * deltaTime
    stats.thirst = stats.thirst + 0.01818 * deltaTime

    stats.energy = stats.energy + 0.012 * deltaTime
end