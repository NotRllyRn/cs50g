-- // starting the game

require 'src/Dependencies' -- // require dependencies that will be used in the game

function love.load()
    love.window.setTitle('Cat Cafe Haven!')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    gStateStack = StateStack()
    gStateStack:push(StartState{})

    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}
    love.mouse.keysReleased = {}

    Barr = Bar{
        x = 100,
        y = 100,
        length = 4,
        direction = 'horizontal'
    }
end

function love.resize(width, height)
    push:resize(width, height)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.mousepressed(x, y, key)
    love.mouse.keysPressed[key] = true
end

function love.mousereleased(x, y, key)
    love.mouse.keysReleased[key] = true 
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.mouse.wasPressed(key)
    return love.mouse.keysPressed[key]
end

function love.mouse.wasReleased(key)
    return love.mouse.keysReleased[key]
end

function love.update(deltaTime)
    Timer.update(deltaTime)
    gStateStack:update(deltaTime)

    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}
    love.mouse.keysReleased = {}

    Barr:update(deltaTime)
end

function love.draw()
    push:start()
    gStateStack:render()

    Barr:render()
    push:finish()
end