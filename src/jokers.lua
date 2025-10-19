-- buckle your fuckles this is the biggest file yet
-- it will probably stay that way


SMODS.Joker{ -- Mayhem
    pools = { ["nimsi_nimsi_mod"] = true },
    key = 'mayhem',
    loc_txt = {
        name = 'Mayhem',
        text = {
            '{C:mult}+#2#{} Mult, {C:chips}+#1#{} Chips'
        }
    },
    config = { 
        extra = { 
            mult = 25,
            chips = 150,
        } 
    },
	rarity = 3,
    atlas = 'Jokers-1',
    pos = {x = 0, y = 0},
	cost = 25,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
   	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
	end, 
    calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult_mod = card.ability.extra.mult,
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
				chip_mod = card.ability.extra.chips,
				message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
			}
		end
	end   
}

SMODS.Joker{ -- Nimsi
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "nimsijoker",
    config = {
        extra = {
            buffMultipler = 1,
            discardsremaining = 0,
            handsremaining = 0
        }
    },
    loc_txt = {
        name = 'Nimsi',
        text = {
            'At end of round, gain {C:blue}[remaining Hands]{} Joker slots',
            'and {C:red}[remaining Discards]{} Consumable slots',
            '{C:inactive}(doubled on Boss Blinds){}'
        },
        unlock = {
            'Unlocked by default.'
        }
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    rarity = "nimsi_Epic",
    atlas = 'Jokers-2',
    pos = {
        x = 0, 
        y = 0
    },
	soul_pos = { 
        x = 1, 
        y = 0
    },
    -- words cannot describe how hard the soul_pos stuff was to get working
	cost = 14, -- i think this is the most expensive in the mod? 
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if not (G.GAME.blind.boss) then
                return {
                    func = function()
                G.E_MANAGER:add_event(Event({func = function()
                    G.consumeables.config.card_limit = G.consumeables.config.card_limit + G.GAME.current_round.discards_left
                    return true
                end }))
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Nice!", colour = G.C.GREEN})
                return true
            end,
                    extra = {
                        func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Nicer!", colour = G.C.DARK_EDITION})
                G.jokers.config.card_limit = G.jokers.config.card_limit + G.GAME.current_round.hands_left
                return true
            end,
                        colour = G.C.DARK_EDITION
                        }
                }
            else
                return {
                    func = function()
                G.E_MANAGER:add_event(Event({func = function()
                    G.consumeables.config.card_limit = G.consumeables.config.card_limit + (G.GAME.current_round.discards_left) * 2
                    return true
                end }))
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Nice!", colour = G.C.GREEN})
                return true
            end,
                    extra = {
                        func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Nicer!", colour = G.C.DARK_EDITION})
                G.jokers.config.card_limit = G.jokers.config.card_limit + (G.GAME.current_round.hands_left) * 2
                return true
            end,
                        colour = G.C.DARK_EDITION
                        }
                }
            end
        end
    end
}

SMODS.Joker{ -- Ribombee
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "ribombee",
    config = {
        extra = {
            blind_size = 0.9,
            blind_size2 = 0.75,
            blind_size3 = 0.6,
            blind_size4 = 0.4
        }
    },
    loc_txt = {
        name = 'Ribombee',
        text = {
            'Reduces score goal to:',
            '90% (Small Blind),',
            '75% (Big Blind),',
            '60% (Boss Blind),',
            '40% (Showdown Blind)'
        },
    },
    pos = {
        x = 2,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 9,
    rarity = "nimsi_Epic",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

    calculate = function(self, card, context)
        if context.setting_blind  then
            if G.GAME.blind:get_type() == 'Small' then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "X"..tostring(card.ability.extra.blind_size).." Blind Size", colour = G.C.GREEN})
                G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blind_size
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                G.HUD_blind:recalculate()
                return true
            end
                }
            elseif G.GAME.blind:get_type() == 'Big' then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "X"..tostring(card.ability.extra.blind_size2).." Blind Size", colour = G.C.GREEN})
                G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blind_size2
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                G.HUD_blind:recalculate()
                return true
            end
                }
            elseif G.GAME.blind.config.blind.boss.showdown then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "X"..tostring(card.ability.extra.blind_size2).." Blind Size", colour = G.C.GREEN})
                G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blind_size4
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                G.HUD_blind:recalculate()
                return true
            end
                }
            elseif G.GAME.blind.boss then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "X"..tostring(card.ability.extra.blind_size3).." Blind Size", colour = G.C.GREEN})
                G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blind_size3
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                G.HUD_blind:recalculate()
                return true
            end
                }
            end
        end
    end
}

SMODS.Joker{ --Bronze Candy
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "bronzecandy",
    config = {
        extra = {
            roundsUntilDestruction = 0,
            levels = 1
        }
    },
    loc_txt = {
        ['name'] = 'Bronze Candy',
        ['text'] = {
            'Levels up final {C:attention}poker hand{} of round.',
            '{C:red}Self-destructs{} after 5 rounds',
			"{C:inactive}({C:roundsUntilDestruction}#1#{C:inactive}/5 rounds)"
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 3,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

   	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.roundsUntilDestruction } }
	end, 

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if (card.ability.extra.roundsUntilDestruction or 0) == 5 then
                return {
                    func = function()
                card:start_dissolve()
                return true
            end,
                    message = "yummy!"
                }
            else
                target_hand = context.scoring_name
                return {
                    level_up = card.ability.extra.levels,
      level_up_hand = target_hand,
                    message = localize('k_level_up_ex'),
                    extra = {
                        func = function()
                    card.ability.extra.roundsUntilDestruction = (card.ability.extra.roundsUntilDestruction) + 1
                    return true
                end,
                        colour = G.C.GREEN
                        }
                }
            end
        end
    end
}

