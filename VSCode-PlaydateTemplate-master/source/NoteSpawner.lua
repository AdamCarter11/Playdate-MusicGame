import "Note"

-- used to make this a "class" accessible from wherever you are requiring it
--Spawner = {}

local pd <const> = playdate
local gfx <const> = pd.graphics

class('NoteSpawner').extends()

local spawnTimer
local seqCounter = 0
local whichNoteSeq = math.random(1,4)
local canSpawn = true

function startSpawner()
    print("start spawner")
    math.randomseed(pd.getSecondsSinceEpoch())
    createTimer()
end

function createTimer()
    local spawnTime = math.random(2000,2500) -- this is basically the bpm
    spawnTimer = pd.timer.performAfterDelay(spawnTime, function ()
        createTimer()
        if(canSpawn) then
            spawnNote()
        end
    end)
end

function spawnNote()
    -- 1 is 1-4, 2 is 5-8, 3 is 9-12, 4 is 13-16
    if(seqCounter >= 4) then
        whichNoteSeq = math.random(1,4)
        seqCounter = 0
    end

    Note(4, whichNoteSeq)
    seqCounter += 1
end

function stopSpawner()
    if spawnTimer then
        spawnTimer:remove()
    end
end

function TurnOffSpawner()
    canSpawn = false
end

function TurnOnSpawner()
    canSpawn = true
end

function testPrint()
    print("hello")
end