-- === CONFIG ===
local validIDs = {
    ["alpha1"] = true,
    ["beta2"] = true,
    ["gamma3"] = true
}
local outputSide = "right" -- side with door
local attempts = 0
local maxAttempts = 3
local locked = false
-- === FUNCTIONS ===
local function clear()
    term.clear()
    term.setCursorPos(1,1)
end
local function center(text, y)
    local w, h = term.getSize()
    term.setCursorPos(math.floor((w - #text)/2)+1, y)
    term.write(text)
end
local function openDoor()
    redstone.setOutput(outputSide, true)
    sleep(4) -- door open time
    redstone.setOutput(outputSide, false)
end
-- === MAIN LOOP ===
while true do
    clear()

    if locked then
        center("ACCESS LOCKED", 5)
        center("Security cooldown...", 7)
        sleep(10)
        attempts = 0
        locked = false
    else
        center("== Facility Access ==", 3)
        term.setCursorPos(1,5)
        write("Enter ID: ")

        local input = read("*") -- hidden input

        if validIDs[input] then
            clear()
            center("ACCESS GRANTED", 5)

            openDoor()
            attempts = 0
        else
            attempts = attempts + 1

            clear()
            center("ACCESS DENIED", 5)
            sleep(2)

            if attempts >= maxAttempts then
                locked = true
            end
        end
    end
end
