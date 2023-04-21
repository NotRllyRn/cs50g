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
    },
    ['fridge-gold'] = {
        tiles = {
            [1] = {1152},
            [2] = {1202},
        },
        width = TILE_SIZE,
        height = TILE_SIZE + 6,
        solid = true,
        collidable = true,
        frame = gFrames['housing'],
    },
    ['fridge-white'] = {
        tiles = {
            [1] = {752},
            [2] = {802},
        },
        width = TILE_SIZE,
        height = TILE_SIZE + 6,
        solid = true,
        collidable = true,
        frame = gFrames['housing'],
    },
    ['fridge-blue'] = {
        tiles = {
            [1] = {822},
            [2] = {872},
        },
        width = TILE_SIZE,
        height = TILE_SIZE + 6,
        solid = true,
        collidable = true,
        frame = gFrames['housing'],
    },
    ['fridge-pink'] = {
        tiles = {
            [1] = {922},
            [2] = {972},
        },
        width = TILE_SIZE,
        height = TILE_SIZE + 6,
        solid = true,
        collidable = true,
        frame = gFrames['housing'],
    },
    ['fridge-green'] = {
        tiles = {
            [1] = {1022},
            [2] = {1072},
        },
        width = TILE_SIZE,
        height = TILE_SIZE + 6,
        solid = true,
        collidable = true,
        frame = gFrames['housing'],
    },
    ['fridge-red'] = {
        tiles = {
            [1] = {952},
            [2] = {1002},
        },
        width = TILE_SIZE,
        height = TILE_SIZE + 6,
        solid = true,
        collidable = true,
        frame = gFrames['housing'],
    },
    ['fridge-green2'] = {
        tiles = {
            [1] = {1352},
            [2] = {1402},
        },
        width = TILE_SIZE,
        height = TILE_SIZE + 6,
        solid = true,
        collidable = true,
        frame = gFrames['housing'],
    },
    ['fridge-colors'] = {
        'white', 'red', 'green', 'green2', 'gold', 'pink', 'blue',
    }
}