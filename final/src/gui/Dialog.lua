Dialog = Class{__includes = BaseState}

function Dialog:init(def)
    self.text = def.text
    self.font = def.font or gFonts['large']

    self.backdrop = Backdrop {
        x = VIRTUAL_WIDTH / 2,
        y = VIRTUAL_HEIGHT / 4 * 3,

        width = VIRTUAL_WIDTH,
        height = VIRTUAL_HEIGHT / 2,
    }
    self.screenText = Text{
        displayBackdrop = false,
        x = VIRTUAL_WIDTH / 2,
        y = VIRTUAL_HEIGHT / 4 * 3,

        font = self.font,
        text = '',

        width = VIRTUAL_WIDTH,
    }

    self.textTimer = 0
    self.textSpeed = 0.05
    self.textFinished = false
    self.textIndex = 1

    self.textTable = (function()
        local t = {}
        for letter in self.text:gmatch('.') do
            table.insert(t, letter)
        end
        return t
    end)()
end

function Dialog:update(deltaTime)
    if love.keyboard.wasPressed('escape') then
        gStateStack:push(PauseState())
    end

    if not self.textFinished then
        self.textTimer = self.textTimer + deltaTime
        if self.textTimer > self.textSpeed then
            self.textTimer = self.textTimer % self.textSpeed

            self.screenText:setText(self.screenText.text .. self.textTable[self.textIndex])

            PlaySound(gSounds['menu-select'])

            self.textIndex = self.textIndex + 1

            if self.textIndex > #self.text then
                self.textFinished = true
            end
        end
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') or love.keyboard.wasPressed('space') or love.mouse.wasPressed(1) then
        if self.textFinished then
            gStateStack:pop()

            PlaySound(gSounds['menu-select'])
        else
            self.textFinished = true
            self.screenText:setText(self.text)

            PlaySound(gSounds['menu-select'])
        end
    end
end

function Dialog:render()
    self.backdrop:render()
    self.screenText:render()
end
