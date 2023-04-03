Object = Class{__includes = BaseState}

function Object:init(x, y, def)
    self.x = x
    self.y = y

    self.width = def.width
    self.height = def.height
    
    self.tiles = def.tiles
    self.frameId = def.frameId
    self.state = def.state

    self.animations = def.animations and self:createAnimations(def.animations) or nil
    if self.animations then
        self.currentAnimation = self.animations[def.state]
    end

    self.onCollide = def.onCollide or function(entity) end
    self.onConsume = def.onConsume or function(entity) end

    self.collidable = def.collidable
    self.consumable = def.consumable

    self.solid = def.solid == nil and true or def.solid

    self.frame = def.frame
end

function Object:touched(entity)
    if self.collidable then
        self.onCollide(entity)
    end
    if self.consumable then
        self.onConsume(entity)
    end
end

function Object:update(deltaTime)
    if self.currentAnimation then
        self.currentAnimation:update(deltaTime)
    end
end

function Object:createAnimations(animations)
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

function Object:render()
    if self.tiles then
        for y, row in pairs(self.tiles) do
            for x, tile_id in pairs(row) do
                love.graphics.draw(self.frame.texture, self.frame[tile_id], self.x + (x - 1) * TILE_SIZE, self.y + (y - 1) * TILE_SIZE)
            end
        end
    elseif self.tileId then
        love.graphics.draw(self.frame.texture, self.frame[self.tileId], self.x, self.y)
    elseif self.currentAnimation then
        local animation = self.currentAnimation
        love.graphics.draw(self.frame.texture, self.frame[animation:getCurrentFrame()], self.x, self.y)
    end
end