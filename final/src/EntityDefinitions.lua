-- inspired by Zelda from cs50g

ENTITY_DEFINITIONS = {
    ['player'] = {
        walkSpeed = 58,
        runSpeed = 100,
        animations = {
            ['idle-right'] = {
                frames = {1, 2},
                interval = 0.25,
            },
            ['idle-left'] = {
                frames = {3, 4},
                interval = 0.25,
            },
            ['idle-down'] = {
                frames = {5, 6},
                interval = 0.25,
            },
            ['idle-up'] = {
                frames = {7, 8},
                interval = 0.25,
            },
            ['run-right'] = {
                frames = {1, 2, 3, 4},
                interval = 0.155,
            },
            ['run-left'] = {
                frames = {5, 6, 7, 8},
                interval = 0.155,
            },
            ['run-down'] = {
                frames = {9, 10, 11, 12},
                interval = 0.155,
            },
            ['run-up'] = {
                frames = {13, 14, 15, 16},
                interval = 0.155,
            },
            ['walk-right'] = {
                frames = {1, 2, 3, 4, 5, 6},
                interval = 0.155,
            },
            ['walk-left'] = {
                frames = {7, 8, 9, 10, 11, 12},
                interval = 0.155,
            },
            ['walk-down'] = {
                frames = {13, 14, 15, 16, 17, 18},
                interval = 0.155,
            },
            ['walk-up'] = {
                frames = {19, 20, 21, 22, 23, 24},
                interval = 0.155,
            },
        },
    },
}