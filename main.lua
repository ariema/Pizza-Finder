-- Hide status bar
display.setStatusBar( display.HiddenStatusBar )
local composer = require( "composer" )

-- Seed the random number generator
math.randomseed( os.time() )

composer.gotoScene("menu")