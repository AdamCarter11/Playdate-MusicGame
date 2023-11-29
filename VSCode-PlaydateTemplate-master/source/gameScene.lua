import "NoteSpawner"
import "scoreDisplay"
import "Player"
import "Pen"
import "WaveSpawner"
import "soundModule"
import "WallCollider"
import "sceneManager"
import "menuScene"
import "gameOverScene"
import "ModuleTest"

local pd <const> = playdate
local gfx <const> = pd.graphics

--local noteSpawnerObj = require ("NoteSpawner")
--print(lfs.currentdir())
--require("ModuleTest")

class('GameScene').extends(gfx.sprite)

-- Starting Positions/Values
local SCREEN_X = 400
local SCREEN_Y = 240
local PADDING = 15
local PLAYER_X_POS = 30
local PLAYER_Y_POS = 120
local PEN_X_POS = PADDING
local PEN_BORDER_Y_MIN = SCREEN_Y - PADDING
local PEN_BORDER_Y_MAX = PEN_BORDER_Y_MIN - 75
local WAVE_LENGTH = 50
local switchTrans = false
local wait = false
local pauseTime = 15
local health = 4

function GameScene:init()
    --printHi()
    --ModuleTest:printHi()
    createScoreDisplay()
    -- Spawn player
    Player (PLAYER_X_POS, PLAYER_Y_POS)
    -- Enemy(400, 120, 1)
    Player(30, 60, gfx.image.new("Sprites/RightArrow"))
    ABPlayer(30, 150, gfx.image.new("Sprites/AButton"))

    -- Spawn the waves from the right of the screen
    WaveSpawner (400, PLAYER_Y_POS + 20, WAVE_LENGTH, 2 * math.pi, 200, 1)

    startSpawner()

    self:add()
end

function GameScene.update()
    gfx.sprite.update()
    --ModuleTest:addScore()
    --ModuleTest:printHi()
    printHi()
	if pd.buttonJustPressed(pd.kButtonA) then
        SCENE_MANAGER:switchScene(GameOverScene, "Score: 10")
    end

    if(math.floor(pd.getElapsedTime()) % 20 == 0 and switchTrans == false) then
        switchTrans = true
        TurnOffSpawner()
        -- heres an example of how we can turn off the spawner
            -- I also made a TurnOnSpawner() that can be called in the same way anywhere in this script
            -- refer to line 28 for how I got access to the object like this
        --noteSpawnerObj.TurnOffSpawner()
    end
    if(math.floor(pd.getElapsedTime()) % pauseTime == 0 and switchTrans == false) then
        pauseTime += 20
        TurnOffSpawner()
        print("timer stopped")
    end

    if(switchTrans == true) then
        Switch()
        
    end
end

--#region == Helper Functions ==
function Switch()
    playdate.gameWillResume()
end

function playdate.gameWillResume()

	-- save off the current playdate.update so we can restore it at the end of the countdown
	local saveOffUpdate = playdate.update
	
	playdate.update = 
	function()	
		
		-- draw the countdown
        gfx.clear()
        gfx.drawText( "SWAP!", 180, 100  )
		playdate.wait( 1000 )
		gfx.clear()
		gfx.drawText( "3", 200, 100 )
		playdate.wait( 1000 )
		gfx.clear()
		gfx.drawText( "2", 200, 100 )
		playdate.wait( 1000 )
		gfx.clear()
		gfx.drawText( "1", 200, 100 )
		playdate.wait( 1000 )
		gfx.clear()
        gfx.drawText( "GO!", 180, 100 )
		playdate.wait( 1000 )
		gfx.clear()
        switchTrans = false
        TurnOnSpawner()
        print("timer started")
		
		-- restore the "real" playdate.update
		playdate.update = saveOffUpdate

	end
		
end

--#endregion

function changeHealth(changeVal)
    health -= changeVal
    if health <= 0 then
        SCENE_MANAGER:switchScene(GameOverScene, returnScore())
    end
end