SMODS.Joker{ --The Gloves of Diaster
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "theglovesofdiaster",
    config = {
        extra = {
            odds = 4,
            mult = 10,
            mult2 = 10,
            mult3 = 10,
            mult4 = 10
        }
    },
    loc_txt = {
        ['name'] = 'The Gloves of Diaster',
        ['text'] = {
            [1] = 'When card is scored, {C:green}1 in #2#{}',
            [2] = 'to gain {C:red}+#1#{} Mult, rolled {C:attention}four{} times'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
   	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.odds } }
	end, 
    pos = {
        x = 0,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_ab460dd9', 1, card.ability.extra.odds, 'j_modprefix_theglovesofdiaster', false) then
              SMODS.calculate_effect({mult = card.ability.extra.mult}, card)
          end
                if SMODS.pseudorandom_probability(card, 'group_1_ad0fe7f1', 1, card.ability.extra.odds, 'j_modprefix_theglovesofdiaster', false) then
              SMODS.calculate_effect({mult = card.ability.extra.mult2}, card)
          end
                if SMODS.pseudorandom_probability(card, 'group_2_0880032d', 1, card.ability.extra.odds, 'j_modprefix_theglovesofdiaster', false) then
              SMODS.calculate_effect({mult = card.ability.extra.mult3}, card)
          end
                if SMODS.pseudorandom_probability(card, 'group_3_5d355c38', 1, card.ability.extra.odds, 'j_modprefix_theglovesofdiaster', false) then
              SMODS.calculate_effect({mult = card.ability.extra.mult4}, card)
          end
            end
        end
    end
}


SMODS.Joker{ --V1
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "v1",
    config = {
        extra = {
            repetitions = 1
        }
    },
    loc_txt = {
        ['name'] = 'V1',
        ['text'] = {
            [1] = 'Retriggers all played {C:attention}Aces{},',
            [2] = '{C:attention}4{}s and {C:attention}9{}s'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play  then
            if (context.other_card:get_id() == 4 or context.other_card:get_id() == 9 or context.other_card:get_id() == 14) then
                return {
                    repetitions = card.ability.extra.repetitions,
                    message = localize('k_again_ex')
                }
            end
        end
    end
}

SMODS.Joker{ --Dial-up
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "dialup",
    config = {
        extra = {
            randomRank = 0
        }
    },
    loc_txt = {
        ['name'] = 'Dial-up',
        ['text'] = {
            [1] = 'does nothing lmao'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

    calculate = function(self, card, context)
    
    end -- yeah this does nothing lmao
}

SMODS.Joker{ --Stickman
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "stickman",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Stickman',
        ['text'] = {
            'Add 3 {C:attention}Stone Cards{} with random',
            '{C:attention}Seals{} and {C:attention}Editions{}',
            'to your deck at end of round'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
                local card_front = pseudorandom_element(G.P_CARDS, pseudoseed('add_card'))
            local new_card = create_playing_card({
                front = card_front,
                center = G.P_CENTERS.m_stone
            }, G.discard, true, false, nil, true)
            new_card:set_seal(pseudorandom_element({"Gold", "Red", "Blue", "Purple"}, pseudoseed('add_card_seal')), true)
            new_card:set_edition(pseudorandom_element({"e_foil", "e_holo", "e_polychrome"}, pseudoseed('add_card_edition')), true)
            
            G.E_MANAGER:add_event(Event({
                func = function()
                    new_card:start_materialize()
                    G.play:emplace(new_card)
                    return true
                end
            }))
                local card_front = pseudorandom_element(G.P_CARDS, pseudoseed('add_card'))
            local new_card = create_playing_card({
                front = card_front,
                center = G.P_CENTERS.m_stone
            }, G.discard, true, false, nil, true)
            new_card:set_seal(pseudorandom_element({"Gold", "Red", "Blue", "Purple"}, pseudoseed('add_card_seal')), true)
            new_card:set_edition(pseudorandom_element({"e_foil", "e_holo", "e_polychrome"}, pseudoseed('add_card_edition')), true)
            
            G.E_MANAGER:add_event(Event({
                func = function()
                    new_card:start_materialize()
                    G.play:emplace(new_card)
                    return true
                end
            }))
                local card_front = pseudorandom_element(G.P_CARDS, pseudoseed('add_card'))
            local new_card = create_playing_card({
                front = card_front,
                center = G.P_CENTERS.m_stone
            }, G.discard, true, false, nil, true)
            new_card:set_seal(pseudorandom_element({"Gold", "Red", "Blue", "Purple"}, pseudoseed('add_card_seal')), true)
            new_card:set_edition(pseudorandom_element({"e_foil", "e_holo", "e_polychrome"}, pseudoseed('add_card_edition')), true)
            
            G.E_MANAGER:add_event(Event({
                func = function()
                    new_card:start_materialize()
                    G.play:emplace(new_card)
                    return true
                end
            }))
                return {
                    func = function()
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        return true
                    end
                }))
                draw_card(G.play, G.deck, 90, 'up')
                SMODS.calculate_context({ playing_card_added = true, cards = { new_card } })
            end,
                    message = "Stoned!",
                    extra = {
                        func = function()
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        return true
                    end
                }))
                draw_card(G.play, G.deck, 90, 'up')
                SMODS.calculate_context({ playing_card_added = true, cards = { new_card } })
            end,
                            message = "Stoned!",
                        colour = G.C.GREEN,
                        extra = {
                            func = function()
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        return true
                    end
                }))
                draw_card(G.play, G.deck, 90, 'up')
                SMODS.calculate_context({ playing_card_added = true, cards = { new_card } })
            end,
                            message = "Stoned!",
                            colour = G.C.GREEN
                        }
                        }
                }
        end
    end
}

SMODS.Joker{ --Wrench
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "wrench",
    config = {
        extra = {
            Tarot = 0,
            Spectral = 0
        }
    },
    loc_txt = {
        ['name'] = 'Wrench',
        ['text'] = {
            [1] = 'Gain a {C:attention}Immolate{}, {C:attention}The Hanged Man{},',
            [2] = '{C:attention}Cryptid{}, {C:attention}Aura{}, {C:attention}Strength{} and {C:attention}Death{}',
            [3] = '(all {C:dark_edition}Negative{}) at end of round'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
                return {
                    func = function()local created_consumable = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card{set = 'Tarot', key = 'c_hanged_man', edition = 'e_negative', key_append = 'joker_forge_tarot'}
                        return true
                    end
                }))
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
                    end
                    return true
                end,
                    extra = {
                        func = function()local created_consumable = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card{set = 'Tarot', key = 'c_strength', edition = 'e_negative', key_append = 'joker_forge_tarot'}
                        return true
                    end
                }))
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
                    end
                    return true
                end,
                        colour = G.C.PURPLE,
                        extra = {
                            func = function()local created_consumable = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card{set = 'Tarot', key = 'c_death', edition = 'e_negative', key_append = 'joker_forge_tarot'}
                        return true
                    end
                }))
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
                    end
                    return true
                end,
                            colour = G.C.PURPLE,
                        extra = {
                            func = function()local created_consumable = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card{set = 'Spectral', key = 'c_aura', edition = 'e_negative', key_append = 'joker_forge_spectral'}
                        return true
                    end
                }))
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                    end
                    return true
                end,
                            colour = G.C.SECONDARY_SET.Spectral,
                        extra = {
                            func = function()local created_consumable = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card{set = 'Spectral', key = 'c_cryptid', edition = 'e_negative', key_append = 'joker_forge_spectral'}
                        return true
                    end
                }))
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                    end
                    return true
                end,
                            colour = G.C.SECONDARY_SET.Spectral,
                        extra = {
                            func = function()local created_consumable = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card{set = 'Spectral', key = 'c_immolate', edition = 'e_negative', key_append = 'joker_forge_spectral'}
                        return true
                    end
                }))
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                    end
                    return true
                end,
                            colour = G.C.SECONDARY_SET.Spectral
                        }
                        }
                        }
                        }
                        }
                }
        end
    end
}

SMODS.Joker{ --Lamp
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "lamp",
    config = {
        extra = {
            odds = 2,
            Spectral = 0
        }
    },
    loc_txt = {
        ['name'] = 'Lamp',
        ['text'] = {
            '{C:green}1 in #1#{} to grant a',
            '{C:dark_edition}Negative{} {C:spectral}Spectral Card{}',
            'at end of round'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
   	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.odds } }
	end, 
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_13ef560d', 1, card.ability.extra.odds, 'j_modprefix_lamp', false) then
              SMODS.calculate_effect({func = function()local created_consumable = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card{set = 'Spectral', key = nil, edition = 'e_negative', key_append = 'joker_forge_spectral'}
                        return true
                    end
                }))
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                    end
                    return true
                end}, card)
          end
            end
        end
    end
}

SMODS.Joker{ --Heart of Hearts
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "heartofhearts",
    config = {
        extra = {
            Tarot = 0
        }
    },
    loc_txt = {
        ['name'] = 'Heart of Hearts',
        ['text'] = {
            [1] = 'Gain a {C:dark_edition}Negative{} {C:attention}The Sun{} when a {C:hearts}Heart{} is scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    atlas = 'Jokers-1',

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Hearts") then
                local created_consumable = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card{set = 'Tarot', key = 'c_sun', edition = 'e_negative', key_append = 'joker_forge_tarot'}
                        return true
                    end
                }))
                return {
                    message = "Hearty!"
                }
            end
        end
    end
}

