-- // require dependencies that will be used in the game

push = require 'lib/push' -- // rendering a virtual resolution
Class = require 'lib/class' -- // class library
Timer = require 'lib/knife.timer' -- // timer library

GenerateTileMaps = require'src/GenerateTileMaps' -- // generate tile maps

require 'src/Constants' -- // constants that are used in the game

require 'src/StateMachine' -- // state machine that will be used to manage game states
require 'src/states/StateStack' -- // a stack of states

require 'src/states/BaseState' -- // base state that will be used as a template for other states
require 'src/states/game/StartState' -- // start state that will be used to start the game

require 'src/EntityDefinitions'

require 'src/Donut' -- // donut class

require 'src/gui/BaseGui' -- // base gui that will be used as a template for other guis
require 'src/gui/Backdrop' -- // backdrop gui that will be used to create a backdrop for other guis
require 'src/gui/Text'
require 'src/gui/TextButton'
require 'src/gui/Selection'

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['huge'] = love.graphics.newFont('fonts/font.ttf', 64)
}

gTextures = {
    ['tiles'] = love.graphics.newImage('graphics/CatThemedTileSet.png'),
    ['gui'] = love.graphics.newImage('graphics/gui/UIElements.png'),
}
GenerateTileMaps:generateCharacterTextures()

gFrames = {
    ['donuts'] = GenerateTileMaps:generateDonuts(gTextures['tiles']),
    ['tileSet'] = GenerateTileMaps:generateTileSet(gTextures['tiles']),
    ['cursors'] = GenerateTileMaps:generateCursors(gTextures['gui']),
}
GenerateTileMaps:generateCharacterFrames()

gSounds = {}