Button = Class{__includes = BaseGui}

function Button:init(def)
    BaseGui.init(self, def)
    
    self.onPress = def.onPress or function() end
    self.onRelease = def.onRelease or function() end
    self.onHover = def.onHover or function() end

    self.hovered = false
    self.pressed = false

    self.frame = def.frame or 1
    self.scale = def.scale or 1
end

function Button:update(deltaTime)
    local x, y = push:toGame(love.mouse.getPosition())

    if x and y then
        if x >= self.x - self.width / 2 and x <= self.x + self.height / 2 and
            y >= self.y - self.width / 2 and y <= self.y + self.height / 2 then
            self.hovered = true

            if not self.hovered then
                self.onHover()
            end
        else
            self.hovered = false
        end
    end

    if love.mouse.wasPressed(1) and self.hovered and not self.pressed then
        PlaySound(gSounds['menu-select'])
        self.pressed = true

        self.onPress()
    end

    if love.mouse.wasReleased(1) and self.pressed then
        self.pressed = false

        if self.hovered then
            self.onRelease()
        end
    end
end

function Button:render()
    local drawAtX = math.floor(self.x - self.width / 2 + 0.5)
    local drawAtY = math.floor(self.y - self.height / 2 + 0.5)

    love.graphics.draw(gTextures['gui'], gFrames['cursors'][self.frame],
        drawAtX, drawAtY, 0, self.scale, self.scale)
end