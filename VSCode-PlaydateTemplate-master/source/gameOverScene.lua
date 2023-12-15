
import "sceneManager"
import "menuScene"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('GameOverScene').extends(gfx.sprite)

function GameOverScene:init(text)
    resetHealth()
    local backgroundImage = gfx.image.new("Sprites/GameOver")
    local borderImage = gfx.image.new("Sprites/EvenBiggerBoarder")
    local borderImageButBigger = gfx.image.new("Sprites/BiggestBoarder")
    local scoreText = "Score: " .. text
    local pressAText = "Press A To Restart"
    local pressAImage = gfx.image.new(gfx.getTextSize(pressAText))
    local gameOverImage = gfx.image.new(gfx.getTextSize(scoreText))
    gfx.pushContext(gameOverImage)
        gfx.drawText(scoreText, 0, 0)
    gfx.popContext()
    gfx.pushContext(pressAImage)
        gfx.drawText(pressAText, 0, 0)
    gfx.popContext()
    

    local backgroundSprite = gfx.sprite.new(backgroundImage)
    backgroundSprite:moveTo(200,120)
    backgroundSprite:add()

    local borderSprite = gfx.sprite.new(borderImage)
    borderSprite:moveTo(200,100)
    borderSprite:add()
    
    local borderSprite2 = gfx.sprite.new(borderImageButBigger)
    borderSprite2:moveTo(200,140)
    borderSprite2:add()

    local gameOverSprite = gfx.sprite.new(gameOverImage)
    gameOverSprite:moveTo(200,100)
    gameOverSprite:add()
    
    local pressASprite = gfx.sprite.new(pressAImage)
    pressASprite:moveTo(200,140)
    pressASprite:add()
    

    self:add()

end

function GameOverScene.update()
    if pd.buttonJustPressed(pd.kButtonA) then
        SCENE_MANAGER:switchScene(MenuScene)
    end
end

