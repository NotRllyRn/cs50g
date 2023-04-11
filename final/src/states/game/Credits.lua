Credits = Class{__includes = BaseState}

function Credits:init(def)
    self.donuts = def.donuts
    self.moveRate = def.moveRate
    self.donutSize = TILE_SIZE * 2

    self.elementMoveRate = 25

    self.guiElements = {}
    local texts = {
        {text = 'Credits', font = gFonts['large']},
        {text = 'Game Idea: Lotus', font = gFonts['medium']},
        {text = 'Game Design and Coding: Tim', font = gFonts['medium']},
        {text = 'Itch.io - Credits to the following assets:', font = gFonts['large']},
        {text = 'SugarLand TileSet by GatDeSucre', font = gFonts['medium']},
        {text = 'UI assets pack 2 by Sta.Toasty', font = gFonts['medium']},
        {text = 'SmallBurg Village pack by almostApixel', font = gFonts['medium']},
        {text = 'FREE Music Loop Bundle by Tallbeard Studios', font = gFonts['medium']},
        {text = '41 Short, Loopable Background Music Files by joshuuu', font = gFonts['medium']},
        {text = 'sound SFX Pack 1 - UI menu by joshuuu', font = gFonts['medium']},
        {text = 'Pet Cats Pack by LuizMelo', font = gFonts['medium']},
        {text = 'PixeMoji by ANoob', font = gFonts['medium']},
        {text = 'Cat Meow sound effects by The Sound Channel', font = gFonts['medium']},
        {text = 'Pixel Keys x16 by JoshuaJennerDev', font = gFonts['medium']},
        {text = 'GUI Essentials by Crusenho', font = gFonts['medium']},
        {text = 'Tools and Other Things I used:', font = gFonts['large']},
        {text = 'Tiled Map Editor by Thorbjørn on Itch.io', font = gFonts['medium']},
        {text = '04b03 font from dafont.com', font = gFonts['medium']},
        {text = 'LÖVE2D by the LÖVE Team', font = gFonts['medium']},
        {text = 'Thank you for playing my game! :)', font = gFonts['large']},
    }

    local edge = 0
    for k, textData in ipairs(texts) do
        local text = Text {
            x = CENTER_X,
            y = 0,
            width = textData.font == gFonts['large'] and VIRTUAL_WIDTH - 128,
            text = textData.text,
            font = textData.font,
            color = {1, 1, 1, 1},
            align = 'center',
        }
        text.y = edge + 16 + text.trueHeight / 2

        if k == #texts then
            self.guiElements['last_text'] = text
        else
            table.insert(self.guiElements, text)
            edge = text.y + text.trueHeight / 2
        end
    end
end

function Credits:update(deltaTime)
    if love.keyboard.wasPressed('escape') then
        gStateStack:push(FadeInState({
            r = 1, g = 1, b = 1
        }, 1, function()
            gStateStack:pop()
            gStateStack:push(StartState{
                donuts = self.donuts,
                moveRate = self.moveRate,
            })
            gStateStack:push(FadeOutState({
                r = 1, g = 1, b = 1
            }, 1))
        end))
    else
        StartState.update(self, deltaTime)

        for k, element in pairs(self.guiElements) do
            element.y = element.y - self.elementMoveRate * deltaTime
        end

        if self.guiElements['last_text'].y <= CENTER_Y then
            gStateStack:push(FadeInState({
                r = 1, g = 1, b = 1
            }, 1, function()
                gStateStack:pop()
                gStateStack:push(StartState{
                    donuts = self.donuts,
                    moveRate = self.moveRate,
                })
                gStateStack:push(FadeOutState({
                    r = 1, g = 1, b = 1
                }, 1))
            end))
        end
    end
end

function Credits:render()
    StartState.render(self)

    for k, element in pairs(self.guiElements) do
        element:render()
    end
end