--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

MenuState = Class{__includes = BaseState}

function MenuState:init(def, onClose)
    self.Menu = Menu {
        items = def.items,
        -- center of the screen
        x = VIRTUAL_WIDTH / 4,
        y = VIRTUAL_HEIGHT / 4,
        width = VIRTUAL_WIDTH / 2,
        height = VIRTUAL_HEIGHT / 2,
        onReturn = function()
            gStateStack:pop()
            onClose()
        end,
        cursor = false
    }
end

function MenuState:update(dt)
    self.Menu:update(dt)
end

function MenuState:render()
    self.Menu:render()
end