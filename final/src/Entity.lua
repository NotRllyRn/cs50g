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

    self.animations = self:createAnimations(def.animations)
    self.currentAnimation = self.animations[self.state .. '-' .. self.direction]

    if self.currentAnimation then
        local x, y, width, height = gFrames[self.type][self.state]
            [self.currentAnimation:getCurrentFrame()]:getViewport()
        self.trueWidth = width
        self.trueHeight = height
    end
end

function Entity:changeAnimation(name)
    self.currentAnimation = self.animations[name]

    self.state = string.split(name, '-')[1]
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
end

function Entity:update(dt)
    if self.stateMachine then
        self.stateMachine:update(dt)
    end

    local currentAnimation = self.currentAnimation
    if currentAnimation then
        currentAnimation:update(dt)

        local x, y, width, height = gFrames[self.type][self.state]
            [currentAnimation:getCurrentFrame()]:getViewport()

        self.trueWidth = width
        self.trueHeight = height
    end
end

function Entity:render(scaleX, scaleY)
    if self.trueWidth and self.trueHeight then
        scaleX = scaleX or 1
        scaleY = scaleY or 1

        local anim = self.currentAnimation
        love.graphics.draw(gFrames[self.type][self.state].texture, gFrames[self.type][self.state][anim:getCurrentFrame()],
            self.x - self.trueWidth / 2 * scaleX, self.y - self.trueHeight / 2 * scaleY, 0, scaleX, scaleY)
    end
end