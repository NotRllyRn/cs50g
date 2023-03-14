--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:enter(params)
    
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 5
    self.entity.offsetX = 0

    local direction = self.entity.direction
    local hitboxX, hitboxY, hitboxWidth, hitboxHeight

    if direction == 'left' then
        hitboxWidth = 8
        hitboxHeight = 16
        hitboxX = self.entity.x - hitboxWidth
        hitboxY = self.entity.y + 2
    elseif direction == 'right' then
        hitboxWidth = 8
        hitboxHeight = 16
        hitboxX = self.entity.x + self.entity.width
        hitboxY = self.entity.y + 2
    elseif direction == 'up' then
        hitboxWidth = 16
        hitboxHeight = 8
        hitboxX = self.entity.x
        hitboxY = self.entity.y - hitboxHeight
    else
        hitboxWidth = 16
        hitboxHeight = 8
        hitboxX = self.entity.x
        hitboxY = self.entity.y + self.entity.height
    end

    self.potHitbox = Hitbox(hitboxX, hitboxY, hitboxWidth, hitboxHeight)
end

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or love.keyboard.isDown('a') or love.keyboard.isDown('d') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') or love.keyboard.isDown('w') or love.keyboard.isDown('s') then
        self.entity:changeState('walk')
    end

    if love.keyboard.wasPressed('space') then
        self.entity:changeState('swing-sword')
    end

    if love.keyboard.wasPressed('f') then
        for _, object in pairs(self.entity.dungeon.currentRoom.objects) do
            if object:collides(self.potHitbox) and object.type == 'pot' then
                self.entity.pot = object
                object.followPlayer = true

                self.entity:changeState('pickup-pot')
            end
        end
    end
end