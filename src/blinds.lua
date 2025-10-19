SMODS.Blind {
    key = 'barrier',
    loc_txt = {
        name = "The Barrier",
        text = {
            "Larger blind",
            "-1 discard"
        }
    },
    atlas = 'Blinds',
    pos = {
        x = 0,
        y = 0
    },
    boss_colour = HEX('22b14c'),
    mult = 3,
    dollars = 5,
    boss = {
        min = 3
    },
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                blind.discards_sub = 1
                ease_discard(-blind.discards_sub)
            end
        end
    end,
    disable = function(self)
        ease_hands_played(G.GAME.blind.hands_sub)
    end
}

SMODS.Blind {
    key = 'line',
    loc_txt = {
        name = "The Line",
        text = {
            "-1 hand",
        }
    },
    atlas = 'Blinds',
    pos = {
        x = 0,
        y = 1
    },
    boss_colour = HEX('ff7f27'),
    mult = 2,
    dollars = 5,
    boss = {
        min = 2
    },
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind and G.GAME.round_resets.hands > 1 then
                ease_hands_played(-1)
            end
        end
    end,
}

SMODS.Blind {
    key = 'prediction',
    loc_txt = {
        name = "The Prediction",
        text = {
            "Debuff cards NOT played this ante",
        }
    },
    atlas = 'Blinds',
    pos = {
        x = 0,
        y = 2
    },
    boss_colour = HEX('ffa900'),
    mult = 2,
    dollars = 5,
    boss = {
        min = 3
    },
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_card and context.debuff_card.area ~= G.jokers and not context.debuff_card.ability.played_this_ante then
                return {
                    debuff = true
                }
            end
        end
    end
}

SMODS.Blind {
    key = 'warp',
    loc_txt = {
        name = "The Warp",
        text = {
            "Debuff prime cards",
        }
    },
    atlas = 'Blinds',
    pos = {
        x = 0,
        y = 3
    },
    boss_colour = HEX('c128c3'),
    mult = 2,
    dollars = 5,
    boss = {
        min = 1
    },
    calculate = function(self, card, context)
        if context.debuff_card and (context.debuff_card:get_id() == 2 or context.debuff_card:get_id() == 3 or context.debuff_card:get_id() == 5 or context.debuff_card:get_id() == 7 or context.debuff_card:get_id() == 14) then
            return {
                debuff = true
            }
        else
            return {
                debuff = false
            }
        end
    end
}

SMODS.Blind {
    key = 'splash',
    loc_txt = {
        name = "The Splash",
        text = {
            "Destroy unscored cards"
        }
    },
    atlas = 'Blinds',
    pos = {
        x = 0,
        y = 4
    },
    boss_colour = HEX('5fcfe7'),
    mult = 2,
    dollars = 5,
    boss = {
        min = 2
    },
    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == "unscored" then
            return {
                remove = true
            }
        end
    end
}

SMODS.Blind {
    key = 'blankwhite',
    loc_txt = {
        name = "Blank White",
        text = {
            "Debuff cards with enhancements"
        }
    },
    atlas = 'Blinds',
    pos = {
        x = 0,
        y = 6
    },
    boss_colour = HEX('D4E3E5'),
    mult = 2,
    dollars = 8,
    boss = { 
        showdown = true 
    },
    calculate = function(self, card, context)
        if context.debuff_card then
            if (function()
                local enhancements = SMODS.get_enhancements(context.debuff_card)
                for k, v in pairs(enhancements) do
                    if v then
                        return true
                    end
                end
                return false
            end)() then
                return {
                    debuff = true
                }
            end
        end
    end
}