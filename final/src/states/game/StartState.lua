StartState = Class{__includes = BaseState}

-- TODO: add a title and work on the gui parts.

function StartState:init()
    self.donuts = {}
    self.moveRate = 5

    -- // pixel size of donuts and the amount of donuts needed
    DonutsOnScreenX = VIRTUAL_WIDTH/32
    DonutsOnScreenY = VIRTUAL_HEIGHT/32

    local DonutSize = 32

    for x = -2, DonutsOnScreenX do
        for y = -2, DonutsOnScreenY do
            -- // creating a donut and setting their positions.
            local donut = Donut()

            donut.x = x * DonutSize
            donut.y = y * DonutSize

            table.insert(self.donuts, donut)
        end
    end
end

function StartState:update(deltaTime)
    for _, donut in pairs(self.donuts) do
        -- // moving the donut every frame with delta time. top left to bottom right.
        donut.x = donut.x + self.moveRate * deltaTime
        donut.y = donut.y + self.moveRate * deltaTime
    
        if donut.x > VIRTUAL_WIDTH or donut.y > VIRTUAL_HEIGHT then
            while donut.x > -32 and donut.y > -32 do
                -- // checking if the donut is off the screen and moving it back to the top left.
                donut.x = donut.x - 32
                donut.y = donut.y - 32
            end
        end
    end
end

function StartState:render()
    -- // rendering the background
    love.graphics.setColor(251/255, 207/255, 241/255, 1)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    for _, donut in pairs(self.donuts) do
        donut:render()
    end

    love.graphics.setColor(1, 1, 1, 0.45)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Cat Cafe Haven', 0, VIRTUAL_HEIGHT / 2 - 32, VIRTUAL_WIDTH, 'center')
end