JoyousSpring = {}

JoyousSpring.config = SMODS.current_mod.config

assert(SMODS.current_mod.lovely,
    "Lovely modules were not loaded.\nMake sure your JoyousSpring folder is not nested (there should be a bunch of files in the JoyousSpring folder and not just another folder).")

local debug = SMODS.load_file("debug.lua")
if debug then
    debug()
end
assert(SMODS.load_file("src/utils.lua"))()
assert(SMODS.load_file("src/mod_info.lua"))()
assert(SMODS.load_file("src/globals.lua"))()
assert(SMODS.load_file("src/general_ui.lua"))()
assert(SMODS.load_file("src/card_ui.lua"))()
assert(SMODS.load_file("src/extra_deck.lua"))()
assert(SMODS.load_file("src/graveyard.lua"))()
assert(SMODS.load_file("src/banishment.lua"))()
assert(SMODS.load_file("src/pendulum.lua"))()
assert(SMODS.load_file("src/summon.lua"))()
assert(SMODS.load_file("src/monsters.lua"))()
assert(SMODS.load_file("src/effects.lua"))()
assert(SMODS.load_file("src/custom_pool.lua"))()

-- Jokers

local joker_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "src/jokers")
for _, file in ipairs(joker_src) do
    if JoyousSpring.dev_content or (tonumber(file:sub(1, 2)) <= 17) or (tonumber(file:sub(1, 2)) == 19) or (tonumber(file:sub(1, 2)) == 20) or (tonumber(file:sub(1, 2)) == 21) or (tonumber(file:sub(1, 2)) == 99) then
        sendInfoMessage("Loading " .. file, "JoyousSpring")
        assert(SMODS.load_file("src/jokers/" .. file))()
    end
end

-- Others

local others_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "src/others")
for _, file in ipairs(others_src) do
    sendInfoMessage("Loading " .. file, "JoyousSpring")
    assert(SMODS.load_file("src/others/" .. file))()
end
