
import "NoteSpawner"
import "scoreDisplay"
import "Player"
import "Pen"
import "penBorder"
import "sceneManager"
import "menuScene"
import "gameOverScene"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('GameScene').extends(gfx.sprite)

-- Starting Positions
local PLAYER_X_POS = 30
local PLAYER_Y_POS = 120
local PEN_X_POS = 30
local PEN_BORDER_Y_MAX = 55
local PEN_BORDER_Y_MIN = 5
local WAVE_LENGTH = 50

function GameScene:init()
	
    createScoreDisplay()
    Player (PLAYER_X_POS, PLAYER_Y_POS)
    -- Enemy(400, 120, 1)

    Pen (PEN_X_POS, (PEN_BORDER_Y_MAX + PEN_BORDER_Y_MIN)/2, 1)
    --gfx.drawLine(200, 120, 300, 200)
    PenBorder (200, 120, WAVE_LENGTH, (PEN_BORDER_Y_MAX - PEN_BORDER_Y_MIN), (PEN_BORDER_Y_MAX- PEN_BORDER_Y_MIN), 2)

    startSpawner()

    self:add()
end

function GameScene.update()

    gfx.sprite.update()
	if pd.buttonJustPressed(pd.kButtonA) then
        SCENE_MANAGER:switchScene(GameOverScene, "Score: 10")
    end

end
