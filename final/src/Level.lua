Level = Class{}

function Level:init(def)
    self.entities = {}
    self.player = def.player
    self.objects = {}

    self.tiles = {}

    self.tileWidth = def.tileWidth
    self.tileHeight = def.tileHeight

    for y = 1, self.tileWidth do
        self.tiles[y] = {}
        for x = 1, self.tileHeight do
            self.tiles[y][x] = Tile(x, y, FLOOR_TILE)
        end
    end
end