Bar = Class{}

function Bar:init(def)
    self.x = def.x
    self.y = def.y
    self.length = def.length
    self.color = def.color
    self.value = def.value
    self.max = def.max
    self.orientation = def.orientation

    self.tileLength = self.length / TILE_SIZE
    self.tiles = {}

    if self.oreientation == 'horizontal' then
        local under = self.y - TILE_SIZE

        -- TODO: make this work, i set up the tile map so that it will be easy to make this

        for i = 1, self.tileLength do
            if i == 1 then
                table.insert(self.tiles, Tile(
                    self.x,
                    self.y,
                    603,
                    'gui'
                ))
                table.insert(self.tiles, Tile(
                    self.x,
                    under,
                    651,
                    'gui'
                ))
            elseif i == self.tileLength then
                table.insert(self.tiles, Tile(
                    self.x,
                    self.y,
                    603,
                    'gui'
                ))
                table.insert(self.tiles, Tile(
                    self.x,
                    self.y + TILE_SIZE,
                    651,
                    'gui'
                ))
            else

            end
        end
    else
        for i = 1, self.tileLength do
            table.insert(self.tiles, Tile {
                x = self.x,
                y = self.y + (i - 1) * TILE_SIZE,
                width = TILE_SIZE,
                height = TILE_SIZE,
                texture = 'bar',
                color = self.color
            })
        end
    end
    end
end