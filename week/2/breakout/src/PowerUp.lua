PowerUp = Class{}

function PowerUp:init(type)
    -- simple positional and dimensional variables
    self.width = 16
    self.height = 16

    -- put somewhere random on the screen without being too low
    self.x = math.random(32, VIRTUAL_WIDTH - 32)
    self.y = math.random(18, VIRTUAL_HEIGHT / 2)

    -- give it a random velocity that points downward
    self.dy = math.random(50, 100)

    -- gives it a random type of powerup
    self.type = type

    -- whether this powerup is in play or not
    self.inPlay = true
end

--[[
    Expects an argument with a bounding box, be that a paddle,
    and returns true if the bounding boxes of this and the argument overlap.
]]
function PowerUp:collides(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
end

function PowerUp:update(dt)
    self.y = self.y + self.dy * dt
end

function PowerUp:render()
    if self.inPlay then
        love.graphics.draw(gTextures['main'], gFrames['power-ups'][self.type],
            self.x, self.y)
    end
end