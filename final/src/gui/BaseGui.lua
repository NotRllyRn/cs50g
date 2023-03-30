BaseGui = Class{}

function BaseGui:init(def)
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height

    self.display = def.display or true
end

function BaseGui:update(dt) end
function BaseGui:render() end