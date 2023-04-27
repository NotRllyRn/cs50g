Text = Class{__includes = BaseGui}

function Text:init(def)
    BaseGui.init(self, def)

    self.text = def.text or self.text
    self.font = def.font

    self.color = def.color or {1, 1, 1, 1}
    self.align = def.align or 'center'

    self.displayBackdrop = def.displayBackdrop == nil and true or def.displayBackdrop
    self.borderSize = def.borderSize or 16

    if not self.font and def.fontSize then
        self.font = love.graphics.newFont('fonts/font.ttf', def.fontSize)
    elseif not self.font then
        self.font = gFonts['large']
    end

    if not def.width then
        self.width = self.font:getWidth(self.text)

        self.resizeWidth = true
    end
    
    local width, wrapped = self.font:getWrap(self.text, self.width)
    if self.resizeWidth then
        self.width = width
    end

    if not def.height then
        self.height = self.font:getHeight() * #wrapped

        self.resizeHeight = true
    end

    self.printX = self.x - self.width / 2
    self.printY = self.y - self.height / 2

    self.backdrop = Backdrop {
        x = self.x,
        y = self.y,

        width = self.width + TILE_SIZE + self.borderSize,
        height = self.height + TILE_SIZE + self.borderSize,
    }

    self.trueWidth = self.backdrop.trueWidth
    self.trueHeight = self.backdrop.trueHeight
end

function Text:setText(text)
    self.text = text

    local width, wrapped = self.font:getWrap(self.text, self.width)

    if self.resizeWidth and self.resizeHeight then
        self.backdrop:changeSize(self.width + self.borderSize, self.height + self.borderSize)
        
        self.width = width
        self.height = self.font:getHeight() * #wrapped
    elseif self.resizeWidth then
        self.backdrop:changeSize(self.width + self.borderSize, self.backdrop.trueHeight)
        self.width = width
    elseif self.resizeHeight then
        self.backdrop:changeSize(self.backdrop.trueWidth, self.height + self.borderSize)
        self.height = self.font:getHeight() * #wrapped
    end

    self.trueWidth = self.backdrop.trueWidth
    self.trueHeight = self.backdrop.trueHeight
end

function Text:render()
    if self.display then
        love.graphics.setFont(self.font)
        love.graphics.setColor(self.color)

        if self.displayBackdrop then
            self.backdrop.x = self.x
            self.backdrop.y = self.y

            self.backdrop:render()
        end

        local printX = math.floor(self.x - self.width / 2 + 0.5)
        local printY = math.floor(self.y - self.height / 2 + 0.5)

        love.graphics.printf(self.text, printX, printY, self.width, 'center')

        love.graphics.setColor(1, 1, 1, 1)
    end
end


