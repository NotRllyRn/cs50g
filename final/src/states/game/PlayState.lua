PlayState = Class{__includes = BaseState}

function PlayState:init(def)
    self.donuts = def.donuts
    self.moveRate = def.moveRate

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

        local cats = {}
        for k, entity in pairs(self.level.entities) do
            if entity.typeOfEntity == 'cat' then
                table.insert(cats, entity)
            end
        end

        local won = true
        for k, cat in pairs(cats) do
            if cat.stats.happiness > 0.9 then
                won = false
                break
            end
        end

        if won then
            gStateStack:push(FadeInState({
                r = 255, g = 255, b = 255
            }, 1, function()
                gStateStack:pop() -- // play state
                gStateStack:push(VictoryState{
                    donuts = self.donuts,
                    moveRate = self.moveRate,
                })
                gStateStack:push(FadeOutState({
                    r = 255, g = 255, b = 255
                }, 1))
            end))
        end
    end
end

function PlayState:render()
    self.level:render()
end