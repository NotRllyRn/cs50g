CatWalkState = Class{__includes = EntityWalkState}

function CatWalkState:update(deltaTime)
    EntityWalkState.update(self, deltaTime)
    local stats = self.entity.stats

    if stats.hunger + 0.2 > math.random() then
        if math.random(8) == 1 then
            stats.happiness = stats.happiness - 0.02 * deltaTime
        end
    else
        stats.happiness = stats.happiness + 0.01 * deltaTime
    end

    if stats.thirst + 0.2 > math.random() then
        if math.random(8) == 1 then
            stats.happiness = stats.happiness - 0.02 * deltaTime
        end
    else
        stats.happiness = stats.happiness + 0.01 * deltaTime
    end

    stats.hunger = stats.hunger + 0.01818 * deltaTime
    stats.thirst = stats.thirst + 0.01818 * deltaTime
end

function CatWalkState:processAI(deltaTime)
    local directions = {'left', 'right', 'up', 'down'}
    local stats = self.entity.stats

    if self.moveDuration == 0 or self.bumped then
        
        -- set an initial move duration and direction
        self.moveDuration = math.random(5) + math.random() - 1
        self.entity.direction = directions[math.random(#directions)]
        self.entity:changeAnimation('walk')
    elseif self.movementTimer > self.moveDuration then
        self.movementTimer = 0

        -- chance to go to another state
        if math.random(3) == 1 then
            if stats.energy + 0.1 < math.random() then
                if math.random(10) == 1 then
                    self.entity:changeState('stretching')
                else
                    self.entity.sleep = true
                    self.entity:changeState('laying')
                end
                return
            else
                local distanceFromHuman = math.sqrt(math.abs(self.entity.x - self.entity.human.x)^2 +
                    math.abs(self.entity.y - self.entity.human.y)^2)

                if distanceFromHuman < 32 then
                    if stats.humanAffection + 0.25 > math.random() then
                        self.entity:changeState('meow')
                    else
                        self.entity:changeState('sitting')
                    end
                else
                    local is_thirsty = stats.thirst < math.random()
                    local is_hungry = stats.hunger < math.random()

                    if is_thirsty and is_hungry then
                        if math.random(2) == 1 then
                            self.entity:changeState('licking' .. math.random(2))
                        else
                            self.entity:changeState('itching')
                        end
                    elseif is_thirsty then
                        self.entity:changeState('licking' .. math.random(2))
                    elseif is_hungry then
                        self.entity:changeState('itching')
                    else
                        self.entity:changeState('run')
                    end
                end
            end
        else
            self.moveDuration = math.random(5)
            self.entity.direction = directions[math.random(#directions)]
            self.entity:changeAnimation('walk')
        end
    end

    self.movementTimer = self.movementTimer + deltaTime
end