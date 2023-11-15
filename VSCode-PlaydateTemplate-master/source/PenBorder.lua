local pd <const> = playdate
local gfx <const> = pd.graphics

class('PenBorder').extends(gfx.sprite)

function PenBorder:init(x, y, length, startAng, endAng, speed)
    --playdate.graphics.drawArc(x, y, radius, startAngle, endAngle)
    --gfx.drawArc(x, y, length, math.pi, math.pi)

    --playdate.graphics.drawSineWave(startX, startY, endX, endY, 
    --  startAmplitude, endAmplitude, period, [phaseShift])
    -- startAng = startAmplitude
    -- endAng = endAmplitude
    -- speed = period
    -- NOTE: phaseShift might be interesting for variation
    -- NOTE: length/#, where # can be a peak or valley in regards to tempo
    --gfx.drawSineWave(x, y, x + length, y + length, startAng, endAng, length/3)

    self.x = x
    self.y = y
    self.length = length
    self.startAng = startAng
    self.endAng = endAng
    self.speed = speed

    function PenBorder:draw()
        gfx.drawArc(x, y, length, math.pi, math.pi)
        pushContext()
    end

    self:moveTo(x, y)
    self:add()
end

function PenBorder:update()
    --self:moveBy(-self.speed, 0)
end

