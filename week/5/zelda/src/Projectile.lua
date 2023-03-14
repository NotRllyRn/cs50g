--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Projectile = Class{}

function Projectile:init(def)
    self.width = def.width
    self.height = def.height

    self.x = def.x
    self.y = def.y

    self.direction = def.direction
    self.distance = def.distance or 500
    self.speed = def.speed or 100

    self.onCollide = def.onCollide

    self.candocollide = true
end

function Projectile:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
        self.y + self.height < target.y or self.y > target.y + target.height)
end

function Projectile:update(dt)
    if self.distance > 0 then
        if self.direction == 'left' then
            self.x = self.x - self.speed * dt

            if self.x <= MAP_RENDER_OFFSET_X + TILE_SIZE then 
                self.onCollide()
            end
        elseif self.direction == 'right' then
            self.x = self.x + self.speed * dt

            if self.x + self.width >= VIRTUAL_WIDTH - TILE_SIZE * 2 then
                self.onCollide()
            end
        elseif self.direction == 'up' then
            self.y = self.y - self.speed * dt

            if self.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE - self.height / 2 then 
                self.onCollide()
            end
        else
            self.y = self.y + self.speed * dt

            local bottomEdge = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) 
                + MAP_RENDER_OFFSET_Y - TILE_SIZE

            if self.y + self.height >= bottomEdge then
                self.onCollide()
            end
        end

        self.distance = self.distance - self.speed * dt
    elseif self.candocollide then
        self.candocollide = false
        self.onCollide()
    end
end