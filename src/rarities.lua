SMODS.Rarity {
    key = "Epic",
    loc_txt = {
        name = "Epic"
    },
    default_weight = 0.03,
    badge_colour = HEX("b26cbb"), -- purple, may change
    get_weight = function(self, weight, object_type)
        return weight
    end
}

SMODS.Rarity {
    key = "Unobtainable",
    loc_txt = {
        name = "Unobtainable"
    },
    default_weight = 0,
    badge_colour = HEX("000000"), -- black
    get_weight = function(self, weight, object_type)
        return weight
    end
}

SMODS.Rarity {
    key = "Iconic",
    loc_txt = {
        name = "Iconic"
    },
    default_weight = 0.01,
    badge_colour = HEX("3f91c0"), -- blue
    get_weight = function(self, weight, object_type)
        return weight
    end
}

-- try to find a way to merge this rarity with Cryptid's Epic if both mods are installed for compatibility
-- what are the odds i add more
-- if i do add more, name list:
-- Mythical (between legendary and epic)
-- Uncommoner (between uncommon and rare)
-- Slightly Less Common (between common and uncommon)
-- Ultra Common (between common and slightly less common)