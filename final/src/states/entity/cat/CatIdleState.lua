CatIdleState = Class{__includes = EntityIdleState}

function CatIdleState:update(deltaTime)
    local stats = self.entity.stats
    self.entity:_updateStats(deltaTime)

    stats.hunger = stats.hunger + DECREASE_RATE * deltaTime
    stats.thirst = stats.thirst + DECREASE_RATE * deltaTime
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
                    self.entity:changeState('laying', {
                        sleep = true,
                    })
                end
            else
                if stats.zoomies - 0.1 > math.random() then
                    if math.random(5) == 1 then
                        self.entity:changeState('walk')
                    else
                        self.entity:changeState('run')
                    end
                else
                    local human = self.entity.level.player

                    local distanceFromHuman = math.sqrt(math.abs(self.entity.x - human.x)^2 +
                        math.abs(self.entity.y - human.y)^2)

                    if distanceFromHuman < RADIUS_TO_MEOW then
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
                                self.entity:changeState('licking')
                            else
                                self.entity:changeState('itch')
                            end
                        elseif is_thirsty then
                            self.entity:changeState('licking')
                        elseif is_hungry then
                            self.entity:changeState('itch')
                        else
                            self.entity:changeState('walk')
                        end
                    end
                end
            end
        end
    end
end