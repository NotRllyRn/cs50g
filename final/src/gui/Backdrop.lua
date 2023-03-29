Backdrop = Class{__includes = BaseGui}

-- TODO: make the backdrop to allow for other guis to use. make sure to create the tile set for the backdrop

function Backdrop:init(def)
    BaseGui.init(self, def.x, def.y, def.width, def.height)
    -- // centering the backdrop in the center of x and y
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height

    self.display = def.display or self.display

    self.tileWidth = math.floor(self.width / 16 + 0.5)
    self.tileHeight = math.floor(self.height / 16 + 0.5)

    -- // generating the backdrop
    self.tiles = {}
    for x = 0, self.tileWidth - 1 do
        for y = 0, self.tileHeight - 1 do
            local data;
            if y == 0 then
                data = {
                    tile = (x == 0) and 1 or (x == self.tileWidth - 1) and 3 or 2,
                    x = x, y = y,
                }
            elseif y == self.tileHeight - 1 then
                data = {
                    tile = x == 0 and 9 or x == self.tileWidth - 1 and 11 or 10,
                    x = x, y = y,
                }
            else
                data = {
                    tile = x == 0 and 5 or x == self.tileWidth - 1 and 7 or 6,
                    x = x, y = y,
                }
            end

            self.tiles[#self.tiles + 1] = data
        end
    end
end

function Backdrop:update(deltaTime)
    -- // centering the backdrop in the center of x and y
    self.startX = self.x - self.tileWidth * 16 / 2
    self.startY = self.y - self.tileHeight * 16 / 2
end

function Backdrop:render()
    if self.display then
        for i = 1, #self.tiles do
            local data = self.tiles[i]
            love.graphics.draw(gFrames['tileSet'].texture, gFrames['tileSet'][data.tile], self.startX + data.x * 16, self.startY + data.y * 16)
        end
    end 
end

-- TODO: test code