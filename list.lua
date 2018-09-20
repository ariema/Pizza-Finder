
local widget = require "widget"

local composer = require( "composer" )
local scene = composer.newScene()
buisnesses = {}
api_key = '6LmkdTHeGWsdWpTnvsqQkrnL0D6UbJY8RQOjZYpH_1vNWVXHF5-4Dd8kTd17Lqr7hw76TB2Xirj03piWr7eC3eXWVAEkgZwJznmN55KZw_oEAZnDfZtn5mwsG378WnYx'
local json = require("json")
local header = {}
resturants = {}
markerData = {}
header["Authorization"] = "Bearer 6LmkdTHeGWsdWpTnvsqQkrnL0D6UbJY8RQOjZYpH_1vNWVXHF5-4Dd8kTd17Lqr7hw76TB2Xirj03piWr7eC3eXWVAEkgZwJznmN55KZw_oEAZnDfZtn5mwsG378WnYx"
local response
local latitude
local longitude


local function gotoSpecifics(event)
    composer.setVariable( "buisness", event.target.data )
    composer.gotoScene( "specifics", { time=800, effect="crossFade" } )
end

local function gotoMapDisplay(event)
    composer.setVariable( "buisnesses", event.target.data )
    composer.gotoScene( "map", { time=800, effect="crossFade" } )
end



local function compare( a, b )
    return a.rating > b.rating
end


function scene:create( event )

    local sceneGroup = self.view

    latitude = composer.getVariable("lat")
    longitude = composer.getVariable("long")

    --local title = display.newText( sceneGroup,"Pizza Finder", display.contentCenterX, 0, native.systemFont, 40 )
    --title:setFillColor( 1, 0, 0 )
    local options = {
        parent = self.view,
        text = "MAP",
        x = display.contentCenterX,
        y = 3,
        font = native.systemFont,
        fontSize = 20,
    }
    local goToMap = display.newText(options)
    goToList:setFillColor(0,0,1)
    goToList:addEventListener("tap", gotoMapDisplay)

    function displayData(tbl)
    local val = 40
    for k,v in pairs(tbl) do
        if type(v) == "table" then
            local data = "  " .. v.name .. "\n    rating: " .. v.rating 
        local options = {
            parent = sceneGroup,
            text = data,
            x = display.contentCenterX,
            y = val,
            fontSize = 15,
            width = 320,
            align = "left",
            }
            local button = display.newText(options)
            button:addEventListener( "tap", gotoSpecifics)
            button.data = v
            --local myRectangle= display.newRect(sceneGroup, 160,val-20, 320, 2)
            --myRectangle.strokeWidth = 1
            --myRectangle:setStrokeColor( 0, 0, 0 )

            val = val + 40
        end
    end
end


  function tprint (tbl)
    for k, v in pairs(tbl) do
        local i = 0;
            if type(v) == "table" then
                for i=20, 1, -1 do
                    if(k == i) then
                        if(v.name) then
                            local temp = {}
                            temp["name"] = v.name
                            temp["rating"] = v.rating
                            temp["price"] = v.price
                            temp["phone"] = v.phone
                            temp["location"] = v.location
                            temp["isClosed"] = v.is_closed
                            temp["distance"] = v.distance
                            temp["location"] =v.location
                            temp["coordinates"] = v.coordinates
                            table.insert(buisnesses, temp)
                            table.sort( buisnesses, compare )
                            if i==20 then    
                                local bestRated
                                for k,v in pairs(buisnesses) do
                                    if(k == 1) then
                                       bestRated = v
                                    end                                    
                                end
                                goToMap.data = buisnesses
                                displayData(buisnesses)
                            end
                        end
                    end
                end
                tprint(v)
            end
        end 
    end


    function networkListener( event )
        if ( event.isError ) then
            print( "Network error: ", event.response )
        else
            response = event.response
            resturants = json.decode(response)
            tprint(resturants)
        end  
    end


    local url_params = {}
    url_params.headers = header
    local search_term = "pizza"
    local url = "https://api.yelp.com/v3/businesses/search?term=" .. search_term .. "&latitude=" .. latitude .. "&longitude=" .. longitude
    network.request(url,"GET", networkListener, url_params) 


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
