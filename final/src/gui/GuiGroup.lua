GuiGroup = Class{}

function GuiGroup:init(def)
    self.guiElements = def

    self.display = def.display == nil and true or def.display
end

function GuiGroup:update(deltaTime)
    if self.display then
        for k, guiElement in pairs(self.guiElements) do
            guiElement:update(deltaTime)
        end
    end
end

function GuiGroup:render()
    if self.display then
        for k, guiElement in pairs(self.guiElements) do
            guiElement:render()
        end
    end
end