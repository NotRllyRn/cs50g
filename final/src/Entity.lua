Entity = Class{}

-- TODO: incorporate animation into this (import class into dependencies as well)

function Entity:init(def)
    self.width = def.width
    self.height = def.height

    self.x = def.x
    self.y = def.y

    self.dx = 0
    self.dy = 0

    self.stateMachine = def.stateMachine

    self.direction = 'down'

    self.texture = def.texture
    self.frames = def.frames
end

function Entity:changeState(state, params)
    self.stateMachine:change(state, params)
end

function Entity:update(dt)
    self.stateMachine:update(dt)
end

function Entity:render()
    local anim = self.currentAnimation
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][anim:getCurrentFrame()],
        math.floor(self.x - self.width / 2), math.floor(self.y - self.height / 2))
end