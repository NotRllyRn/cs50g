DefeatState = Class{__includes = VictoryState}

function DefeatState:init(def)
    self.donuts = def.donuts
    self.moveRate = def.moveRate

    self.donutSize = TILE_SIZE * 2

    self.winText = Text{
        text = 'Oh no :( You ran out of time! Try feeding, watering, and petting the cat more! Try again!',
        x = CENTER_X,
        y = CENTER_Y,
        font = gFonts['large'],
        width = VIRTUAL_WIDTH - TILE_SIZE * 3,
        align = 'center',
    }

    gSounds['background']:stop()
    gSounds['victory']:setLooping(true)
    gSounds['victory']:setVolume(0.2)
    gSounds['victory']:play()
end