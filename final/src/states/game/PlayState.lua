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

    self.timer = 60 * 5
    self.timerDisplay = Text {
        displayBackdrop = false,
        font = gFonts['small'],
        text = string.format('%d:%02d', math.floor(self.timer / 60), math.floor(self.timer % 60)),
        x = CENTER_X,
        y = 5,
        width = VIRTUAL_WIDTH,
    }

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
        self.timer = self.timer - deltaTime
        if self.timer <= 0 then
            -- // the user has lost

            gStateStack:push(FadeInState({
                r = 255, g = 255, b = 255
            }, 1, function()
                gStateStack:pop() -- // play state
                gStateStack:push(DefeatState{
                    donuts = self.donuts,
                    moveRate = self.moveRate,
                })
                gStateStack:push(FadeOutState({
                    r = 255, g = 255, b = 255
                }, 1))
            end))
        else
            self.level:update(deltaTime)

            -- quickly identify all the cats
            local cats = {}
            for k, entity in pairs(self.level.entities) do
                if entity.typeOfEntity == 'cat' then
                    table.insert(cats, entity)
                end
            end

            -- // to have an end state
            local won = true
            for k, cat in pairs(cats) do
                -- // to determine if all the cats are above 90 % happy
                if cat.stats.happiness < 0.9 then
                    won = false
                    break
                end
            end

            if won then
                gStateStack:push(FadeInState({
                    r = 255, g = 255, b = 255
                }, 1, function()
                    for k, state in pairs(gStateStack.states) do
                        gStateStack:pop()
                    end
                    gStateStack:push(VictoryState{
                        donuts = self.donuts,
                        moveRate = self.moveRate,
                    })
                    gStateStack:push(FadeOutState({
                        r = 255, g = 255, b = 255
                    }, 1))
                end))
            end

            self.timerDisplay:setText(string.format('%d:%02d', math.floor(self.timer / 60), math.floor(self.timer % 60)))
        end
    end
end

function PlayState:render()
    self.level:render()

    self.timerDisplay:render()
end