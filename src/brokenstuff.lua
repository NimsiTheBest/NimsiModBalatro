--- i throw stuff that doesnt work here for when i get off my lazy ass and fix it


SMODS.Blind { doesnt work fn so instead of fixing it it is sent to COMMENT HELL
    key = 'line',
    loc_txt = {
        name = "The Line",
        text = {
            "After discarding, discard 2 random cards",
        }
    },
    atlas = 'Blinds',
    pos = {
        x = 0,
        y = 1
    },
    boss_colour = HEX('ff7f27'),
    mult = 3,
    dollars = 5,
    boss = {
        min = 4
    }
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.press_discard then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local any_selected = nil
                        local _cards = {}
                        for _, playing_card in ipairs(G.hand.cards) do
                            _cards[#_cards + 1] = playing_card
                        end
                        for i = 1, 2 do
                            if G.hand.cards[i] then
                                local selected_card, card_index = pseudorandom_element(_cards, 'vremade_hook')
                                G.hand:add_to_highlighted(selected_card, true)
                                table.remove(_cards, card_index)
                                any_selected = true
                                play_sound('card1', 1)
                            end
                        end
                        if any_selected then G.FUNCS.discard_cards_from_highlighted(nil, true) end
                        return true
                    end
                }))
                blind.triggered = true
                delay(0.7)
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = (function()
                        SMODS.juice_up_blind()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound('tarot2', 0.76, 0.4); return true
                            end
                        }))
                        play_sound('tarot2', 1, 0.4)
                        return true
                    end)
                }))
                delay(0.4)
            end
        end
    end
}

SMODS.Blind {
    key = "prediction",
    loc_txt = {
        name = "The Prediction",
        text = {
            "Playing a #1#",
            "sets its level to 0",
        }
    },
    dollars = 5,
    mult = 2,
    pos = { 
        x = 0, 
        y = 2 
    },
    boss = { 
        min = 6 
    },
    boss_colour = HEX("b95b08"),
    loc_vars = function(self)
        return { vars = { localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands') } }
    end,
    collection_loc_vars = function(self)
        return { vars = { localize('ph_most_played') } }
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_hand then
                blind.triggered = false
                if context.scoring_name == G.GAME.current_round.most_played_poker_hand then
                    blind.triggered = true
                    if not context.check then
                        local mostplayedhandlevel = (function() local most_played = 0; local most_played_hand = ''; for hand, data in pairs(G.GAME.hands) do if data.played > most_played then most_played = data.played; most_played_hand = hand end end; return most_played_hand ~= '' and G.GAME.hands[most_played_hand].level or 0 end)(),
                        level_up = -(mostplayedhandlevel - 1)
                    end
                end
            end
        end
    end
}

-- analgyh deck on crack
SMODS.Back {
    key = "edited",
    pos = { 
        x = 7, 
        y = 0 
    },
    loc_txt = {
        name = "Edited Deck",
        text = {
            "Start with 4 of every edition tag",
        },
    },
    loc_vars = function(self, info_queue, back)
        return { 
            vars = { 
                localize { 
                    type = 'name_text', 
                    key = 'tag_foil', 
                    set = 'Tag' 
                }, 
                localize { 
                    type = 'name_text', 
                    key = 'tag_holo', 
                    set = 'Tag' 
                },
                localize { 
                    type = 'name_text', 
                    key = 'tag_polychrome', 
                    set = 'Tag' 
                },
                localize { 
                    type = 'name_text', 
                    key = 'tag_negative', 
                    set = 'Tag' 
                } 
            }
        }
    end,
    config = { 
        tag = {
            'tag_foil',
            'tag_holo', 
            'tag_polychrome',
            'tag_negative'
        }
    },
}
