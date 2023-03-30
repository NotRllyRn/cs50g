TextButton = Class{__includes = Text}

function TextButton:init(def)
    Text.init(self, def)
    
    self.onPress = def.onPress or function() end
    self.onRelease = def.onRelease or function() end
    self.onHover = def.onHover or function() end

    self.hovered = false
    self.pressed = false
end

function TextButton:update(deltaTime)
    local x, y = push:toGame(love.mouse.getPosition())

    if x and y then
        if x >= self.x - self.trueWidth / 2 and x <= self.x + self.trueWidth / 2 and
            y >= self.y - self.trueHeight / 2 and y <= self.y + self.trueHeight / 2 then
            if not self.hovered then
                self.onHover()
            end
            self.hovered = true
        else
            self.hovered = false
        end
    end

    if love.mouse.wasPressed(1) and self.hovered and not self.pressed then
        self.onPress()
        self.pressed = true
    end

    if love.mouse.wasReleased(1) and self.pressed then
        if self.hovered then
            self.onRelease()
        end
        self.pressed = false
    end
end