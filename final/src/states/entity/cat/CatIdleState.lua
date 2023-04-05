CatIdleState = Class{__includes = EntityIdleState}

function CatIdleState:update(deltaTime)
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
end

function CatIdleState:processAI(deltaTime)
    if self.waitDuration == 0 then
        self.waitDuration = math.random(5) + math.random() - 1
    else
        self.waitTimer = self.waitTimer + deltaTime

        if self.waitTimer > self.waitDuration then
            local stats = self.entity.stats

            if stats.energy + 0.1 < math.random() then
                if math.random(10) == 1 then
                    self.entity:changeState('stretching')
                else
                    self.entity.sleep = true
                    self.entity:changeState('laying')
                end
                return
            end

            if stats.zoomies - 0.1 > math.random() then
                if math.random(5) == 1 then
                    self.entity:changeState('walk')
                else
                    self.entity:changeState('run')
                end
            else
                local distanceFromHuman = math.sqrt(math.abs(self.entity.x - self.entity.human.x)^2 + math.abs(self.entity.y - self.entity.human.y)^2)

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
                        self.entity:changeState('walk')
                    end
                end
            end
        end
    end
end