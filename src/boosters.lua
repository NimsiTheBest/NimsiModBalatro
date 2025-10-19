SMODS.Booster {
    key = 'nimsi_pack',
    loc_txt = {
        name = "Nimsi Pack",
        text = {
            "Choose 1 of up to 2",
            "Nimsi Mod jokers"
        },
        group_name = "nimsi_nimsi_mod"
    },
    config = { 
        extra = 2, 
        choose = 1 
    },
    atlas = "CustomBoosters",
    pos = { 
        x = 0, 
        y = 0 
    },
    kind = 'Joker',
    group_key = "nimsi_nimsi_mod",
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        return {
            set = "Joker",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("7ed321"))
        ease_background_colour({ new_colour = HEX('7ed321'), special_colour = HEX("3b7505"), contrast = 2 })
    end,
    particles = function(self)
        -- No particles for joker packs
    end,
}

SMODS.Booster {
    key = 'nimsi_pack_2',
    loc_txt = {
        name = "Nimsi Pack",
        text = {
            "Choose 1 of up to 2",
            "Nimsi Mod jokers"
        },
        group_name = "nimsi_nimsi_mod"
    },
    config = { 
        extra = 2, 
        choose = 1 
    },
    atlas = "CustomBoosters",
    pos = { 
        x = 1, 
        y = 0 
    },
    kind = 'Joker',
    group_key = "nimsi_nimsi_mod",
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        return {
            set = "Joker",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("7ed321"))
        ease_background_colour({ new_colour = HEX('7ed321'), special_colour = HEX("3b7505"), contrast = 2 })
    end,
    particles = function(self)
        -- No particles for joker packs
    end,
}

SMODS.Booster {
    key = 'jumbo_nimsi_pack',
    loc_txt = {
        name = "Jumbo Nimsi Pack",
        text = {
            "Choose 2 of up to 4",
            "Nimsi Mod jokers"
        },
        group_name = "nimsi_nimsi_mod"
    },
    config = { 
        extra = 4, 
        choose = 2
    },
    atlas = "CustomBoosters",
    pos = { 
        x = 2, 
        y = 0 
    },
    cost = 6,
    atlas = "CustomBoosters",
    pos = { x = 1, y = 0 },
    kind = 'Joker',
    group_key = "nimsi_mod",
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        return {
            set = "Joker",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("7ed321"))
        ease_background_colour({ new_colour = HEX('7ed321'), special_colour = HEX("3b7505"), contrast = 2 })
    end,
    particles = function(self)
        -- No particles for joker packs
    end,
}

SMODS.Booster {
    key = 'hyper_nimsi_pack',
    loc_txt = {
        name = "Hyper Nimsi Pack",
        text = {
            "Choose 3 of up to 9",
            "Nimsi Mod jokers"
        },
        group_name = "nimsi_mod"
    },
    config = { 
        extra = 9, 
        choose = 3 
    },
    atlas = "CustomBoosters",
    pos = { 
        x = 3, 
        y = 0 
    },
    cost = 11,
    kind = 'Joker',
    group_key = "nimsi_mod",
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        return {
            set = "nimsi_mod",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("7ed321"))
        ease_background_colour({ new_colour = HEX('7ed321'), special_colour = HEX("3b7505"), contrast = 2 })
    end,
    particles = function(self)
        -- No particles for joker packs
    end,
}

SMODS.Booster {
    key = 'iconic_pack',
    loc_txt = {
        name = "Iconic Pack",
        text = {
            "Choose {C:attention}1{} of up to {C:attention}5{}",
            "Iconic Jokers"
        },
        group_name = "nimsi_boosters"
    },
    config = { 
        extra = 5, 
        choose = 1 },
    cost = 10,
    atlas = "CustomBoosters",
    pos = {
        x = 0, 
        y = 1
    },
    group_key = "nimsi_boosters",
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        return {
        set = "Joker",
        rarity = "Iconic",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
        }
    end,
    particles = function(self)
        -- No particles for joker packs
    end,
}
