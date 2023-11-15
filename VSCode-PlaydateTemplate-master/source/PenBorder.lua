import "CoreLibs/graphics"
local pd <const> = playdate
local gfx <const> = pd.graphics

class('PenBorder').extends(gfx.sprite)

function PenBorder:init(x, y, length, startAng, endAng, speed)
    --playdate.graphics.drawArc(x, y, radius, startAngle, endAngle)
    gfx.setColor(gfx.kColorBlack)
    -- gfx.drawArc(x, y, length, math.pi/2, math.pi)

    --playdate.graphics.drawSineWave(startX, startY, endX, endY, 
    --  startAmplitude, endAmplitude, period, [phaseShift])
    -- startAng = startAmplitude
    -- endAng = endAmplitude
    -- speed = period
    -- NOTE: phaseShift might be interesting for variation
    -- NOTE: length/#, where # can be a peak or valley in regards to tempo
    
    -- local test = gfx.drawSineWave(50, 120, 300, 120, 45, 90, 5)
    self:DrawWave()
    self.speed = speed
    self:moveTo(200,120)
    print("boarder init")
    self:add()
end

function PenBorder:DrawWave()
    local testSprite = gfx.image.new(400, 240)
    gfx.pushContext(testSprite)
        --gfx.fillRoundRect(0, 0, 50, 50, 10)
        -- gfx.drawArc(0, 0, 50, 0, math.pi / 2)
        --gfx.fillRect(0,0,50, 25)
        gfx.drawSineWave(0, 120, 50, 50, 0, 0, 30)
    gfx.popContext()
    self:setImage(testSprite)
end
function PenBorder:update()
    -- self:moveBy(-self.speed, 0)
end

