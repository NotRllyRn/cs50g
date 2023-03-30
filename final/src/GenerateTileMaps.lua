-- // library that generates tile maps

local GenerateTileMaps = {}

function GenerateTileMaps:generateQuads(atlas, tileWidth, tileHeight)
    local sheetWidth = atlas:getWidth() / tileWidth
    local sheetHeight = atlas:getHeight() / tileHeight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] =
                love.graphics.newQuad(x * tileWidth, y * tileHeight, tileWidth, tileHeight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    spritesheet.texture = atlas

    return spritesheet
end

function GenerateTileMaps:generateDonuts(atlas)
    local donutCounter = 1
    local donuts = {}

    for y = 0, 2 do
        for x = 0, 2 do
            donuts[donutCounter] = love.graphics.newQuad(x * 32, y * 32, 32, 32, atlas:getDimensions())
            donutCounter = donutCounter + 1
        end
    end

    donuts.texture = atlas

    return donuts
end

function GenerateTileMaps:generateTileSet(atlas)
    local tileCounter = 1
    local tiles = {}

    for y = 0, 4 do
        for x = 6, 9 do
            tiles[tileCounter] = love.graphics.newQuad(x * 16, y * 16, 16, 16, atlas:getDimensions())
            tileCounter = tileCounter + 1
        end
    end

    tiles.texture = atlas

    return tiles
end

function GenerateTileMaps:generateCursors(atlas)
    local counter = 1
    local tiles = {}

    for y = 24, 27 do
        for x = 27, 40 do
            tiles[counter] = love.graphics.newQuad(x * 16, y * 16, 16, 16, atlas:getDimensions())
            counter = counter + 1
        end
    end

    tiles.texture = atlas

    return tiles
end

return GenerateTileMaps