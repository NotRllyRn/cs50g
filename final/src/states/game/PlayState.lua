PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.player = Entity {
        x = CENTER_X,
        y = CENTER_Y,

        width = TILE_SIZE,
        height = TILE_SIZE,

        animations = ENTITY_DEFINITIONS['player'].animations,
        stateMachine = StateMachine {
            ['idle'] = function() return PlayerIdleState(self.player) end,
            ['walking'] = function() return PlayerWalkingState(self.player) end,
        },

        type = 'character' .. math.random(10),
        state = 'idle'
    }
end

function PlayState:enter(params)
    self.player.type = 'character' .. params.character
end

function PlayState:update(dt)
    self.player:update(dt)
end

function PlayState:render()
    self.player:render()
end