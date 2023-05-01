-- // require dependencies that will be used in the game

push = require 'lib/push' -- // rendering a virtual resolution
Class = require 'lib/class' -- // class library
Timer = require 'lib/knife.timer' -- // timer library

GenerateTileMaps = require'src/GenerateTileMaps' -- // generate tile maps
PlaySound = require 'src/PlaySound' -- // play sound

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.TTF', 8),
    ['medium'] = love.graphics.newFont('fonts/font.TTF', 16),
    ['large'] = love.graphics.newFont('fonts/font.TTF', 32),
    ['huge'] = love.graphics.newFont('fonts/font.TTF', 64),
}

gTextures = {
    ['tiles'] = love.graphics.newImage('graphics/CatThemedTileSet.png'),
    ['gui'] = love.graphics.newImage('graphics/gui/UIElements.png'),
    ['housing'] = love.graphics.newImage('graphics/house_interiors_assets.png'),
    ['walls'] = love.graphics.newImage('graphics/house_building_assets.png'),
    ['outside'] = love.graphics.newImage('graphics/SmallBurg_outside_assets.png'),
    ['keyboard'] = love.graphics.newImage('graphics/pixel_keys_x16_black.png'),
    ['gui-other'] = love.graphics.newImage('graphics/gui/Spritesheet_UI_Flat.png'),
}
GenerateTileMaps:generateCharacterTextures()
GenerateTileMaps:generateCatTextures()

gFrames = {
    ['donuts'] = GenerateTileMaps:generateDonuts(gTextures['tiles']),
    ['tileSet'] = GenerateTileMaps:generateTileSet(gTextures['tiles']),
    ['cursors'] = GenerateTileMaps:generateCursors(gTextures['gui']),
    ['housing'] = GenerateTileMaps:generateQuads(gTextures['housing'], 16, 16),
    ['walls'] = GenerateTileMaps:generateQuads(gTextures['walls'], 16, 16),
    ['outside'] = GenerateTileMaps:generateQuads(gTextures['outside'], 16, 16),
    ['fountain'] = GenerateTileMaps:generateFountainFrames(gTextures['outside']),
    ['keys'] = GenerateTileMaps:generateQuads(gTextures['keyboard'], 16, 16),
    ['gui'] = GenerateTileMaps:generateQuads(gTextures['gui-other'], 16, 16, 8, 8),
}
GenerateTileMaps:generateCharacterFrames()
GenerateTileMaps:generateCatFrames()

gSounds = {
    ['intro'] = love.audio.newSource('sounds/Ludum Dare 38 - Track 1.wav', 'static'),
    ['background'] = love.audio.newSource('sounds/Puzzles.ogg', 'static'),
    ['menu-select'] = love.audio.newSource('sounds/MenuSelections.ogg', 'static'),
    ['victory'] = love.audio.newSource('sounds/You_re in the Future.ogg', 'static')
}
GenerateTileMaps:loadWaterSounds()
GenerateTileMaps:loadCatMeows()
GenerateTileMaps:loadFoodSounds()

gSounds['menu-select']:setVolume(0.35)

require 'src/Animation'

require 'src/Constants' -- // constants that are used in the game

require 'src/StateMachine' -- // state machine that will be used to manage game states
require 'src/states/StateStack' -- // a stack of states

require 'src/EntityDefinitions'
require 'src/ObjectDefinitions'

require 'src/states/BaseState' -- // base state that will be used as a template for other states

require 'src/Tile'
require 'src/Object'
require 'src/Level'

require 'src/states/entity/EntityIdleState' -- // entity idle state that will be used to manage entity idle state
require 'src/states/entity/EntityWalkState' -- // entity walk state that will be used to manage entity walk state

require 'src/states/entity/player/PlayerIdleState' -- // player idle state that will be used to manage player idle state
require 'src/states/entity/player/PlayerWalkState' -- // player walk state that will be used to manage player walk state
require 'src/states/entity/player/PlayerRunState' -- // player run state that will be used to manage player run state

require 'src/states/entity/cat/CatIdleState' -- // cat idle state that will be used to manage cat idle state
require 'src/states/entity/cat/CatWalkState' -- // cat walk state that will be used to manage cat walk state
-- run state
require 'src/states/entity/cat/CatRunState' -- // cat run state that will be used to manage cat run state
-- laying
require 'src/states/entity/cat/CatLayingState' -- // cat lay state that will be used to manage cat lay state
-- itch and meow and stretching
require 'src/states/entity/cat/CatItchState' -- // cat itch state that will be used to manage cat itch state
require 'src/states/entity/cat/CatMeowState' -- // cat meow state that will be used to manage cat meow state
require 'src/states/entity/cat/CatStretchingState' -- // cat stretch state that will be used to manage cat stretch state
-- sitting
require 'src/states/entity/cat/CatSittingState' -- // cat sit state that will be used to manage cat sit state
-- licking
require 'src/states/entity/cat/CatLickingState' -- // cat lick state that will be used to manage cat lick state
-- sleeping
require 'src/states/entity/cat/CatSleepingState' -- // cat sleep state that will be used to manage cat sleep state

require 'src/Entity' -- // entity class
require 'src/Cat'

require 'src/Donut' -- // donut class

require 'src/gui/BaseGui' -- // base gui that will be used as a template for other guis
require 'src/gui/Dialog'
require 'src/gui/GuiGroup'
require 'src/gui/Backdrop' -- // backdrop gui that will be used to create a backdrop for other guis
require 'src/gui/Button'
require 'src/gui/Text'
require 'src/gui/TextButton'
require 'src/gui/Selection'
require 'src/gui/Bar'

require 'src/states/FadeInState' -- // fade in state that will be used to fade in the game
require 'src/states/FadeOutState' -- // fade out state that will be used to fade out the game
require 'src/states/game/PlayerSelection' -- // player selection state that will be used to select the player
require'src/states/game/Credits'
require 'src/states/game/StartState' -- // start state that will be used to start the game
require 'src/states/game/TutorialState'
require 'src/states/game/PauseState'
require 'src/states/game/VictoryState'
require 'src/states/game/PlayState' -- // play state that will be used to play the game