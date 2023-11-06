import "Note"

local pd <const> = playdate
local gfx <const> = pd.graphics

local spawnTimer
local seqCounter = 0
local whichNoteSeq = math.random(1,4)

function startSpawner()
    math.randomseed(pd.getSecondsSinceEpoch())
    createTimer()
end

function createTimer()
    local spawnTime = math.random(2000,2500) -- this is basically the bpm
    spawnTimer = pd.timer.performAfterDelay(spawnTime, function ()
        createTimer()
        spawnNote()
    end)
end

function spawnNote()
    -- 1 is 1-4, 2 is 5-8, 3 is 9-12, 4 is 13-16
    if(seqCounter >= 4) then
        whichNoteSeq = math.random(1,4)
        seqCounter = 0
    end

    Note(2, whichNoteSeq)
    seqCounter += 1
end

function stopSpawner()
    if spawnTimer then
        spawnTimer:remove()
    end
end
