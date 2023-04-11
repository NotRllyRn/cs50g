CatSittingState = Class{__includes = EntityIdleState}

function CatSittingState:init(entity)
    self.entity = entity

    self.entity:changeAnimation('sitting')

    self.waitDuration = 0
    self.waitTimer = 0
end

function CatSittingState:update(deltaTime)
    local stats = self.entity.stats
    self.entity:_updateStats(deltaTime)

    stats.hunger = stats.hunger + 0.01 * deltaTime
    stats.thirst = stats.thirst + 0.01 * deltaTime
end

function CatSittingState:processAI(deltaTime)
    local stats = self.entity.stats

    if self.waitDuration == 0 then
        self.waitDuration = math.random(5)
    else
        self.waitTimer = self.waitTimer + deltaTime

        if self.waitTimer > self.waitDuration then
            if math.random(2) == 1 then
                local is_thirsty = stats.thirst < math.random()
                local is_hungry = stats.hunger < math.random()

                if is_thirsty and is_hungry then
                    if math.random(2) == 1 then
                        self.entity:changeState('licking')
                    else
                        self.entity:changeState('itch')
                    end
                elseif is_thirsty then
                    self.entity:changeState('licking')
                elseif is_hungry then
                    self.entity:changeState('itch')
                else
                    self.entity:changeState('idle')
                end
            else
                self.entity:changeState('idle')
            end
        end
    end
end