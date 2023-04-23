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
    ['cat'] = {
        catSizes = {
            --[[
                Sizes:
                Cat 1:20 x14 px
                Cat 2:20 x14 px
                Cat 3:20 x14 px
                Cat 4:22 x15 px
                Cat 5:22 x14 px
                Cat 6:20 x14 px
            ]]
            [1] = {20, 14},
            [2] = {20, 14},
            [3] = {20, 14},
            [4] = {22, 15},
            [5] = {22, 14},
            [6] = {20, 14},
        },
        walkSpeed = 30,
        runSpeed = 90,
        animations = {
            --[[
                Animations:
                Idle - 10 frames
                Walk - 8 frames
                Run - 8 frames
                Meow-  4 frames
                Laying - 8 frames
                Itch - 10 frames
                Sleeping1 - 1 frame
                Sleeping2 - 1 frame
                Sitting - 1 frame
                Licking1 - 5 frames
                Licking2 - 5 frames
                Stretching - 13 frames    
            --]]
            ['idle'] = {
                frames = {1, 2, 3, 4, 5, 6, 8, 9 , 10},
                interval = 0.155,
            },
            ['walk'] = {
                frames = {1, 2, 3, 4, 5, 6, 8},
                interval = 0.155,
            },
            ['run'] = {
                frames = {1, 2, 3, 4, 5, 6, 8},
                interval = 0.085,
            },
            ['meow'] = {
                frames = {1, 2, 3, 4},
                interval = 0.155,
            },
            ['laying'] = {
                frames = {1, 2, 3, 4, 6, 7, 8},
                interval = 0.155,
                looping = false,
            },
            ['itch'] = {
                frames = {1, 2},
                interval = 0.155,
            },
            ['sleeping1'] = {
                frames = {1},
                interval = 0.155,
            },
            ['sleeping2'] = {
                frames = {1},
                interval = 0.155,
            },
            ['sitting'] = {
                frames = {1},
                interval = 0.155,
                looping = false,
            },
            ['licking1'] = {
                frames = {1, 2, 3, 4, 5},
                interval = 0.155,
            },
            ['licking2'] = {
                frames = {1, 2, 3, 4, 5},
                interval = 0.155,
            },
            ['stretching'] = {
                frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13},
                interval = 0.155,
                looping = false,
            },
            ['stretching-reverse'] = {
                frames = {13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1},
                interval = 0.155,
                looping = false,
            },
            ['laying-reverse'] = {
                frames = {8, 7, 6, 4, 3, 2, 1},
                interval = 0.155,
                looping = false,
            }
        },
        dialog = {
            pet = {
                '%s liked that!',
                '%s is purring!',
                '%s is happy!',
            },
            --TODO: add more lines of dialog for feed and water
            feed = {
                '%s noms on the food',
                '%s is getting fuller',
                '%s ',
            },
        }
    }
}