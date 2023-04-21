Cat = Class{__includes = Entity}

function Cat:init(def)
    def.catCharacter = def.catCharacter or math.random(6)
    
    local catSize = ENTITY_DEFINITIONS['cat'].catSizes[def.catCharacter]
    def.width = catSize[1]
    def.height = catSize[2]

    def.animations = ENTITY_DEFINITIONS['cat'].animations

    def.type = 'cat' .. def.catCharacter
    def.typeOfEntity = 'cat'
    def.state = def.state or 'idle'

    self.level = def.level

    def.stateMachine = StateMachine {
        ['idle'] = function() return CatIdleState(self) end,
        ['walk'] = function() return CatWalkState(self, self.level) end,
        ['run'] = function() return CatRunState(self, self.level) end,
        ['sitting'] = function() return CatSittingState(self) end,
        ['licking'] = function() return CatLickingState(self) end,
        ['sleeping'] = function() return CatSleepingState(self) end,
        ['itch'] = function() return CatItchState(self) end,
        ['laying'] = function() return CatLayingState(self) end,
        ['meow'] = function() return CatMeowState(self) end,
        ['stretching'] = function() return CatStretchingState(self) end,
    }

    def.stats = def.stats or {}
    def.stats.humanAffection = def.stats.humanAffection or math.random()
    def.stats.hunger = def.stats.hunger or math.random()
    def.stats.happiness = def.stats.happiness or 0
    def.stats.thirst = def.stats.thirst or math.random()
    def.stats.energy = def.stats.energy or math.random()
    def.stats.zoomies = def.stats.zoomies or math.random()
    self.stats = def.stats

    self.name = def.name or GenerateTileMaps:randomName()

    self.human = def.human

    self.EKey = Tile(0, 0, 65, 'keys')

    Entity.init(self, def)
end

function Cat:_updateStats(deltaTime)
    local stats = self.stats

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
end
function Cat:changeAnimation(state)
    self.currentAnimation = self.animations[state]
end

function Cat:update(deltaTime)
    Entity.update(self, deltaTime)

    self.EKey.x = self.x - TILE_SIZE / 2
    self.EKey.y = self.y - TILE_SIZE * 1.5

    self:_clampStats()
end

function Cat:_clampStats()
    local stats = self.stats

    stats.humanAffection = math.max(0, math.min(1, stats.humanAffection))
    stats.hunger = math.max(0, math.min(1, stats.hunger))
    stats.happiness = math.max(0, math.min(1, stats.happiness))
    stats.thirst = math.max(0, math.min(1, stats.thirst))
    stats.energy = math.max(0, math.min(1, stats.energy))
    stats.zoomies = math.max(0, math.min(1, stats.zoomies))
end

function Cat:changeState(state, params)
    if self.stateMachine then
        self.stateMachine:change(state, params)
    end

    if state == 'sleeping' or state == 'licking' then
        state = state .. math.random(2)
    end

    self.state = state
end

function Cat:render()
    if self.trueWidth and self.trueHeight then
        local anim = self.currentAnimation

        local scaleX = self.direction == 'left' and -self.scale or self.scale

        local drawAtX = math.floor(self.x - self.trueWidth / 2 * scaleX + 0.5)
        local drawAtY = math.floor(self.y - self.trueHeight / 2 * self.scale + 0.5)

        love.graphics.draw(gFrames[self.type][self.state].texture, gFrames[self.type][self.state][anim:getCurrentFrame()],
            drawAtX, drawAtY, 0, scaleX, self.scale)
    end

    if self.displayKey then
        self.EKey:render()
    end
end