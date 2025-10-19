SMODS.Challenge { -- The Long Game
    key = 'the_long_game',
    loc_txt = {
        name = 'The Long Game',
        text = {
            'All Blinds give no reward money',
            'Extra Hands no longer earn money',
            'Earn no Interest at end of round',
        }
    },
    rules = {
        custom = {
            { id = 'no_reward' },
            { id = 'no_extra_hand_money' },
            { id = 'no_interest' },
        }
    },
    jokers = {
        { id = 'j_nimsi_banker', eternal = true, edition = "negative" },
        { id = 'j_nimsi_banker', eternal = true, edition = "negative" },
    },
    restrictions = {
        banned_cards = {
            { id = 'v_seed_money' },
            { id = 'v_money_tree' },
            { id = 'j_to_the_moon' },
            { id = 'j_rocket' },
            { id = 'j_golden' },
            { id = 'j_satellite' },
            { id = 'j_cloud_9' },
            { id = 'j_delayed_grat' },
            { id = 'j_rough_gem' },
            { id = 'j_nimsi_wrench' },
            { id = 'j_nimsi_mochimiles' },
        }
    }
}

SMODS.Challenge { -- Needles, Oxes, Teeth and Mannacles
    key = 'all_bosses',
    loc_txt = {
        name = 'Needles, Oxes, Teeth and Mannacles',
    },
    jokers = {
        { id = 'j_nimsi_the_ox', eternal = true, edition = "negative" },
        { id = 'j_nimsi_the_tooth', eternal = true, edition = "negative" },
        { id = 'j_nimsi_the_mannacle', eternal = true},
        { id = 'j_nimsi_the_needle', eternal = true},
    },
    banned_other = {
        { id = 'bl_ox', type = 'blind' },
        { id = 'bl_tooth', type = 'blind' },
        { id = 'bl_manacle', type = 'blind' },
        { id = 'bl_needle', type = 'blind' },
    }
}

SMODS.Challenge { -- Too Much Stuff
    key = 'too_much_stuff',
    loc_txt = {
        name = 'Too Much Stuff',
    },
    jokers = {
        { id = 'j_nimsi_stickman', eternal = true, edition = "negative" },
        { id = 'j_nimsi_stickman', eternal = true, edition = "negative" },
        { id = 'j_nimsi_stickman', eternal = true, edition = "negative" },
    },
    restrictions = {
        banned_cards = {
            { id = 'j_hologram' },
            { id = 'j_stone' },
            { id = 'j_trading' },
        }
    }
}

SMODS.Challenge { -- Abosolute Cinema
    key = 'slime_rancher_glazing',
    loc_txt = {
        name = 'Abosolute Cinema',
        text = {
            'All Blinds give no reward money',
            'Extra Hands no longer earn money',
            'Earn no Interest at end of round',
            'Slime Rancher is such a fire game go play it (please)'
        }
    },
    rules = {
        custom = {
            { id = 'no_reward' },
            { id = 'no_extra_hand_money' },
            { id = 'no_interest' },
        }
    },
    jokers = {
        { id = 'j_nimsi_mochimiles', eternal = true, edition = "negative" },
        { id = 'j_nimsi_honeyhunterslime', eternal = true,},
    },
    restrictions = {
        banned_cards = {
            { id = 'v_seed_money' },
            { id = 'v_money_tree' },
            { id = 'j_to_the_moon' },
            { id = 'j_rocket' },
            { id = 'j_golden' },
            { id = 'j_satellite' },
            { id = 'j_cloud_9' },
            { id = 'j_delayed_grat' },
            { id = 'j_rough_gem' },
            { id = 'j_nimsi_wrench' },
        }
    }
}

SMODS.Challenge { -- Nuzlocke
    key = 'nuzlocke',
    loc_txt = {
        name = 'Nuzlocke',
        text = {
            'No rerolls',
            'No skipping blinds',
            'No vouchers',
            'Jokers cannot be duplicated',
        }
    },
    rules = {
        custom = {
            { id = 'disable_rerolls' },
            { id = 'disable_skipping'},
            { id = "all_singular_jokers" },
            { id = "no_vouchers" },
        }
    },
    restrictions = {
        banned_cards = {
            -- reroll stuff
            { id = 'j_flash' },
            { id = 'j_chaos' },
            -- skipping stuff
            { id = 'j_throwback' },
            -- voucher stuff
            { id = 'j_nimsi_happyplant' },
            -- duplication stuff
            { id = 'j_invisible' },
            { id = 'j_ring_master' },
            -- may add blueprint and brainstorm, since they aren't technically duplication effects but they feel like they are
        }
    }
}

SMODS.Challenge { -- Hardcore Nuzlocke
    key = 'hardcore_nuzlocke',
    loc_txt = {
        name = 'Hardcore Nuzlocke',
        text = {
            'No rerolls',
            'No skipping blinds',
            'No vouchers',
            'Jokers cannot be duplicated',
            'Cannot hold consumables',
            'Win at Ante 10'
        }
    },
    rules = {
        custom = {
            { id = 'disable_rerolls' },
            { id = 'disable_skipping'},
            { id = "all_singular_jokers" },
            { id = "no_vouchers" },
            { id = "win_ante", value = 10 }
        },
        modifiers = {
            { id = 'consumable_slots', value = 0 },
        }
    },
    restrictions = {
        banned_cards = {
            -- reroll stuff
            { id = 'j_flash' },
            { id = 'j_chaos' },
            -- skipping stuff
            { id = 'j_throwback' },
            -- voucher stuff
            { id = 'j_nimsi_happyplant' },
            -- duplication stuff
            { id = 'j_invisible' },
            { id = 'j_ring_master' },
            -- may add blueprint and brainstorm, since they aren't technically duplication effects but they feel like they are
        }
    }
}