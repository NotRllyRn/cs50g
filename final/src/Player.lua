Player = Class{__includes = Entity}

-- TODO: finish this / work on entity first

function Player:init(def)
    Entity.init(self, def)
end

function Player:update(dt)
    Entity.update(self, dt)
end

function Player:render()
    Entity.render(self)
end