SMODS.Joker{ --Diamond of Diamonds
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "diamondofdiamonds",
    config = {
        extra = {
            ignore = 0
        }
    },
    loc_txt = {
        ['name'] = 'Diamond of Diamonds',
        ['text'] = {
            [1] = 'Grants a {C:dark_edition}Negative{} {C:attention}Greedy Joker{}',
            [2] = 'when a {C:diamonds}Diamond{} is scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    atlas = 'Jokers-1',

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Diamonds") then
                local created_joker = true
                  G.E_MANAGER:add_event(Event({
                      func = function()
                          local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_greedy_joker' })
                          if joker_card then
                              joker_card:set_edition("e_negative", true)
                              
                          end
                          
                          return true
                      end
                  }))
                return {
                    message = "Greedful!"
                }
            end
        end
    end
}

SMODS.Joker{ --Happy Plant
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "happyplant",
    config = {
        extra = {
            roundsUntilDestruction = 0,
            investment = 0
        }
    },
    loc_txt = {
        ['name'] = 'Happy Plant',
        ['text'] = {
            'Sell this joker to generate a',
            '{C:money}Investment Tag{}, or keep this',
            'for 3 rounds to redeem Seed Money',
			'{C:inactive}({C:roundsUntilDestruction}#1#{C:inactive}/3 rounds)'
        },
    },
    pos = {
        x = 0,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 3,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

   	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.roundsUntilDestruction } }
	end, 

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if (card.ability.extra.roundsUntilDestruction or 0) == 3 then
                local voucher_key = "v_seed_money"
    local voucher_card = SMODS.create_card{area = G.play, key = voucher_key}
    voucher_card:start_materialize()
    voucher_card.cost = 0
    G.play:emplace(voucher_card)
    delay(0.8)
    voucher_card:redeem()

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.5,
        func = function()
            voucher_card:start_dissolve()                
            return true
        end
    }))
                return {
                    func = function()
                card:start_dissolve()
                return true
            end,
                    message = "Fully grown!",
                    extra = {
                        message = nil,
                        colour = G.C.RED
                        }
                }
            else
                return {
                    func = function()
                    card.ability.extra.roundsUntilDestruction = (card.ability.extra.roundsUntilDestruction) + 1
                    return true
                end
                }
            end
        end
        if context.selling_self  then
                return {
                    func = function()
            G.E_MANAGER:add_event(Event({
                func = function()
                    local tag = Tag("tag_investment")
                    if tag.name == "Orbital Tag" then
                        local _poker_hands = {}
                        for k, v in pairs(G.GAME.hands) do
                            if v.visible then
                                _poker_hands[#_poker_hands + 1] = k
                            end
                        end
                        tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "jokerforge_orbital")
                    end
                    tag:set_ability()
                    add_tag(tag)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
                    return true
                end,
                    message = "Created Tag!"
                }
        end
    end
}

SMODS.Joker {
    pools = { ["nimsi_nimsi_mod"] = true },
	key = 'rose',
	loc_txt = {
		name = 'Rose',
		text = {
			"Each played {C:attention}5 to 8{}",
			"gives {C:chips}+#1#{} Chips and",
			"{C:mult}+#2#{} Mult when scored"
		}
	},
	config = { 
        extra = { 
            chips = 5, 
            mult = 8
        } 
    },
	rarity = 2,
	atlas = 'Jokers-1',
	pos = { 
        x = 1, 
        y = 3
     },
	cost = 6,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 5 or context.other_card:get_id() == 6 or context.other_card:get_id() == 7 or context.other_card:get_id() == 8 then
				return {
					chips = card.ability.extra.chips,
					mult = card.ability.extra.mult,
					card = context.other_card
				}
			end
		end
	end
}

SMODS.Joker{ --Weed Spray
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "weedspray",
    loc_txt = {
        ['name'] = 'Weed Spray',
        ['text'] = {
            [1] = '{C:attention}Instantly wins{} the',
            [2] = 'round if the Blind',
            [3] = 'is {C:attention}The Plant{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

    calculate = function(self, card, context)
        if context.first_hand_drawn  then
            if G.GAME.blind.config.blind.key == "bl_plant" then
                G.E_MANAGER:add_event(Event({
                    blocking = false,
                    func = function()
                        if G.STATE == G.STATES.SELECTING_HAND then
                            G.GAME.chips = G.GAME.blind.chips
                            G.STATE = G.STATES.HAND_PLAYED
                            G.STATE_COMPLETE = true
                            end_round()
                            return true
                        end
                    end
                }))
            end
        end
    end
}

SMODS.Joker{ --Steering Wheel
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "steeringwheel",
    config = {
        extra = {
            Tarot = 0
        }
    },
    loc_txt = {
        ['name'] = 'Steering Wheel',
        ['text'] = {
            [1] = 'Creates a {C:dark_edition}Negative {}{C:attention}Wheel of Fortune{}',
            [2] = 'when you enter the shop'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

    calculate = function(self, card, context)
        if context.starting_shop  then
                return {
                    func = function()local created_consumable = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card{set = 'Tarot', key = 'c_wheel_of_fortune', edition = 'e_negative', key_append = 'joker_forge_tarot'}
                        return true
                    end
                }))
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
                    end
                    return true
                end
                }
        end
    end
}

SMODS.Joker{ --Number Four
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "numberfour",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Number Four',
        ['text'] = {
            [1] = 'If you play a {C:attention}4{}, permanently',
            [2] = 'add a copy of it to',
            [3] = 'your deck and draw it to {C:attention}hand{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:get_id() == 4 then
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local copied_card = copy_card(context.other_card, nil, nil, G.playing_card)
                copied_card:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                G.deck:emplace(copied_card)
                table.insert(G.playing_cards, copied_card)
                playing_card_joker_effects({true})
                
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        copied_card:start_materialize()
                        return true
                    end
                }))
                return {
                    message = "Duplicated!"
                }
            end
        end
    end
}

SMODS.Joker { -- CD-I
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "cdi",
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    pos = { 
        x = 1, 
        y = 4 
    },
    config = { 
        extra = { 
            mult = 0, 
            mult_gain = 1
        } 
    },
    loc_txt = {
        ['name'] = 'CD-I',
        ['text'] = {
            "Gains{C:mult}+#2#{} Mult when you discard",
            "a card.",
			"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    atlas = 'Jokers-1',
   	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
	end, 
    calculate = function(self, card, context)
        if context.discard and not context.blueprint and
            not context.other_card.debuff then
            -- See note about SMODS Scaling Manipulation on the wiki
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return {
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                colour = G.C.RED
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
}

SMODS.Joker{ --Ffar Ffir
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "ffarffir",
    config = {
        extra = {
            ignore = 0
        }
    },
    loc_txt = {
        ['name'] = 'Ffar Ffir',
        ['text'] = {
            [1] = 'Creates a {C:rare}Rare{} Joker',
            [2] = 'when Blind is {C:attention}skipped{}',
            [3] = '{C:inactive}(Doesn\'t need room){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 9,
    rarity = "nimsi_Epic",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

    calculate = function(self, card, context)
        if context.skip_blind  then
                return {
                    func = function()
            local created_joker = true
            G.E_MANAGER:add_event(Event({
                func = function()
                    local joker_card = SMODS.add_card({ set = 'Joker', rarity = 'Rare' })
                    if joker_card then
                        
                        
                    end
                    
                    return true
                end
            }))
            
            if created_joker then
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
            end
            return true
        end
                }
        end
    end
}

SMODS.Joker{ --Rewrite
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "rewrite",
    config = {
        extra = {
            booster_slots = 1
        }
    },
    loc_txt = {
        ['name'] = 'Rewrite',
        ['text'] = {
            [1] = 'Grants {C:attention}+#1#{} shop slot and',
            [2] = 'booster pack per round'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
   	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.booster_slots } }
	end, 
    cost = 10,
    rarity = "nimsi_Epic",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.booster_slots).." Booster Slots", colour = G.C.DARK_EDITION})
                SMODS.change_booster_limit(card.ability.extra.booster_slots)
                change_shop_size(1)
                return true
                    end
                }
        end
    end
}

SMODS.Joker{ --The Needle
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "the_needle",
    config = {
        extra = {
            hands = 1,
            Xmult = 5,
            round = 0
        }
    },
    loc_txt = {
        ['name'] = 'The Needle',
        ['text'] = {
            [1] = 'Sets {C:attention}hands{} to #1#.',
            [2] = '{X:mult,C:white}X#2#{} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 5
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

   	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hands, card.ability.extra.Xmult } }
	end, 

    calculate = function(self, card, context)
        if context.first_hand_drawn  then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Set to "..tostring(card.ability.extra.hands).." Hands", colour = G.C.BLUE})
                G.GAME.current_round.hands_left = card.ability.extra.hands
                return true
            end
                }
        end
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    Xmult = card.ability.extra.Xmult
                }
        end
    end
}

