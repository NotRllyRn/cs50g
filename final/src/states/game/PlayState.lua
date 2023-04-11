PlayState = Class{__includes = BaseState}

function PlayState:init(def)
    self.level = Level {
        tileWidth = 25,
        tileHeight = 18,
    }

    self.player = Entity {
        x = CENTER_X,
        y = CENTER_Y,

        typeOfEntity = 'player',

        width = TILE_SIZE,
        height = TILE_SIZE,

        animations = ENTITY_DEFINITIONS['player'].animations,
        stateMachine = StateMachine {
            ['idle'] = function() return PlayerIdleState(self.player) end,
            ['walk'] = function() return PlayerWalkState(self.player, self.level) end,
            ['run'] = function() return PlayerRunState(self.player, self.level) end,
        },

        type = 'character' .. def.character,
        state = 'idle'
    }
    self.player:changeState('idle')

    self.level.player = self.player
    table.insert(self.level.renderOrder, self.player)

    gSounds['intro']:stop()
    gSounds['background']:setLooping(true)
    gSounds['background']:setVolume(0.1)
    gSounds['background']:play()
end

function PlayState:update(deltaTime)
    if love.keyboard.wasPressed('escape') then
        PlaySound(gSounds['menu-select'])

        gStateStack:push(PauseState())
    else
        self.level:update(deltaTime)
    end
end

function PlayState:render()
    self.level:render()
end