local pd <const> = playdate
local gfx <const> = pd.graphics

local scoreSprite
local streakSprite
local score
local streak = 0

function createScoreDisplay()
    scoreSprite = gfx.sprite.new()
    score = 0
    streakSprite = gfx.sprite.new()
    streak = 0
    updateDisplay()
    scoreSprite:setCenter(0,0)
    scoreSprite:moveTo(280,4)
    scoreSprite:add()

    streakSprite:setCenter(0,0)
    streakSprite:moveTo(50,4)
    streakSprite:add()
end

function updateDisplay()
    local scoreText = "Score: " .. score
    local textWidth, textHeight = gfx.getTextSize(scoreText)
    local scoreImage = gfx.image.new(textWidth, textHeight)

    local streakText = "Streak: " .. streak
    local textWidth, textHeight = gfx.getTextSize(streakText)
    local streakImage = gfx.image.new(textWidth, textHeight)

    gfx.pushContext(scoreImage)
    gfx.drawText(scoreText, 0, 0)
    gfx.popContext()

    gfx.pushContext(streakImage)
    gfx.drawText(streakText,0,0)
    gfx.popContext()
    
    scoreSprite:setImage(scoreImage)
    streakSprite:setImage(streakImage)

    
end

function incrementScore(amount)
    if (streak < 5) then
        score += amount
    end
    if (streak >= 5) then
        score += (amount * 2)
    end
    if (streak >= 5) then
        score += (amount * 3)
    end
    
    updateDisplay()
end

function addStreak()
    streak += 1
    print("Streak: " .. streak)
    updateDisplay()
end
function resetStreak()
    streak = 0
    updateDisplay()
end

function resetScore()
    score = 0
    updateDisplay()
end
function returnScore()
    return score
end

function addWaveScore()
    score += 1
end