SMODS.Joker{ --The Mannacle
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "the_mannacle",
    config = {
        extra = {
            hand_size = 1,
            Xmult = 2.5,
        }
    },
    loc_txt = {
        ['name'] = 'The Mannacle',
        ['text'] = {
            [1] = '{C:red}-#1#{} hand size. {X:mult,C:white}X#2#{} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 5
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
   	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hand_size, card.ability.extra.Xmult } }
	end, 
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    Xmult = card.ability.extra.Xmult
                }
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(-1)
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(1)
    end
}

SMODS.Joker{ --The Ox
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "the_ox",
    config = {
        extra = {
            dollars = 0,
            Xmult = 3
        }
    },
    loc_txt = {
        ['name'] = 'The Ox',
        ['text'] = {
            [1] = 'Playing your most',
            [2] = '{C:attention}played hand{} this run',
            [3] = 'sets money to {C:gold}$#1#{}',
            [4] = '{X:mult,C:white}X#2#{} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 5
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

    
   	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars, card.ability.extra.Xmult } }
	end, 
    calculate = function(self, card, context)
        if context.after and context.cardarea == G.jokers  then
            if (function()
    local current_played = G.GAME.hands[context.scoring_name].played or 0
    for handname, values in pairs(G.GAME.hands) do
        if handname ~= context.scoring_name and values.played > current_played and values.visible then
            return false
        end
    end
    return true
end)() then
                return {
                    func = function()
                    local target_amount = card.ability.extra.dollars
                    local current_amount = G.GAME.dollars
                    local difference = target_amount - current_amount
                    ease_dollars(difference)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "get trolled lmao", colour = G.C.MONEY})
                    return true
                end
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    Xmult = card.ability.extra.Xmult
                }
        end
    end
}

SMODS.Joker{ --The Tooth
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "the_tooth",
    config = {
        extra = {
            dollars = 1,
            Xmult = 4
        }
    },
    loc_txt = {
        ['name'] = 'The Tooth',
        ['text'] = {
            'Lose $#1# per card played.',
            '{X:mult,C:white}X#2#{} Xult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 5
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

    
   	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars, card.ability.extra.Xmult } }
	end, 

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
                return {
                    dollars = -card.ability.extra.dollars
                }
        end
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    Xmult = card.ability.extra.Xmult
                }
        end
    end
}

