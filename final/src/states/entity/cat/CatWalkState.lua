CatWalkState = Class{__includes = EntityWalkState}

function CatWalkState:update(deltaTime)
    EntityWalkState.update(self, deltaTime)

    -- TODO:
end

function CatWalkState:processAI(deltaTime)
    local directions = {'left', 'right', 'up', 'down'}
    local stats = self.entity.stats

    if self.moveDuration == 0 or self.bumped then
        
        -- set an initial move duration and direction
        self.moveDuration = math.random(5)
        self.entity.direction = directions[math.random(#directions)]
    
        if stats.zoomies - 0.1 > math.random() then
            self.entity:changeState('run')
        else
            self.entity:changeState('walk')
        end
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
                --TODO: chance to go to another state
            end
        else
            self.moveDuration = math.random(5)
            self.entity.direction = directions[math.random(#directions)]

            if stats.zoomies - 0.1 > math.random() then
                self.entity:changeState('run')
            else
                self.entity:changeState('walk')
            end
        end
    end

    self.movementTimer = self.movementTimer + deltaTime
end