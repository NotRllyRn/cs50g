Entity = Class{}

-- TODO: incorporate animation into this (import class into dependencies as well)

function Entity:init(def)
    self.width = def.width
    self.height = def.height

    self.x = def.x
    self.y = def.y

    self.stateMachine = def.stateMachine

    self.direction = def.direction or ({'right', 'left', 'down', 'up'})[math.random(1, 4)]
    self.type = def.type
    self.state = def.state
    self.typeOfEntity = def.typeOfEntity

    self.animations = self:createAnimations(def.animations)
    if self.typeOfEntity == 'cat' then
        self.currentAnimation = self.animations[self.state]
    else
        self.currentAnimation = self.animations[self.state .. '-' .. self.direction]
    end

    if self.currentAnimation then
        local x, y, width, height = gFrames[self.type][self.state]
            [self.currentAnimation:getCurrentFrame()]:getViewport()
        self.trueWidth = width
        self.trueHeight = height
    end

    self.scale = def.scale or 1
end

function Entity:processAI(dt)
    if self.stateMachine then
        self.stateMachine:processAI(dt)
    end
end

function Entity:changeAnimation(state)
    self.currentAnimation = self.animations[state .. '-' .. self.direction]
end

function Entity:collides(target)
    if self.x + self.width / 2 > target.x and self.x - self.width / 2 < target.x + target.width and
        self.y + self.height / 2 > target.y and self.y - self.height / 2 < target.y + target.height then
        return true
    end

    return false
end

function Entity:createAnimations(animations)
    local returnTable = {}

    for k, animation in pairs(animations) do
        returnTable[k] = Animation {
            frames = animation.frames,
            interval = animation.interval,
            looping = animation.looping
        }
    end

    return returnTable
end

function Entity:changeState(state, params)
    if self.stateMachine then
        self.stateMachine:change(state, params)
    end

    self.state = state
end

function Entity:update(dt)
    if self.stateMachine then
        self.stateMachine:update(dt)
    end

    local currentAnimation = self.currentAnimation
    if currentAnimation then
        currentAnimation:update(dt)

        local x, y, width, height = gFrames[self.type]
        [self.state]
            [currentAnimation:getCurrentFrame()]
            :getViewport()

        self.trueWidth = width
        self.trueHeight = height
    end
end

function Entity:render()
    if self.trueWidth and self.trueHeight then
        local anim = self.currentAnimation

        local drawAtX = math.floor(self.x - self.trueWidth / 2 * self.scale + 0.5)
        local drawAtY = math.floor(self.y - self.trueHeight / 2 * self.scale + 0.5)

        love.graphics.draw(gFrames[self.type][self.state].texture, gFrames[self.type][self.state][anim:getCurrentFrame()],
            drawAtX, drawAtY, 0, self.scale, self.scale)

        --[[// draw box around character for debugging
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.rectangle('line', self.x - self.trueWidth / 2 * self.scale, self.y - self.trueHeight / 2 * self.scale,
             self.trueWidth * self.scale, self.trueHeight * self.scale)
        love.graphics.setColor(1, 1, 1, 1)
        --]]
    end
end