
local composer = require( "composer" )
local scene = composer.newScene()

local latitude
local longitude


function nextScene()
    composer.setVariable("lat", latitude)
    composer.setVariable("long", longitude)
    composer.gotoScene( "map" )
end

local locationHandler = function( event )
    -- Check for error (user may have turned off location services)
    if ( event.errorCode ) then
        native.showAlert( "GPS Location Error", event.errorMessage, {"OK"} )
        print( "Location error: " .. tostring( event.errorMessage ) )
    else
        print(event.latitude)
        latitude = event.latitude
        print(event.longitude)
        longitude = event.longitude
    end
end


function scene:create( event )

    local sceneGroup = self.view
    local sheetOptions =
    {
        width = 320,
        height = 480,
        numFrames = 10
    }
    local sheet_turning_pizza = graphics.newImageSheet( "backgroundIS.png", sheetOptions )
    local sequence_turning_pizza = {
        name = "normalRun",
        start = 1,
        count = 10,
        time = 1000,
        loopCount = 4,
        loopDirection = "forward"
    }
    local turningPizza = display.newSprite( sceneGroup, sheet_turning_pizza, sequence_turning_pizza)
    turningPizza:play()
    turningPizza.x = display.contentCenterX
    turningPizza.y = display.contentCenterY

    local title = display.newText( sceneGroup,"Pizza Finder", display.contentCenterX, 0, native.systemFontBold, 40 )
    title:setFillColor( 1, 0, 0 )
    
    Runtime:addEventListener( "location", locationHandler )
    timer.performWithDelay( 4000, nextScene )
end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        composer.removeScene( "list" )

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
