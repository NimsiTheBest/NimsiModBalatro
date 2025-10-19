
SMODS.Back{
    name = "Rainbow Deck",
    key = "rainbow",
    atlas = 'Decks',
    pos = {
        x = 0, 
        y = 0
    },
    config = { 
        hand_size = -3,
        discards = 1,
        hands = 1, 
        joker_slot = 1 
    },
    loc_txt = {
        name = "Rainbow Deck",
        text ={
            "{C:attention}-3{} hand size, {C:attention}+1{} discard,",
            " {C:attention}+1{} hand per round, {C:attention}+1{} joker slot"
        },
    },
}

-- bootleg green deck
SMODS.Back{
    name = "Antired Deck",
    key = "antired",
    atlas = 'Decks',
    pos = {
        x = 1, 
        y = 0
    },
    config = { 
        discards = 3,
        extra_discard_bonus = 1
    },
    loc_txt = {
        name = "Antired Deck",
        text ={
            "{C:attention}+3{} discards, start with",
            "earn $1 per unused discard"
        },
    },
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and G.GAME.blind.boss  then
            if G.hand.config.card_limit > 7 then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(card.ability.extra.hand_size).."-1 Hand Size", colour = G.C.RED})
                G.hand:change_size(-card.ability.extra.hand_size)
                return true
            end
                }
            end
        end
    end
}

-- built in turtle bean
SMODS.Back{
    name = "Antiblue Deck",
    key = "antiblue",
    atlas = 'Decks',
    pos = {
        x = 2, 
        y = 0
    },
    config = { 
        hand_size = 5,
    },
    loc_txt = {
        name = "Antiblue Deck",
        text ={
            "{C:attention}+5{} hand size, lose 1",
            "hand size after every {C:attention}Boss Blind{}"
        },
    },
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and G.GAME.blind.boss  then
            if G.hand.config.card_limit > 7 then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(card.ability.extra.hand_size).."-1 Hand Size", colour = G.C.RED})
                G.hand:change_size(-card.ability.extra.hand_size)
                return true
            end
                }
            end
        end
    end
}

-- the idea is to use credit card to go into debt then use the ox to get out of it
-- it sets money to $0, so if you go into negative, you're freed of debts!

SMODS.Back {
    name = "Antiyellow Deck",
    key = "antiyellow",
    atlas = 'Decks',
    pos = {
        x = 3, 
        y = 0
    },
    loc_txt = {
        name = "Antiyellow Deck",
        text ={
            "Start with Eternal Negative copies of",
            "Credit Card and The Ox",
        },
    },
    apply = function(self)
            G.E_MANAGER:add_event(Event({
                func = function()
                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_credit_card' })
                    if joker_card then
                        joker_card:set_edition("e_negative", true)
                        joker_card:add_sticker('eternal', true)
                    end
                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_nimsi_the_ox' })
                    if joker_card then
                        joker_card:set_edition("e_negative", true)
                        joker_card:add_sticker('eternal', true)
                    end
                    return true
                end
            }))
    end
}

-- bad earlygame eco, better lategame
-- will probably suck ass on red stake and higher

SMODS.Back {
    name = "Antigreen Deck",
    key = "antigreen",
    atlas = 'Decks',
    pos = {
        x = 4, 
        y = 0
    },
    loc_txt = {
        name = "Antigreen Deck",
        text ={
            "Start with Eternal Negative To the Moon.",
            "No money from remaining hands"
        },
    },
    rules = {
        custom = {
            { id = 'no_extra_hand_money' },
        }
    },
    apply = function(self)
            G.E_MANAGER:add_event(Event({
                func = function()
                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_to_the_moon' })
                    if joker_card then
                        joker_card:set_edition("e_negative", true)
                        joker_card:add_sticker('eternal', true)
                    end
                    return true
                end
            }))
    end
}

