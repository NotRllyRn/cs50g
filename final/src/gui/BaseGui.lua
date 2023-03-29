BaseGui = Class{}

function BaseGui:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.display = true
end
function BaseGui:update(dt) end
function BaseGui:render() end
