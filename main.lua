-- Atlas stuff
-- From my understanding it only works if they're loaded first
-- Therefore, put them before the files being loaded

SMODS.Atlas{
    key = 'Jokers-1',
    path = 'Jokers-1.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Jokers-2',
    path = 'Jokers-2.png',
    px = 71,
    py = 95
}
-- i have so many joker sprites i have to split them into 2 atlases
-- cant wait for this number to go up

SMODS.Atlas{
    key = 'Decks',
    path = 'Decks.png',
    px = 142,
    py = 190
}

SMODS.Atlas{
    key = 'CustomBoosters',
    path = 'CustomBoosters.png',
    px = 59,
    py = 95
}

SMODS.Atlas{
    key = 'Planets',
    path = 'Planets.png',
    px = 65,
    py = 95
}

SMODS.Atlas({
    key = 'Blinds',
    path = 'Blinds.png',
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
})
-- the loading of 87
-- i dont know if the order matters
-- i just copies from vanilla remade and removed stuff that doesnt exist yet

-- if it works it works

assert(SMODS.load_file("src/jokers.lua"))()
assert(SMODS.load_file("src/decks.lua"))()
assert(SMODS.load_file("src/vouchers.lua"))()
assert(SMODS.load_file("src/consumables.lua"))()
assert(SMODS.load_file("src/challenges.lua"))()
assert(SMODS.load_file("src/rarities.lua"))()
assert(SMODS.load_file("src/stakes.lua"))()
assert(SMODS.load_file("src/blinds.lua"))()
-- assert(SMODS.load_file("src/boosters.lua"))()
-- find a way to add card sleeves when card sleeves mod is installed
-- you have no idea how much i popped off when i got this working FIRST TRY