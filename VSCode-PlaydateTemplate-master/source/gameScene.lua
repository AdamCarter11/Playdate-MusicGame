
import "NoteSpawner"
import "scoreDisplay"
import "Player"
import "sceneManager"
import "menuScene"
import "gameOverScene"

local pd <const> = playdate;
local gfx <const> = pd.graphics;


class('GameScene').extends(gfx.sprite)


function GameScene:init()
	
    createScoreDisplay()
    Player(30, 120)
    -- Enemy(400, 120, 1)
    startSpawner()

    self:add()
end





function GameScene.update()

	if pd.buttonJustPressed(pd.kButtonA) then
        SCENE_MANAGER:switchScene(GameOverScene, "Score: 10")
    end

end
