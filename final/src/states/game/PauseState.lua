PauseState = Class{__includes = BaseState}

function PauseState:init()
    self.guiElements = {
        TextButton {
            x = CENTER_X,
            y = CENTER_Y - 36,
            text = 'Resume',
            onPress = function()
                gStateStack:pop()
            end
        },
        TextButton {
            x = CENTER_X,
            y = CENTER_Y + 36,
            text = 'Main Menu',
            onPress = function()
                gStateStack:push(FadeInState({
                    r = 255, g = 255, b = 255
                }, 1, function()
                    gStateStack:pop() -- // pause state
                    gStateStack:pop() -- // play state

                    gSounds['background']:stop()
                    gSounds['intro']:play()

                    gStateStack:push(StartState{})
                    gStateStack:push(FadeOutState({
                        r = 255, g = 255, b = 255
                    }, 1))
                end))
            end
        }
    }
end

function PauseState:update(deltaTime)
    for k, element in pairs(self.guiElements) do
        element:update(deltaTime)
    end

    if love.keyboard.wasPressed('escape') then
        PlaySound(gSounds['menu-select'])

        gStateStack:pop()
    end
end

function PauseState:render()
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    for k, element in pairs(self.guiElements) do
        element:render()
    end
end