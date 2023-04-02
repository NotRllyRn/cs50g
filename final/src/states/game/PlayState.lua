PlayState = Class{__includes = BaseState}

function PlayState:init(def)
    self.player = Entity {
        x = CENTER_X,
        y = CENTER_Y,

        width = TILE_SIZE,
        height = TILE_SIZE,

        animations = ENTITY_DEFINITIONS['player'].animations,
        stateMachine = StateMachine {
            ['idle'] = function() return PlayerIdleState(self.player) end,
            ['walk'] = function() return PlayerWalkState(self.player) end,
        },

        type = 'character' .. def.character,
        state = 'idle'
    }

    self.player:changeState('idle')

    gSounds['intro']:stop()
    gSounds['background']:setLooping(true)
    gSounds['background']:setVolume(0.1)
    gSounds['background']:play()
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        --gStateStack:push(PauseState())
        love.event.quit()
    else
        self.player:update(dt)
    end
end

function PlayState:render()
    self.player:render()
end