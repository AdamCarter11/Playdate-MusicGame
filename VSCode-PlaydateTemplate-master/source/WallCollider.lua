import "CoreLibs/graphics"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('WallCollider').extends(gfx.sprite)

function WallCollider:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self:moveTo(x, y)
    print("wall init")

    self:setCollideRect(0,0,self:getSize())
    self:add()
end

function WallCollider:DrawLine()
    local line = gfx.image.new(400, 240)
    gfx.pushContext(line)
        gfx.drawRect(self.x, self.y, self.width, self.height)

    gfx.popContext()
    self:setImage(line)
end

function WallCollider:update()
    self:DrawLine()
end

