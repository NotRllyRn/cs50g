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

    def.stateMachine = StateMachine {
        ['idle'] = function() return EntityIdleState(self) end,
        ['walk'] = function() return EntityWalkState(self, def.level) end,
    }

    Entity.init(self, def)
end

function Cat:changeAnimation(state)
    self.currentAnimation = self.animations[state]
end

function Cat:changeState(state)
    if self.stateMachine then
        self.stateMachine:change(state)
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
end