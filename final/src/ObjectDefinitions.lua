-- // inspired by zelda game in cs50g

OBJECT_DEFINTIONS = {
    ['bush1'] = {
        tiles = {
            [1] = {531},
            [2] = {563},
        },
        width = TILE_SIZE,
        height = TILE_SIZE * 2,
        frame = gFrames['outside'],
        solid = true,
    },
    ['bush2'] = {
        tiles = {
            [1] = {532},
            [2] = {564},
        },
        width = TILE_SIZE,
        height = TILE_SIZE * 2,
        frame = gFrames['outside'],
        solid = true,
    },
    ['bush3'] = {
        tiles = {
            [1] = {533},
            [2] = {565},
        },
        width = TILE_SIZE,
        height = TILE_SIZE * 2,
        frame = gFrames['outside'],
        solid = true,
    },
    ['bush4'] = {
        tiles = {
            [1] = {534},
            [2] = {566},
        },
        width = TILE_SIZE,
        height = TILE_SIZE * 2,
        frame = gFrames['outside'],
        solid = true,
    },
    ['fountain'] = {
        animations = {
            ['idle'] = {
                frames = {1, 2, 3, 4},
                interval = 0.5,
            }
        },
        width = TILE_SIZE * 2,
        height = TILE_SIZE * 2,
        frame = gFrames['fountain'],
        solid = true,
        state = 'idle',
        collidable = true,
    }
}