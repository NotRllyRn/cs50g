Selection = Class{__includes = BaseGui}

function Selection:init(def)
    BaseGui.init(self, def)

    self.direction = def.direction or 'vertical'
    self.items = {}

    self.displayBackdrop = def.displayBackdrop or true
    self.backdrop = Backdrop {
        x = self.x, y = self.y,
        width = self.width, height = self.height,
    }

    self.startX = self.backdrop.startX
    self.startY = self.backdrop.startY

    if def.items then
        local itemSpacing = self.direction == 'vertical' and math.floor(self.backdrop.trueHeight / #def.items + 0.5)
            or math.floor(self.backdrop.trueWidth / #def.items + 0.5)
        local itemSpacingHalf = math.floor(itemSpacing / 2 + 0.5)

        for k, item in ipairs(def.items) do
            item.x = self.direction == 'vertical' and self.x
                or itemSpacingHalf + self.startX + (k - 1) * itemSpacing

            item.y = self.direction ~= 'vertical' and self.y
                or itemSpacingHalf + self.startY + (k - 1) * itemSpacing

            item.onHover = function()
                self.position = k
            end

            self.items[k] = TextButton(item)
        end
    end

    self.displayCursor = def.displayCursor or true
    self.position = not def.position and 1
        or math.min(#def.items, math.max(1, def.position))

    self.cursorSide = def.cursorSide or 'right'
end

function Selection:update(deltaTime)
    if self.display then
        for k, item in ipairs(self.items) do
            item:update(deltaTime)
        end

        if self.displayCursor and not self.items[self.position].hovered then
            if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('left')
                or love.keyboard.wasPressed('w') or love.keyboard.wasPressed('a') then

                self.position = self.position - 1

                if self.position < 1 then
                    self.position = #self.items
                end
            elseif love.keyboard.wasPressed('down') or love.keyboard.wasPressed('right')
                or love.keyboard.wasPressed('s') or love.keyboard.wasPressed('d') then

                self.position = self.position + 1

                if self.position > #self.items then
                    self.position = 1
                end
            end
        end

        local currentItem = self.items[self.position]
        if (love.keyboard.wasPressed('return') or love.keyboard.wasPressed('space')) and not currentItem.pressed then
            PlaySound(gSounds['menu-select'])

            self.items[self.position].onPress()
        end
    end
end

function Selection:renderCursor(item)
    local x, y, quadNumber

    if self.cursorSide == 'right' then
        if self.direction == 'vertical' then
            x = item.x + item.trueWidth / 2 + 5
            y = item.y

            quadNumber = 5
        else
            x = item.x
            y = item.y + item.trueHeight / 2 + 5

            quadNumber = 19
        end
    else
        if self.direction == 'vertical' then
            x = item.x - item.trueWidth / 2 - 5
            y = item.y

            quadNumber = 3
        else
            x = item.x
            y = item.y - item.trueHeight / 2 - 5

            quadNumber = 18
        end
    end

    local atX = math.floor(x - TILE_SIZE / 2 + 0.5)
    local atY = math.floor(y - TILE_SIZE / 2 + 0.5)

    love.graphics.draw(gFrames['cursors'].texture, gFrames['cursors'][quadNumber], atX, atY)
end

function Selection:render()
    if self.display then
        if self.displayBackdrop then
            self.backdrop:render()
        end

        for k, item in ipairs(self.items) do
            item:render()

            if self.displayCursor and self.position and k == self.position then
                self:renderCursor(item)
            end
        end
    end
end