
local composer = require( "composer" )
local scene = composer.newScene()
local buisness ={}
local latitude
local longitude

local function gotoList()
	composer.gotoScene( "list", { time=800, effect="crossFade" } )
end


function scene:create( event )
    latitude = composer.getVariable("lat")
    longitude = composer.getVariable("long")
    local sceneGroup = self.view
    local title = display.newText( sceneGroup,"Pizza Finder", display.contentCenterX, 0, native.systemFont, 40 )
    title:setFillColor( 1, 0, 0 )
    local myRectangle= display.newRect(sceneGroup, 160,20, 320, 2)
    myRectangle.strokeWidth = 1
    myRectangle:setStrokeColor( 0, 0, 0 )
    -- Code here runs when the scene is first created but has not yet appeared on screen
   buisness = composer.getVariable( "buisness" ) 
    composer.setVariable( "buisness", 0 )

    local name = display.newText( sceneGroup, buisness.name, display.contentCenterX, 40, native.systemFont, 20 )
    --name:setFillColor( 1, .3, 0 )
    local rating = display.newText( sceneGroup, "Rating: " .. buisness.rating, display.contentCenterX, 70, native.systemFont, 20 )
   	local phone = display.newText( sceneGroup, "Phone: " .. buisness.phone, display.contentCenterX, 95, native.systemFont, 20 )
    local price = display.newText( sceneGroup, "Price: " .. buisness.price, display.contentCenterX, 120, native.systemFont, 20 )
    if(buisness.isClosed == false) then
   		local open = display.newText( sceneGroup, "Currently Open", display.contentCenterX, 145, native.systemFont, 20 )
   	else
   		local open = display.newText( sceneGroup, "Currently Closed", display.contentCenterX, 145, native.systemFont, 20 )
    end
    local loc =  display.newText( sceneGroup,buisness.location.address1 .. "," .. buisness.location.city, display.contentCenterX, 170, native.systemFont, 17 )
    local dist = display.newText( sceneGroup, "Distance: " .. math.round(buisness.distance), display.contentCenterX, 195, native.systemFont, 20 )

    local backButton = display.newText( sceneGroup, "BACK", display.contentCenterX, 430, native.systemFont, 30)
    backButton:setFillColor( 0.75, 0.78, 1 )
    backButton:addEventListener( "tap", gotoList )
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
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		composer.removeScene( "specifics" )
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
