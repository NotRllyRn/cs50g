Text = Class{__includes = BaseGui}

function Text:init(def)
    BaseGui.init(self, def)

    self.text = def.text or self.text
    self.font = def.font

    self.color = def.color or {1, 1, 1, 1}
    self.align = def.align or 'center'

    self.displayBackdrop = def.displayBackdrop or true
    self.borderSize = def.borderSize or 16

    if not self.font and def.fontSize then
        self.font = love.graphics.newFont('fonts/font.ttf', def.fontSize)
    elseif not self.font then
        self.font = gFonts['large']
    end

    if not def.width or def.height then
        self.width = self.font:getWidth(self.text)
        self.height = self.font:getHeight()

        self.resizeWithText = true
    end

    self.printX = self.x - self.width / 2
    self.printY = self.y - self.height / 2

    self.backdrop = Backdrop {
        x = self.x,
        y = self.y,

        width = self.width + TILE_SIZE + self.borderSize,
        height = self.height + TILE_SIZE + self.borderSize,
    }
end

function Text:changeText(text)
    self.text = text

    self.width = self.font:getWidth(self.text)
    self.height = self.font:getHeight()

    self.printX = self.x - self.width / 2
    self.printY = self.y - self.height / 2

    if self.resizeWithText then
        self.backdrop:changeSize(self.width + TILE_SIZE, self.height + TILE_SIZE)
    end
end

function Text:render()
    if self.display then
        love.graphics.setFont(self.font)
        love.graphics.setColor(self.color)

        if self.displayBackdrop then
            self.backdrop:render()
        end

        love.graphics.printf(self.text, self.printX, self.printY, self.width, 'center')

        love.graphics.setColor(1, 1, 1, 1)
    end
end


