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
        width = VIRTUAL_WIDTH - TILE_SIZE * 2,
        align = 'center',
    }

    gSounds['background']:stop()
    gSounds['victory']:setLooping(true)
    gSounds['victory']:setVolume(0.2)
    gSounds['victory']:play()
end

function VictoryState:update(deltaTime)
    for _, donut in pairs(self.donuts) do
        -- // moving the donut every frame with delta time. top left to bottom right.
        donut.x = donut.x + self.moveRate * deltaTime
        donut.y = donut.y + self.moveRate * deltaTime
    
        if donut.x > VIRTUAL_WIDTH or donut.y > VIRTUAL_HEIGHT then
            while donut.x > -self.donutSize and donut.y > -self.donutSize do
                -- // checking if the donut is off the screen and moving it back to the top left.
                donut.x = donut.x - self.donutSize
                donut.y = donut.y - self.donutSize
            end
        end
    end

    self.winText:update(deltaTime)

    if love.keyboard.wasPressed('escape') then
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