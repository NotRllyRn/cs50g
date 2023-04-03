-- // library that generates tile maps

local GenerateTileMaps = {}

function GenerateTileMaps:generateQuads(atlas, tileWidth, tileHeight, offsetX, offsetY)
    offsetX = offsetX or 0
    offsetY = offsetY or 0

    local sheetWidth = atlas:getWidth() / tileWidth
    local sheetHeight = atlas:getHeight() / tileHeight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] =
                love.graphics.newQuad(offsetX + x * tileWidth, offsetY + y * tileHeight, tileWidth, tileHeight, atlas:getDimensions())
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

function GenerateTileMaps:generateCharacterFrames()
    for k, character in pairs(gTextures['characters']) do
        for state, texture in pairs(character) do
            gFrames[k] = gFrames[k] or {}
            gFrames[k][state] = self:generateQuads(texture, 64, 64)
        end
    end
end

function GenerateTileMaps:generateCharacterTextures()
    gTextures['characters'] = {}

    local root = 'graphics/characters/premade_'
    for k = 1, 10 do
        local numberFormat = k < 10 and ('0' .. k) or k
        local path = root .. numberFormat .. '/character_premade_' .. numberFormat .. '_'

        gTextures['characters']['character' .. k] = {
            ['idle'] = love.graphics.newImage(path .. 'idle.png'),
            ['walk'] = love.graphics.newImage(path .. 'walk.png'),
            ['run'] = love.graphics.newImage(path .. 'run.png'),
        }
    end
end

function GenerateTileMaps:generateCatFrames()
    for cat, catTextures in pairs(gTextures['cats']) do
        for state, texture in pairs(catTextures) do
            gFrames[cat] = gFrames[cat] or {}
            gFrames[cat][state] = self:generateQuads(texture, 50, 50)
        end
    end
end

function GenerateTileMaps:generateCatTextures()
    gTextures['cats'] = {}

    local root = 'graphics/cats/Cat-'
    for k = 1, 6 do
        local path = root .. k .. '/Cat-' .. k .. '-'

        gTextures['cats']['cat' .. k] = {
            ['idle'] = love.graphics.newImage(path .. 'Idle.png'),
            ['walk'] = love.graphics.newImage(path .. 'Walk.png'),
            ['run'] = love.graphics.newImage(path .. 'Run.png'),
            ['itch'] = love.graphics.newImage(path .. 'Itch.png'),
            ['laying'] = love.graphics.newImage(path .. 'Laying.png'),
            ['licking1'] = love.graphics.newImage(path .. 'Licking 1.png'),
            ['licking2'] = love.graphics.newImage(path .. 'Licking 2.png'),
            ['meow'] = love.graphics.newImage(path .. 'Meow.png'),
            ['stretching'] = love.graphics.newImage(path .. 'Stretching.png'),
            ['sleeping1'] = love.graphics.newImage(path .. 'Sleeping1.png'),
            ['sleeping2'] = love.graphics.newImage(path .. 'Sleeping2.png'),
            ['sitting'] = love.graphics.newImage(path .. 'Sitting.png'),
        }
    end
end

function GenerateTileMaps:generateFountainFrames(atlas)
    local frames = {}
    local count = 1

    local fountainSize = 32

    local y = 11
    for x = 0, 3 do
        frames[count] = love.graphics.newQuad(16 + x * fountainSize, 16 + y * fountainSize, fountainSize, fountainSize, atlas:getDimensions())
        count = count + 1
    end

    frames.texture = atlas

    return frames
end

function GenerateTileMaps.join(table1, table2)
    local newTable = {}

    for k, v in pairs(table2) do
        newTable[k] = v
    end
    for k, v in pairs(table1) do
        newTable[k] = v
    end

    return newTable
end

return GenerateTileMaps