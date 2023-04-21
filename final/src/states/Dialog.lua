Dialog = Class{}

function Dialog:init(def)
    self.text = def.text
    self.font = def.font or gFonts['large']

    self.backdrop = Backdrop {
        x = VIRTUAL_WIDTH / 2,
        y = VIRTUAL_HEIGHT / 4 * 3,

        width = VIRTUAL_WIDTH,
        height = VIRTUAL_HEIGHT / 2,
    }
end

-- TODO: make it so that it appears the text at a certain speed and then waits for input to continue

