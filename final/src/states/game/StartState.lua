StartState = Class{__includes = BaseState}

-- TODO: add a title and work on the gui parts.

function StartState:init()
    self.donuts = {}
    self.moveRate = 5

    -- // pixel size of donuts and the amount of donuts needed
    DonutsOnScreenX = VIRTUAL_WIDTH / 32
    DonutsOnScreenY = VIRTUAL_HEIGHT / 32

    self.donutSize = TILE_SIZE * 2
    for x = -2, DonutsOnScreenX do
        for y = -2, DonutsOnScreenY do
            -- // creating a donut and setting their positions.
            local donut = Donut()

            donut.x = x * self.donutSize
            donut.y = y * self.donutSize

            table.insert(self.donuts, donut)
        end
    end

    self.text = Text {
        x = CENTER_X,
        y = CENTER_Y - 64,
        text = 'Cat Cafe Haven!',
        font = gFonts['large'],
        align = 'center',
    }

    self.selection = Selection {
        x = CENTER_X,
        y = CENTER_Y + 64,
        width = 500,
        height = 100,
        items = {
            {
                text = 'Play',
                onPress = function()
                    -- TODO: add a transition and change the state to the play state

                    gStateStack:push(FadeInState({
                        r = 255, g = 255, b = 255
                    }, 1, function()
                        gStateStack:pop()
                        gStateStack:push(PlayerSelection({
                            donuts = self.donuts,
                            moveRate = self.moveRate,
                        }))
                        gStateStack:push(FadeOutState({
                            r = 255, g = 255, b = 255
                        }, 1))
                    end))
                end
            },
            {
                text = 'Quit',
                onPress = function()
                    love.event.quit()
                end
            },
            {
                text = 'Credits',
                onPress = function()
                    print("credits")

                    -- TODO: add a transition and change the state to the credits state

                    -- gStateStack:push(CreditsScreen())
                end
            }
        },
        direction = 'horizontal',
    }
end

function StartState:update(deltaTime)
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

    if self.selection then
        self.selection:update(deltaTime)
    end
end

function StartState:render()
    -- // rendering the background
    love.graphics.setColor(251/255, 207/255, 241/255, 1)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    for _, donut in pairs(self.donuts) do
        donut:render()
    end

    -- // overalay
    love.graphics.setColor(1, 1, 1, 0.45)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    if self.text and self.selection then
        self.text:render()

        self.selection:render()
    end
end