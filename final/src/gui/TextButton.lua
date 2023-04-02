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
                self.hovered = true
                self.onHover()
            else
                self.hovered = true
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
        if self.hovered then
            self.pressed = false
            self.onRelease()
        else
            self.pressed = false
        end
    end
end