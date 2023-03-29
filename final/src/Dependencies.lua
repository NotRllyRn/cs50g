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

require 'src/Donut' -- // donut class

require 'src/gui/BaseGui' -- // base gui that will be used as a template for other guis
require 'src/gui/Backdrop' -- // backdrop gui that will be used to create a backdrop for other guis

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
}

gTextures = {
    ['tiles'] = love.graphics.newImage('graphics/CatThemedTileSet.png'),
}

gFrames = {
    ['donuts'] = GenerateTileMaps:generateDonuts(gTextures['tiles']),
    ['tileSet'] = GenerateTileMaps:generateTileSet(gTextures['tiles']),
}

gFrames.donuts.texture = gTextures['tiles']
gFrames.tileset.texture = gTextures['tiles']

gSounds = {}