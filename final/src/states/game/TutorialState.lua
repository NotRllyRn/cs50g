TutorialState = Class{__includes = BaseState}

function TutorialState:init(def)
    self.character = def.character
    self.donuts = def.donuts
    self.moveRate = def.moveRate
    self.donutSize = TILE_SIZE * 2

    self.Dialog = Dialog{
        text = 'Hello, you are playing Cat Cafe Haven',
    }
    self.text = {
        'In this game, your goal is to take care of cats and make them happy.',
        'They will be hungry, thirsty, and they will run around the cafe so you might have to catch them.',
        'You can feed them, give them water, and pet them.',
        'Every cat will have a infomation menu that will tell you their current stats!',
        'This is how you can see how happy, hungry, and thirsty they are.',
        'There are other stats that effect their behavior!',
        'Once they are all happy, you win!',
        'Oh and,',
        'Your food and water run out so make sure to restock them!',
        'Good luck and have fun!',
    }

    self.lastFrame = false
end

function TutorialState:update(deltaTime)
    StartState.updateDonuts(self, deltaTime)

    --TODO: fix, it is skipping the entire thing when i press the keys to skip to the end of the text. Also, fix the issue where the text doesn't wrap around the screen.

    if self.Dialog.textFinished and love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') or love.keyboard.wasPressed('space') or love.mouse.wasPressed(1) or love.keyboard.wasPressed('escape') then
        if #self.text == 0 then
            PlaySound(gSounds['menu-select'])

            gStateStack:push(FadeInState({
                r = 255, g = 255, b = 255
            }, 1, function()
                gStateStack:pop() -- // tutorial state

                gStateStack:push(PlayState({
                    character = self.character,
                    donuts = self.donuts,
                    moveRate = self.moveRate,
                }))
                gStateStack:push(FadeOutState({
                    r = 255, g = 255, b = 255
                }, 1))
            end))
        else
            self.Dialog:restartWith(table.remove(self.text, 1))

            PlaySound(gSounds['menu-select'])
        end
    else
        self.Dialog:update(deltaTime)
    end
end

function TutorialState:render()
    StartState.render(self)

    love.graphics.setColor(1, 1, 1, 1)

    self.Dialog:render()
end