SMODS.Joker{ --Particle Invertor
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "particleinvertor",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Particle Invertor',
        ['text'] = {
            [1] = 'Stocks a {C:dark_edition}Negative Tag{}',
            [2] = 'when you {C:green}reroll{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 0,
        y = 6
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

    calculate = function(self, card, context)
        if context.reroll_shop  then
                return {
                    func = function()
            G.E_MANAGER:add_event(Event({
                func = function()
                    local tag = Tag("tag_negative")
                    if tag.name == "Orbital Tag" then
                        local _poker_hands = {}
                        for k, v in pairs(G.GAME.hands) do
                            if v.visible then
                                _poker_hands[#_poker_hands + 1] = k
                            end
                        end
                        tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "jokerforge_orbital")
                    end
                    tag:set_ability()
                    add_tag(tag)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
                    return true
                end,
                    message = "Created Tag!"
                }
        end
    end
}

SMODS.Joker{ --Banker
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "banker",
    config = {
        extra = {
            investment = 0
        }
    },
    loc_txt = {
        ['name'] = 'Monkey Bank',
        ['text'] = {
            [1] = 'Stocks a {C:attention}Investment Tag{}',
            [2] = 'when blind is selected'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 6
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 9,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

    calculate = function(self, card, context)
        if context.setting_blind  then
            if true then
                return {
                    func = function()
            G.E_MANAGER:add_event(Event({
                func = function()
                    local tag = Tag("tag_investment")
                    if tag.name == "Orbital Tag" then
                        local _poker_hands = {}
                        for k, v in pairs(G.GAME.hands) do
                            if v.visible then
                                _poker_hands[#_poker_hands + 1] = k
                            end
                        end
                        tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "jokerforge_orbital")
                    end
                    tag:set_ability()
                    add_tag(tag)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
                    return true
                end,
                    message = "Created Tag!"
                }
            end
        end
        if context.buying_card and context.card.config.center.key == self.key and context.cardarea == G.jokers  then
                return {
                    func = function()
            G.E_MANAGER:add_event(Event({
                func = function()
                    local tag = Tag("tag_investment")
                    if tag.name == "Orbital Tag" then
                        local _poker_hands = {}
                        for k, v in pairs(G.GAME.hands) do
                            if v.visible then
                                _poker_hands[#_poker_hands + 1] = k
                            end
                        end
                        tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "jokerforge_orbital")
                    end
                    tag:set_ability()
                    add_tag(tag)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
                    return true
                end,
                    message = "Created Tag!"
                }
        end
    end
}

SMODS.Joker{ --Honey Hunter Slime
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "honeyhunterslime",
    config = {
        extra = {
            hasEaten = 0,
            Xmult = 1,
            dollars = 5,
            no = 0,
            Xmultgain = 1
        }
    },
    loc_txt = {
        ['name'] = 'Honey Hunter Slime',
        ['text'] = {
            [1] = 'When {C:attention}Blind{} is selected,',
            [2] = 'consumes a {C:attention}food Joker{},',
            [3] = 'gains {X:mult,C:white}X#2#{} Mult and earns $#3#',
            [4] = '(Currently {X:mult,C:white}X#1# Mult{})'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 2,
        y = 6
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

    loc_vars = function(self, info_queue, card)
        return {vars = { card.ability.extra.Xmult, card.ability.extra.Xmultgain, card.ability.extra.dollars }}
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            return {
                func = function()
                local target_joker = nil
                local hasEaten = 0
                for i, joker in ipairs(G.jokers.cards) do
                    if (
                    joker.config.center.key == "j_gros_michel" or
                    joker.config.center.key == "j_popcorn" or
                    joker.config.center.key == "j_ice_cream" or
                    joker.config.center.key == "j_turtle_bean" or
                    joker.config.center.key == "j_diet_cola" or
                    joker.config.center.key == "j_ramen" or
                    joker.config.center.key == "j_selzer"
                    )
                    and not joker.ability.eternal and not joker.getting_sliced then
                    target_joker = joker
                    break
                    end
                end

                if target_joker then
                    local joker_sell_value = target_joker.sell_cost or 0
                    target_joker.getting_sliced = true
                    hasEaten = 1
                    G.E_MANAGER:add_event(Event({
                    func = function()
                        target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                        return true
                    end
                    }))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Yummy!", colour = G.C.RED})
                end

                if hasEaten == 1 then
                    G.GAME.dollars = G.GAME.dollars + card.ability.extra.dollars
                    card.ability.extra.Xmult = card.ability.extra.Xmult + 1
                end
                return true
            end
            }
        elseif context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

SMODS.Joker{ --mochi miles
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "mochimiles",
    config = {
        extra = {
            dollars = 8
        }
    },
    loc_txt = {
        ['name'] = 'Mochi Miles',
        ['text'] = {
            'Grants $#1# for every time,',
            'you go over the blind goal',
            "Effect doesn't work on boss blinds"
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 6
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
   	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
	end, 
    cost = 4,
    rarity = "nimsi_Epic",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

    calculate = function(self, card, context)
        if context.after and context.cardarea == G.jokers  then
            if not (G.GAME.blind.boss) and G.GAME.chips >= SMODS.calculate_round_score() then
                return {
                    dollars = card.ability.extra.dollars * max(floor(G.GAME.chips / G.GAME.blind.chips), 1)
                }
            end
        end
    end
}

SMODS.Joker{ --Walter White
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "walterwhite",
    config = {
        extra = {
            currentmoney = 0,
            dollars2 = 0
        }
    },
    loc_txt = {
        ['name'] = 'Walter White',
        ['text'] = {
            [1] = '${X:money,C:white}X#1#{} at end of round.',
            [2] = '{C:attention}Selling{} this sets your',
            [3] = 'money to {C:money}$#2#{}.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 7
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
   	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.currentmoney, card.ability.extra.dollars2 } }
	end, 
    cost = 4,
    rarity = "nimsi_Epic",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
                return {
                    dollars = G.GAME.dollars
                }
        end
        if context.selling_self  then
                return {
                    func = function()
                    local target_amount = card.ability.extra.dollars2
                    local current_amount = G.GAME.dollars
                    local difference = target_amount - current_amount
                    ease_dollars(difference)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "i am the danger...", colour = G.C.MONEY})
                    return true
                end
                }
        end
    end
}

SMODS.Joker{ --Silvery Shard
    pools = { ["nimsi_nimsi_mod"] = true },
    key = "silveryshard",
    config = {
        extra = {
            repetitions = 3,
            repetitions2 = 1
        }
    },
    loc_txt = {
        ['name'] = 'Silvery Shard',
        ['text'] = {
            [1] = '{C:attention}Retrigger{} {C:enhanced}Enhanced{} cards',
            [2] = '{C:attention}#1# times{} and everything',
            [3] = 'else{C:attention} #2# time.{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 1,
        y = 7
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
   	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.repetitions, card.ability.extra.repetitions2 } }
	end, 
    cost = 9,
    rarity = "nimsi_Epic",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play  then
            if (function()
        local enhancements = SMODS.get_enhancements(context.other_card)
        for k, v in pairs(enhancements) do
            if v then
                return true
            end
        end
        return false
    end)() then
                return {
                    repetitions = card.ability.extra.repetitions,
                    message = localize('k_again_ex')
                }
            else
                return {
                    repetitions = card.ability.extra.repetitions2,
                    message = localize('k_again_ex')
                }
            end
        end
    end
}

SMODS.Joker{ --father of @mr.cr33ps
    key = "fatherofmrcr33ps",
    config = {
        extra = {
            dollars = 5
        }
    },
    loc_txt = {
        ['name'] = 'father of @mr.cr33ps',
        ['text'] = {
            [1] = '{C:attention}Says he\'s proud{} if the',
            [2] = 'chip/mult lights on fire,',
            [3] = 'granting {C:gold}$#1#{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 7
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',
    pools = { ["nimsi_nimsi_mod"] = true },
   	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars } }
	end, 
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if G.GAME.chips >= SMODS.calculate_round_score() then
                return {
                    dollars = card.ability.extra.dollars,
                    message = "Im proud of you"
                }
            end
        end
    end
}
SMODS.Joker{ --MissingNo.
    key = "missingno",
    config = {
        extra = {
            chips_min = 0,
            chips_max = 1025,
            mult_min = 0,
            mult_max = 151,
            n = 0
        }
    },

    loc_txt = {
        ['name'] = 'MissingNo.',
        ['text'] = {
            [1] = '{C:blue}#1#-#2#{} Chips, {C:red}#3#=#4#{} Mult.',
            [2] = 'Create 3 vanilla {C:dark_edition}Negative{}',
            [3] = 'consumables at end of round.',
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 7
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },   	
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips_min, card.ability.extra.chips_max, card.ability.extra.mult_min, card.ability.extra.mult_max } }
	end, 
    cost = 31,
    rarity = "nimsi_Epic",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',
    pools = { ["nimsi_nimsi_mod"] = true },

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    chips = pseudorandom('chips_f01ebc72', card.ability.extra.chips_min, card.ability.extra.chips_max),
                    extra = {
                        mult = pseudorandom('mult_a7fa57a5', card.ability.extra.mult_min, card.ability.extra.mult_max)
                        }
                }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  then
                return {
                    func = function()local created_consumable = false
                for i = 1, 3 do
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        created_consumable = true
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local random_sets = {'Tarot', 'Planet', 'Spectral'}
                                local random_set = random_sets[math.random(1, #random_sets)]
                                SMODS.add_card{set=random_set, soulable = true, edition = 'e_negative', key_append='joker_forge_' .. random_set:lower()}
                                G.GAME.consumeable_buffer = 0
                                return true
                            end
                        }))
                    end
                end
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "0x43", colour = G.C.PURPLE})
                    end
                    return true
                end
                }
        end
    end
}

SMODS.Joker{ --Iron Pickaxe
    key = "ironpickaxe",
    config = {
        extra = {
            increment = 15,
            addChips = 0
        }
    },
    loc_txt = {
        ['name'] = 'Iron Pickaxe',
        ['text'] = {
            [1] = 'Destroys played {C:attention}Stone{} Cards',
            [2] = 'and gains {C:blue}+#2#{} Chips',
			[3] = "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 8
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',
    pools = { ["nimsi_nimsi_mod"] = true },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.addChips, card.ability.extra.increment }}
    end,

    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy  then
            return { remove = true }
        end
        if context.individual and context.cardarea == G.play  then
            context.other_card.should_destroy = false
            if SMODS.get_enhancements(context.other_card)["m_stone"] == true then
                context.other_card.should_destroy = true
                card.ability.extra.addChips = (card.ability.extra.addChips) + 15
                return {
                    message = "Mined!"
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    chip_mod = card.ability.extra.addChips
                }
        end
    end
}

SMODS.Joker{ --Blue Shell
    key = "blueshell",
    config = {
        extra = {
            levels = -999,
            Xmult = 5,
            most = 0,
            start_dissolve = 0,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'Blue Shell',
        ['text'] = {
            [1] = '{X:red,C:white}X#1#{} Mult',
            [2] = 'Playing your {C:attention}most played',
            [3] = 'poker hand{} this run',
            [4] = 'sets its level to 1 and',
            [5] = 'destroys this'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 8
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult } }
	end, 
    cost = 6,
    rarity = "nimsi_Epic",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',
    pools = { ["nimsi_nimsi_mod"] = true },

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if (function()
    local current_played = G.GAME.hands[context.scoring_name].played or 0
    for handname, values in pairs(G.GAME.hands) do
        if handname ~= context.scoring_name and values.played > current_played and values.visible then
            return false
        end
    end
    return true
end)() then
                temp_played = 0
        temp_order = math.huge
        for hand, value in pairs(G.GAME.hands) do 
          if value.played > temp_played and value.visible then
            temp_played = value.played
            temp_order = value.order
            target_hand = hand
          else if value.played == temp_played and value.visible then
            if value.order < temp_order then
              temp_order = value.order
              target_hand = hand
            end
          end
          end
        end
                return {
                    level_up = (function() 
                        local most_played = 0; 
                        local most_played_hand = ''; 
                        for hand, data in pairs(G.GAME.hands) do 
                            if data.played > most_played then 
                                most_played = data.played; 
                                most_played_hand = hand end
                             end;
                            return most_played_hand ~= '' and (G.GAME.hands[most_played_hand].level - 1) or 1 end)(),
      level_up_hand = target_hand,
                    message = localize('k_level_up_ex'),
                    extra = {
                        func = function()
                card:start_dissolve()
                return true
            end,
                        colour = G.C.RED
                        }
                }
            else
                return {
                    Xmult = card.ability.extra.Xmult
                }
            end
        end
    end
}

SMODS.Joker{ --Pi
    key = "pi",
    config = {
        extra = {
            echips = 0.3,
            emult = 3.14
        }
    },
    loc_txt = {
        ['name'] = 'Pi',
        ['text'] = {
            [1] = '{X:mult,C:white}^#2#{} Mult, {X:chips,C:white}^#1#{} Chips'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 8
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },   	
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.echips, card.ability.extra.emult } }
	end, 
    cost = 3,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',
    pools = { ["nimsi_nimsi_mod"] = true },

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    e_chips = card.ability.extra.echips,
                    extra = {
                        e_mult = card.ability.extra.emult,
                        colour = G.C.DARK_EDITION
                        }
                }
        end
    end
}

SMODS.Joker{ --The 80s
    key = "the80s",
    config = {
        extra = {
            source_rank_type = "specific",
            source_ranks = {"8"},
            target_rank = "10",
            source_rank_type = "specific",
            source_ranks = {"10"},
            target_rank = "8",
            discards = 1,
            permanent = 0
        }
    },
    loc_txt = {
        ['name'] = 'The 80s',
        ['text'] = {
            [1] = '{C:attention}8s{} are {C:attention}10s{} and vice versa',
            [2] = 'Scored {C:attention}8s{} grant {C:red}+#1#{}',
            [3] = 'Discard'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 3,
        y = 8
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',
    pools = { ["nimsi_nimsi_mod"] = true },
   	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.discards } }
	end, 

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:get_id() == 8 then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.discards).." Discard", colour = G.C.ORANGE})
                
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
        ease_discard(card.ability.extra.discards)
        
                return true
            end
                }
            end
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        -- Combine ranks effect enabled
        -- Combine ranks effect enabled
    end,

    remove_from_deck = function(self, card, from_debuff)
        -- Combine ranks effect disabled
        -- Combine ranks effect disabled
    end
} 
      
local card_get_id_ref = Card.get_id
function Card:get_id()
    local original_id = card_get_id_ref(self)
    if not original_id then return original_id end

    if next(SMODS.find_card("j_nimsi_the80s")) then
        local source_ids = {8}
        for _, source_id in pairs(source_ids) do
            if original_id == source_id then return 10 end
        end
    end
    if next(SMODS.find_card("j_nimsi_the80s")) then
        local source_ids = {10}
        for _, source_id in pairs(source_ids) do
            if original_id == source_id then return 8 end
        end
    end
    return original_id
end

SMODS.Joker{ --Nuclear Annihilation 
    key = "nuclearannihilation",
    loc_txt = {
        ['name'] = 'Nuclear Annihilation ',
        ['text'] = {
            [1] = 'Creates {C:attention}3{} {C:dark_edition}Negative{} {C:spectral}Black Holes{}',
            [2] = 'and {C:attention}2{} random {C:planet}planets{} at end',
            [3] = 'of round.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 9
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',
    pools = { ["nimsi_nimsi_mod"] = true },

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if true then
                return {
                    func = function()local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Spectral', soulable = nil, key = 'c_black_hole', edition = 'e_negative', key_append = 'joker_forge_spectral'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                    end
                    return true
                end
                ,
                    func = function()
                        for i = 1, 2 do
              SMODS.calculate_effect({func = function()local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Spectral', soulable = nil, key = 'c_black_hole', edition = 'e_negative', key_append = 'joker_forge_spectral'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                    end
                    return true
                end}, card)
                        SMODS.calculate_effect({func = function()local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Planet', soulable = nil, key = nil, edition = 'e_negative', key_append = 'joker_forge_planet'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
                    end
                    return true
                end}, card)
          end
                        return true
                    end
                }
            end
        end
    end
}

SMODS.Joker{ --Wooden Pickaxe
    key = "woodenpickaxe",
    config = {
        extra = {
            multvar = 0,
            odds = 3,
            increment = 3
        }
    },
    loc_txt = {
        ['name'] = 'Wooden Pickaxe',
        ['text'] = {
            [1] = 'Gains {C:red}+#4#{} Mult if played card',
            [2] = 'has a {C:enhanced}Enhancement{} and',
            [3] = 'has a {C:green}#2# in #3#{} chance to',
            [4] = 'remove it',
            [5] = '{C:inactive}(Currently{} {C:red}+#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 9
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    atlas = 'Jokers-1',
    pools = { ["nimsi_nimsi_mod"] = true },

     loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_nimsi_woodenpickaxe') 
        return {vars = {card.ability.extra.multvar, new_numerator, new_denominator, card.ability.extra.increment}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if (function()
        local enhancements = SMODS.get_enhancements(context.other_card)
        for k, v in pairs(enhancements) do
            if v then
                return true
            end
        end
        return false
    end)() then
                card.ability.extra.multvar = (card.ability.extra.multvar) + 3
                if SMODS.pseudorandom_probability(card, 'group_0_04ca4a24', 1, card.ability.extra.odds, 'j_nimsi_woodenpickaxe', false) then
              context.other_card:set_ability(G.P_CENTERS.c_base)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Card Modified!", colour = G.C.BLUE})
          end
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    mult = card.ability.extra.multvar
                }
        end
    end
}

SMODS.Joker{ --Agent 4
    key = "agent4",
    config = {
        extra = {
            abilityVar = 0,
            abilityIncrement = 4
        }
    },
    loc_txt = {
        ['name'] = 'Agent 4',
        ['text'] = {
            [1] = '{C:blue}+#3#{} Chips, {C:red}+#3#{} Mult, {X:red,C:white}X#3#{} Mult',
            [2] = 'and {C:gold}$#3#{} at end of round for',
            [3] = 'every scored 4.',
            [4] = '{C:inactive}(Currently{} {C:red}+#1#{}{C:inactive} Mult, {C:blue}+#1#{}{C:inactive} Chips',
            [5] = '{X:mult,C:white}X#2#{}{C:inactive} Mult and {C:money}$#1#{}{C:inactive} at end',
            [6] = 'of round)'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 9
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = "nimsi_Epic",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',
    pools = { ["nimsi_nimsi_mod"] = true },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.abilityVar,
                card.ability.extra.abilityVar + 1,
                card.ability.extra.abilityIncrement
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:get_id() == 4 then
                card.ability.extra.abilityVar = (card.ability.extra.abilityVar) + 4
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    chips = card.ability.extra.abilityVar,
                    extra = {
                        mult = card.ability.extra.abilityVar,
                        extra = {
                            Xmult = card.ability.extra.abilityVar + 1
                        }
                        }
                }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  then
                return {
                    dollars = card.ability.extra.abilityVar
                }
        end
    end
}

SMODS.Joker{ --Agent 8
    key = "agent8",
    config = {
        extra = {
            repetitions = 8
        }
    },
    loc_txt = {
        ['name'] = 'Agent 8',
        ['text'] = {
            [1] = '{C:attention}Retriggers {}played {C:attention}8s{}',
            [2] = '#1# times'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 9
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = "nimsi_Epic",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',
    pools = { ["nimsi_nimsi_mod"] = true },
   	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.repetitions } }
	end, 
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play  then
            if context.other_card:get_id() == 8 then
                return {
                    repetitions = card.ability.extra.repetitions,
                    message = "veemo"
                }
            end
        end
    end
}

SMODS.Joker{ --Sonic
    key = "sonic",
    config = {
        extra = {
            hand_change = 1,
            emult = 1.2
        }
    },
    loc_txt = {
        ['name'] = 'Sonic',
        ['text'] = {
            [1] = '{X:red,C:white}^#1#{} Mult, {C:red}-#2#{} {C:blue}hand{}.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 10
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = "nimsi_Epic",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',
    pools = { ["nimsi_nimsi_mod"] = true }
    ,
   	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.emult, card.ability.extra.hand_change } }
	end, 

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    e_mult = card.ability.extra.emult
                }
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = math.max(1, G.GAME.round_resets.hands - card.ability.extra.hand_change)
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hand_change
    end
}

SMODS.Joker{ --The Bomb
    key = "thebomb",
    config = {
        extra = {
            chips = 1000
        }
    },
    loc_txt = {
        ['name'] = 'The Bomb',
        ['text'] = {
            [1] = '{C:blue}+#1#{} Chips on first',
            [2] = 'hand of round'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 10
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',
    pools = { ["nimsi_nimsi_mod"] = true },
   	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips } }
	end, 

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if G.GAME.current_round.hands_played == 0 then
                return {
                    chips = card.ability.extra.chips,
                    message = "BOOM!"
                }
            end
        end
    end
}

SMODS.Joker{ --Supergoon
    key = "supergoon",
    config = {
        extra = {
            chips = 30,
            chips2 = 50,
            odds = 5,
            odds2 = 15,
            mult = 20,
            dollars = 20,
            mult2 = 4,
            Xmult = 2,
            odds2 = 4
        }
    },
    loc_txt = {
        ['name'] = 'Supergoon',
        ['text'] = {
            [1] = 'Vannila {C:enhanced}Enhancements{}',
            [2] = 'work when held in hand',
            [3] = '{C:inactive}(ex: Bonus Cards gives +30 chips when held in hand){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 10
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',
    pools = { ["nimsi_nimsi_mod"] = true },

    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy  then
            return { remove = true }
        end
        if context.individual and context.cardarea == G.hand and not context.end_of_round  then
            context.other_card.should_destroy = false
            if SMODS.get_enhancements(context.other_card)["m_bonus"] == true then
                return {
                    chips = card.ability.extra.chips
                }
            elseif SMODS.get_enhancements(context.other_card)["m_stone"] == true then
                return {
                    chips = card.ability.extra.chips2
                }
            elseif SMODS.get_enhancements(context.other_card)["m_lucky"] == true then
                if SMODS.pseudorandom_probability(card, 'group_0_62f07006', 1, card.ability.extra.odds, 'j_nimsi_supergoon', false) then
              SMODS.calculate_effect({mult = card.ability.extra.mult}, card)
          end
                if SMODS.pseudorandom_probability(card, 'group_1_967cc670', 1, card.ability.extra.odds2, 'j_nimsi_supergoon', false) then
              SMODS.calculate_effect({dollars = card.ability.extra.dollars}, card)
          end
            elseif SMODS.get_enhancements(context.other_card)["m_mult"] == true then
                return {
                    mult = card.ability.extra.mult2
                }
            elseif SMODS.get_enhancements(context.other_card)["m_glass"] == true then
                return {
                    Xmult = card.ability.extra.Xmult
                ,
                    func = function()
                        if SMODS.pseudorandom_probability(card, 'group_0_64e17d69', 1, card.ability.extra.odds, 'j_nimsi_supergoon', false) then
              context.other_card.should_destroy = true
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
          end
                        return true
                    end
                }
            end
        end
    end
}

SMODS.Joker{ --1 Fingers
    key = "1_fingers",
    config = {
        extra = {
            reduction_value = 4
        }
    },
    loc_txt = {
        ['name'] = '1 Fingers',
        ['text'] = {
            [1] = 'All {C:attention}Flushes{} and {C:attention}Straights{} can be made with 1 card'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 3,
        y = 10
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-1',
    pools = { ["nimsi_nimsi_mod"] = true },

    calculate = function(self, card, context)
    end,

    add_to_deck = function(self, card, from_debuff)
        -- Flush/Straight requirements reduced by 4
    end,

    remove_from_deck = function(self, card, from_debuff)
        -- Flush/Straight requirements restored
    end
} 
      
local smods_four_fingers_ref = SMODS.four_fingers
function SMODS.four_fingers()
    if next(SMODS.find_card("j_nimsi_1_fingers")) then
        return 1
    end
    return smods_four_fingers_ref()
end

SMODS.Joker{ --The Master Plan
    key = "themasterplan2",
    config = {
        extra = {
            multsvar = 0,
            chipsvar = 0
        }
    },
    loc_txt = {
        ['name'] = 'The Master Plan',
        ['text'] = {
            [1] = 'Played {C:attention}#3#s{} give {C:red}#5#{} Mult',
            [2] = 'Played {C:attention}#4#s{} give {C:blue}#6#{} Chips',
            [3] = '{C:inactive}(Currently {C:red}#1#{} {C:inactive}Mult and{} {C:blue}#2#{} {C:inactive}Chips){}',
            [4] = '{s:0.8}ranks change at end of round{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 2,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    atlas = 'Jokers-2',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.multsvar, 
                card.ability.extra.chipsvar, 
                localize((G.GAME.current_round.rank1_card or {}).rank or 'Ace', 'ranks'), 
                localize((G.GAME.current_round.rank2_card or {}).rank or 'Ace', 'ranks'),
                G.GAME.current_round.rank1_card.id,
                G.GAME.current_round.rank2_card.id
            }
        }
    end,

    set_ability = function(self, card, initial)
        G.GAME.current_round.rank1_card = { rank = '2', id = 2 }
        G.GAME.current_round.rank2_card = { rank = 'Ace', id = 14 }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:get_id() == G.GAME.current_round.rank1_card.id then
                card.ability.extra.multsvar = (card.ability.extra.multsvar) + G.GAME.current_round.rank1_card.id
            elseif context.other_card:get_id() == G.GAME.current_round.rank2_card.id then
                card.ability.extra.chipsvar = (card.ability.extra.chipsvar) + G.GAME.current_round.rank2_card.id
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
                if G.playing_cards then
                        local valid_rank1_cards = {}
                        for _, v in ipairs(G.playing_cards) do
                            if not SMODS.has_no_rank(v) then
                                valid_rank1_cards[#valid_rank1_cards + 1] = v
                            end
                        end
                        if valid_rank1_cards[1] then
                            local rank1_card = pseudorandom_element(valid_rank1_cards, pseudoseed('rank1' .. G.GAME.round_resets.ante))
                            G.GAME.current_round.rank1_card.rank = rank1_card.base.value
                            G.GAME.current_round.rank1_card.id = rank1_card.base.id
                        end
                    end
                if G.playing_cards then
                        local valid_rank2_cards = {}
                        for _, v in ipairs(G.playing_cards) do
                            if not SMODS.has_no_rank(v) then
                                valid_rank2_cards[#valid_rank2_cards + 1] = v
                            end
                        end
                        if valid_rank2_cards[1] then
                            local rank2_card = pseudorandom_element(valid_rank2_cards, pseudoseed('rank2' .. G.GAME.round_resets.ante))
                            G.GAME.current_round.rank2_card.rank = rank2_card.base.value
                            G.GAME.current_round.rank2_card.id = rank2_card.base.id
                        end
                    end
        end
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    chips = card.ability.extra.chipsvar,
                    extra = {
                        mult = card.ability.extra.multsvar
                        }
                }
        end
    end
}

SMODS.Joker{ -- Apple
    pools = { ["nimsi_nimsi_mod"] = true },
    key = 'apple',
    loc_txt = {
        name = 'Apple',
        text = {
            '{C:chips}+#1#{} Chips',
            'Keeps {C:attention}the doctor{} away'
        }
    },
    config = { 
        extra = { 
            chips = 40,
        } 
    },
	rarity = 1,
    atlas = 'Jokers-2',
    pos = {
        x = 3, 
        y = 0
    },
	cost = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
   	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips} }
	end, 
    calculate = function(self, card, context)
		if context.joker_main then
			return {
				chip_mod = card.ability.extra.chips,
				message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
			}
		end
	end   
}



SMODS.Joker{ --Infinite
    key = "infinite",
    loc_txt = {
        ['name'] = 'Infinite',
        ['text'] = {
            [1] = '{C:attention}Infinite{} hand size'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0, 
        y = 1
    },
	soul_pos = { 
        x = 1, 
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = "nimsi_Epic",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'Jokers-2',
    pools = { ["nimsi_nimsi_mod"] = true },

    calculate = function(self, card, context)
        if context.first_hand_drawn then
            SMODS.draw_cards(#G.deck.cards)
        end
    end,
}

SMODS.Joker{ --Tails
    key = "tails",
    config = {
        extra = {
            repetitions = 2
        }
    },
    loc_txt = {
        ['name'] = 'Tails',
        ['text'] = {
            [1] = '{C:green}Duplicate{} a {C:attention}random joker{}',
            [2] = 'twice when {C:attention}exiting the',
            [3] = 'shop{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'Jokers-2',
    pools = { ["nimsi_nimsi_mod"] = true },

    calculate = function(self, card, context)
        if context.ending_shop  then
            if true then
                return {
                    message = "alls well that ends well!"
                ,
                    func = function()
                        for i = 1, card.ability.extra.repetitions do
              SMODS.calculate_effect({func = function()
                local available_jokers = {}
                for i, joker in ipairs(G.jokers.cards) do
                    table.insert(available_jokers, joker)
                end
                local target_joker = #available_jokers > 0 and pseudorandom_element(available_jokers, pseudoseed('copy_joker')) or nil
                
                if target_joker then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local copied_joker = copy_card(target_joker, nil, nil, nil, target_joker.edition and target_joker.edition.negative)
                        copied_joker:set_edition("e_negative", true)
                            
                            copied_joker:add_to_deck()
                            G.jokers:emplace(copied_joker)
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex'), colour = G.C.GREEN})
                end
                    return true
                end}, card)
          end
                        return true
                    end
                }
            end
        end
    end
}

SMODS.Joker{ --Triple Layered Cake
    key = "triplelayeredcake",
    config = {
        extra = {
            skipsLeft = 2,
            sellsLeft = 4,
            rerollsLeft = 8,
            gainExpMult = 0.5,
            ExpMult = 1
        }
    },
    loc_txt = {
        ['name'] = 'Triple Layered Cake',
        ['text'] = {
            [1] = 'After skipping 2 {C:inactive}[#1#]{} packs, selling',
            [2] = '4 {C:inactive}[#2#]{} items and rerolling 8 {C:inactive}[#3#]{} times,',
            [3] = 'gain {X:mult,C:white}^#4#{} Mult at the start of next round',
            [4] = '{C:inactive}(Currently{} {X:mult,C:white}^#5#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = "nimsi_Epic",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'Jokers-2',
    pools = { ["nimsi_nimsi_mod"] = true },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.skipsLeft, card.ability.extra.sellsLeft, card.ability.extra.rerollsLeft, card.ability.extra.gainExpMult, card.ability.extra.ExpMult}}
    end,

    calculate = function(self, card, context)
        if context.reroll_shop  then
                return {
                    func = function()
                    card.ability.extra.rerollsLeft = math.max(0, (card.ability.extra.rerollsLeft) - 1)
                    return true
                end
                }
        end
        if context.skipping_booster  then
                return {
                    func = function()
                    card.ability.extra.skipsLeft = math.max(0, (card.ability.extra.skipsLeft) - 1)
                    return true
                end
                }
        end
        if context.selling_card  then
                return {
                    func = function()
                    card.ability.extra.sellsLeft = math.max(0, (card.ability.extra.sellsLeft) - 1)
                    return true
                end
                }
        end
        if context.first_hand_drawn  then
            if (card.ability.extra.skipsLeft <= 0 and card.ability.extra.sellsLeft <= 0 and card.ability.extra.rerollsLeft <= 0) then
                return {
                    func = function()
                    card.ability.extra.ExpMult = (card.ability.extra.ExpMult) + card.ability.extra.gainExpMult
                    card.ability.extra.skipsLeft = 2
                    card.ability.extra.sellsLeft = 4
                    card.ability.extra.rerollsLeft = 8
                    return true
                end,
                    message = "Yummy!"
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    e_mult = card.ability.extra.ExpMult
                }
        end
        if context.cardarea == G.jokers then
                card.ability.extra.skipsLeft = math.min(2, card.ability.extra.skipsLeft)
                card.ability.extra.sellsLeft = math.min(4, card.ability.extra.sellsLeft)
                card.ability.extra.rerollsLeft = math.min(8, card.ability.extra.rerollsLeft)
        end
    end
}

SMODS.Joker{ -- crab
    pools = { ["nimsi_nimsi_mod"] = true },
    key = 'crab',
    loc_txt = {
        name = 'Crabe',
        text = {
            '{C:mult}+#1#{} Mult'
        }
    },
    config = { 
        extra = { 
            mult = 5,
        } 
    },
	rarity = 1,
    atlas = "Jokers-2",
    pos = {
        x = 0, 
        y = 2
    },
	cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
   	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end, 
    calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult_mod = card.ability.extra.mult,
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
			}
		end
	end   
}