CatMeowState = Class{__includes = BaseState}

function CatMeowState:init(entity)
    self.entity = entity

    self.entity:changeAnimation('meow')
    self.entity.currentAnimation:refresh()

    PlaySound(gSounds['meow' .. math.random(3)])
end

function CatMeowState:update(deltaTime)
    if self.entity.currentAnimation.timesPlayed > 0 then
        self.entity:changeState('idle')
    end
end

function CatMeowState:render()
    self.entity:render()
end