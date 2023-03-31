PlayerSelection = Class{__includes = BaseState}

function PlayerSelection:init(def)
    self.donuts = def.donuts
    self.moveRate = def.moveRate

    self.donutSize = TILE_SIZE * 2

    self.time = 0
    self.limit = 1.5

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
        scale = 5,
    }

    self.guiElements = {
        Backdrop {
            x = CENTER_X,
            y = CENTER_Y,
            width = VIRTUAL_WIDTH / 4 * 3,
            height = VIRTUAL_HEIGHT / 4 * 3,
        },
        -- // button on the right
        Button {
            x = VIRTUAL_WIDTH / 4 * 3,
            y = VIRTUAL_HEIGHT / 2,
            width = 64,
            height = 64,
            onPress = function()
                self:changeCharacter(self.character + 1)
            end,
            frame = 43,
            scale = 4,
        },
        -- // button on the left
        Button {
            x = VIRTUAL_WIDTH / 4,
            y = VIRTUAL_HEIGHT / 2,
            width = 64,
            height = 64,
            onPress = function()
                self:changeCharacter(self.character - 1)
            end,
            frame = 49,
            scale = 4,
        },
        Text {
            x = VIRTUAL_WIDTH / 2,
            y = VIRTUAL_HEIGHT / 4,
            text = 'Select your character',
            font = gFonts['large'],
            color = {1, 1, 1, 1},
            alignment = 'center',
            displayBackdrop = false,
        },
        ['Character'] = Text {
            x = VIRTUAL_WIDTH / 2,
            y = VIRTUAL_HEIGHT / 4 * 3,
            text = 'Character ' .. self.character,
            font = gFonts['large'],
            color = {1, 1, 1, 1},
            alignment = 'center',
            displayBackdrop = false,
        },
    }
end

function PlayerSelection:changeCharacter(newIndex)
    self.character = newIndex
    if self.character > 10 then
        self.character = 1
    elseif self.character < 1 then
        self.character = 10
    end

    self.player.type = 'character' .. self.character
    self.guiElements['Character']:setText('Character ' .. self.character)
end

function PlayerSelection:update(deltaTime)
    StartState.update(self, deltaTime)

    self.time = self.time + deltaTime
    if self.time > self.limit then
        if self.player.direction == 'down' then
            self.player.direction = 'left'
        elseif self.player.direction == 'left' then
            self.player.direction = 'up'
        elseif self.player.direction == 'up' then
            self.player.direction = 'right'
        elseif self.player.direction == 'right' then
            self.player.direction = 'down'
        end

        self.player:changeAnimation('walk-' .. self.player.direction, 'walk')

        self.time = self.time % self.limit
    end

    if love.keyboard.wasPressed('left') or love.keyboard.wasPressed('a') then
        self:changeCharacter(self.character - 1)
    elseif love.keyboard.wasPressed('right') or love.keyboard.wasPressed('d') then
        self:changeCharacter(self.character + 1)
    end

    self.player:update(deltaTime)
    
    for _, guiElement in pairs(self.guiElements) do
        guiElement:update(deltaTime)
    end
end

function PlayerSelection:render()
    StartState.render(self)

    love.graphics.setColor(1, 1, 1, 1)

    for _, guiElement in pairs(self.guiElements) do
        guiElement:render()
    end

    self.player:render()
end