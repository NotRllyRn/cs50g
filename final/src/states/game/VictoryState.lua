VictoryState = Class{__includes = BaseState}

function VictoryState:init(def)
    self.donuts = def.donuts
    self.moveRate = def.moveRate

    self.donutSize = TILE_SIZE * 2

    self.winText = Text{
        text = 'You win! You made all the cats happy :)',
        x = CENTER_X,
        y = CENTER_Y,
        font = gFonts['large'],
        width = VIRTUAL_WIDTH - TILE_SIZE * 3,
        align = 'center',
    }

    gSounds['background']:stop()
    gSounds['victory']:setLooping(true)
    gSounds['victory']:setVolume(0.2)
    gSounds['victory']:play()
end

function VictoryState:update(deltaTime)
    StartState.updateDonuts(self, deltaTime)
    self.winText:update(deltaTime)

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') or love.keyboard.wasPressed('space') or love.mouse.wasPressed(1) or love.keyboard.wasPressed('escape') then
        PlaySound(gSounds['menu-select'])
        
        gStateStack:push(FadeInState({
            r = 255, g = 255, b = 255
        }, 1, function()
            gStateStack:pop() -- // victory state

            gStateStack:push(Credits{
                donuts = self.donuts,
                moveRate = self.moveRate,
            })
            gStateStack:push(FadeOutState({
                r = 255, g = 255, b = 255
            }, 1))
        end))
    end
end

function VictoryState:render()
    StartState.render(self)

    self.winText:render()
end