-- reverse black deck that's stronger early but weaker late
SMODS.Back {
    name = "Antiblack Deck",
    key = "antiblack",
    atlas = 'Decks',
    pos = {
        x = 5, 
        y = 0
    },
    config = { 
        hands = 2, 
        joker_slot = -1
    },
    loc_txt = {
        name = "Antiblack Deck",
        text ={
            "+2 hands, -1 joker slot",
        },
    },
}

SMODS.Back {
    name = "Wooden Deck",
    key = "woodendeck",
    atlas = 'Decks',
    pos = {
        x = 0, 
        y = 1
    },
    loc_txt = {
        name = "Wooden Deck",
        text ={
            'Start with {C:attention}Eternal Wooden Pickaxe{}',
            'and {C:attention}2x The Magician{}',
        },
    },
    config = { 
        consumables = { 
            'c_magician', 
            'c_magician'
        } 
    },
    loc_vars = function(self, info_queue, back)
        return {
            vars = {
                localize { 
                    type = 'name_text', 
                    key = self.config.consumables[1], 
                    set = 'Tarot' 
                }
            }
        }
    end,
    apply = function(self)
            G.E_MANAGER:add_event(Event({
                func = function()
                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_nimsi_woodenpickaxe' })
                    if joker_card then
                        joker_card:set_edition("e_negative", true)
                        joker_card:add_sticker('eternal', true)
                    end
                    return true
                end
            }))
    end
}
-- FUCK IT WE BALL

SMODS.Back {
    name = "Nimsi's Deck",
    key = "nimsideck",
    atlas = 'Decks',
    pos = {
        x = 6, 
        y = 0
    },
    config = {  
        joker_slot = -4
    },
    loc_txt = {
        name = "Nimsi's Deck",
        text = {
            "Start with {C:attention}Eternal Negative Nimsi{}",
            "{C:attention}-4 Joker slots{}, but starting deck",
            "is {C:attention}full of oddities{}",
        },
    },
    apply = function(self)
            G.E_MANAGER:add_event(Event({
                func = function()
                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_nimsi_nimsijoker' })
                    if joker_card then
                        joker_card:set_edition("e_negative", true)
                        joker_card:add_sticker('eternal', true)
                    end
                    for i = #G.playing_cards, 1, -1 do
                        if G.playing_cards[i]:get_id() == 2 then
                            G.playing_cards[i]:set_ability(G.P_CENTERS.m_stone)
                        end
                        if G.playing_cards[i]:get_id() == 12 then
                            G.playing_cards[i]:set_edition("e_polychrome", true)
                        end
                        if G.playing_cards[i]:is_suit("Spades") then
                            G.playing_cards[i]:set_seal("Red", true)
                        end
                        if G.playing_cards[i]:get_id() == 14 then
                            G.playing_cards[i]:set_seal("Gold", true)
                        end
                    end
                    return true
                end
            }))
    end
}

SMODS.Back {
    name = "Mystic Deck",
    key = "mysticdeck",
    atlas = 'Decks',
    pos = {
        x = 1, 
        y = 1
    },
    loc_txt = {
        name = "Mystic Deck",
        text ={
            "Start with {C:attention}Omen Globe{}",
            "{C:attention}Illusion{} and {C:attention}Observatory{}",
            "-1 hand size, -1 joker slot"
        },
    },
    config = { 
        vouchers = { 
            'v_crystal_ball', 
            'v_omen_globe', 
            'v_telescope',
            'v_observatory', 
            'v_magic_trick', 
            'v_illusion'
        }, 
        hand_size = -1, 
        joker_slot = -1 
    },
}

SMODS.Back {
    name = "Voucher Deck",
    key = "voucher",
    atlas = 'Decks',
    pos = {
        x = 2, 
        y = 1
    },
    loc_txt = {
        name = "Voucher Deck",
        text ={
            "Shop has 2 vouchers instead of 1",
        },
    },    
    apply = function(self)
		SMODS.change_voucher_limit(1)
    end
}