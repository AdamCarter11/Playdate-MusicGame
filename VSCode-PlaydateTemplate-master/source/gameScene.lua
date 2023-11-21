import "NoteSpawner"
import "scoreDisplay"
import "Player"
import "Pen"
import "WaveSpawner"
import "WallCollider"
import "sceneManager"
import "menuScene"
import "gameOverScene"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('GameScene').extends(gfx.sprite)

-- Starting Positions/Values
local SCREEN_X = 400
local SCREEN_Y = 240
local PADDING = 30
local PLAYER_X_POS = 30
local PLAYER_Y_POS = 120
local PEN_X_POS = PADDING
local PEN_BORDER_Y_MIN = SCREEN_Y - PADDING
local PEN_BORDER_Y_MAX = PEN_BORDER_Y_MIN - 75
local WAVE_LENGTH = 50

function GameScene:init()
	
    createScoreDisplay()

    -- Spawn player
    Player (PLAYER_X_POS, PLAYER_Y_POS)
    -- Enemy(400, 120, 1)
    Player(30, 60, gfx.image.new("Sprites/RightArrow"))
    ABPlayer(30, 150, gfx.image.new("Sprites/AButton"))

    -- Spawn pen (crank controlled character)
    local _pen = Pen (PEN_X_POS, (PEN_BORDER_Y_MAX + PEN_BORDER_Y_MIN)/2, 1, PEN_BORDER_Y_MAX, PEN_BORDER_Y_MIN)

    -- Spawn the wave from the right of the screen
    local _waveSpawner = WaveSpawner (SCREEN_X, (PEN_BORDER_Y_MAX + PEN_BORDER_Y_MIN)/2, WAVE_LENGTH, 0, 2 * math.pi, 5)
    --WaveSpawner (SCREEN_X + 10, (PEN_BORDER_Y_MAX + PEN_BORDER_Y_MIN)/2 + 100, WAVE_LENGTH, 0, 2 * math.pi, 5)

    ------previous tests for waveSpawner
    --WaveSpawner (200, 120, WAVE_LENGTH, math.abs(PEN_BORDER_Y_MAX- PEN_BORDER_Y_MIN), math.abs(PEN_BORDER_Y_MAX- PEN_BORDER_Y_MIN), 2)
    --WaveSpawner (0, 160, WAVE_LENGTH, (PEN_BORDER_Y_MAX - PEN_BORDER_Y_MIN), (PEN_BORDER_Y_MAX- PEN_BORDER_Y_MIN), 2)
    --gfx.drawLine(200, 120, 300, 200)
    ------

    -- Compare between the 2 game objects
    --isBetweenRange(_pen, _waveSpawner)

    startSpawner()

    self:add()
end

function GameScene.update()

    gfx.sprite.update()
	if pd.buttonJustPressed(pd.kButtonA) then
        SCENE_MANAGER:switchScene(GameOverScene, "Score: 10")
    end
end

--#region == Helper Functions ==
-- isBetweenRange()
-- Gets the current waves' y positions at the Pen's x-point and returns true
-- if the player's Pen is in the y-range
function isBetweenRange(penObject, waveObject)
    local inRange = false
    local yMin, yMax = waveObject.getCurrentYRange()
    if penObject.y > yMin and penObject.y < yMax then
        print("in range")
        return true
    end
    return inRange
end
--#endregion