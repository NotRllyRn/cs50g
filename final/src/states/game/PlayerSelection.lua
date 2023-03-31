PlayerSelection = Class{__includes = BaseState}

function PlayerSelection:init(def)
    self.donuts = def.donuts
    self.moveRate = def.moveRate

    self.donutSize = TILE_SIZE * 2

    self.character = math.random(10)
    self.player = Entity {
        x = CENTER_X,
        y = CENTER_Y,

        width = TILE_SIZE,
        height = TILE_SIZE,

        animations = ENTITY_DEFINITIONS['player'].animations,

        type = 'character' .. self.character,
        state = 'walk',

        direction = 'down',
    }

    print(#gFrames['cursors'])

    self.buttonLeft = Button {
        x = VIRTUAL_WIDTH / 4,
        y = VIRTUAL_HEIGHT / 2,
        width = 64,
        height = 64,
        onPress = function()
            self.character = self.character - 1
            if self.character < 1 then
                self.character = 10
            end
            self.player.type = 'character' .. self.character
        end,
        frame = 43,
    }

    self.buttonRight = Button {
        x = VIRTUAL_WIDTH / 4 * 3,
        y = VIRTUAL_HEIGHT / 2,
        width = 64,
        height = 64,
        onPress = function()
            self.character = self.character + 1
            if self.character > 10 then
                self.character = 1
            end
            self.player.type = 'character' .. self.character
        end,
        frame = 49,
    }
end

function PlayerSelection:update(deltaTime)
    StartState.update(self, deltaTime)

    self.player:update(deltaTime)
    self.buttonLeft:update(deltaTime)
    self.buttonRight:update(deltaTime)
end

function PlayerSelection:render()
    StartState.render(self)

    love.graphics.setColor(1, 1, 1, 1)

    self.player:render(5, 5)
    self.buttonLeft:render(4, 4)
    self.buttonRight:render(4, 4)
end