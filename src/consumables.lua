-- another empty file
-- add purple cards later
-- planet ideas, maybe ones that increase levels by more than 1, or ones that level up multiple hands
-- multiple hand jokers:
-- toilet: flush, straight flush, flush five, flush house
-- thumbs up: high card, two of a kind, three of a kind, four of a kind, five of a kind
-- unnamed: high card, pair, two pair, two of a kind
-- Heat Death of the Universe: all levels by +1, increased by +1 for every Heat Death of the Universe used this run

SMODS.Consumable {
    key = 'flusher',
    set = 'Planet',
    pos = { x = 0, y = 0 },
    config = { extra = {
        hand_type = "Flush",
        levels = 1,
        hand_type = "Straight Flush",
        hand_type = "Flush House",
        hand_type = "Flush Five"
    } },
    loc_txt = {
        name = 'Flusher',
        text = {
        [1] = 'Levels up: {C:attention}Flush{},',
        [2] = '{C:attention}Straight Flush{}, {C:attention}Flush Five{}',
        [3] = '{C:attention}Flush House{}'
    }
    },
    cost = 5,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'Planets',
    use = function(self, card, area, copier)
        local used_card = copier or card
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                { handname = localize('Flush', 'poker_hands'), 
                  chips = G.GAME.hands['Flush'].chips, 
                  mult = G.GAME.hands['Flush'].mult, 
                  level = G.GAME.hands['Flush'].level })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = true
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = nil
                    return true
                end
            }))
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+'..tostring(1) })
            delay(1.3)
            level_up_hand(card, "Flush", true, 1)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, 
                {handname=localize('Flush', 'poker_hands'), 
                 chips = G.GAME.hands['Flush'].chips, 
                 mult = G.GAME.hands['Flush'].mult, 
                 level=G.GAME.hands['Flush'].level})
            delay(1.3)
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                { handname = localize('Straight Flush', 'poker_hands'), 
                  chips = G.GAME.hands['Straight Flush'].chips, 
                  mult = G.GAME.hands['Straight Flush'].mult, 
                  level = G.GAME.hands['Straight Flush'].level })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = true
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = nil
                    return true
                end
            }))
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+'..tostring(1) })
            delay(1.3)
            level_up_hand(card, "Straight Flush", true, 1)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, 
                {handname=localize('Straight Flush', 'poker_hands'), 
                 chips = G.GAME.hands['Straight Flush'].chips, 
                 mult = G.GAME.hands['Straight Flush'].mult, 
                 level=G.GAME.hands['Straight Flush'].level})
            delay(1.3)
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                { handname = localize('Flush House', 'poker_hands'), 
                  chips = G.GAME.hands['Flush House'].chips, 
                  mult = G.GAME.hands['Flush House'].mult, 
                  level = G.GAME.hands['Flush House'].level })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = true
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = nil
                    return true
                end
            }))
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+'..tostring(1) })
            delay(1.3)
            level_up_hand(card, "Flush House", true, 1)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, 
                {handname=localize('Flush House', 'poker_hands'), 
                 chips = G.GAME.hands['Flush House'].chips, 
                 mult = G.GAME.hands['Flush House'].mult, 
                 level=G.GAME.hands['Flush House'].level})
            delay(1.3)
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                { handname = localize('Flush Five', 'poker_hands'), 
                  chips = G.GAME.hands['Flush Five'].chips, 
                  mult = G.GAME.hands['Flush Five'].mult, 
                  level = G.GAME.hands['Flush Five'].level })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = true
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = nil
                    return true
                end
            }))
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+'..tostring(1) })
            delay(1.3)
            level_up_hand(card, "Flush Five", true, 1)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, 
                {handname=localize('Flush Five', 'poker_hands'), 
                 chips = G.GAME.hands['Flush Five'].chips, 
                 mult = G.GAME.hands['Flush Five'].mult, 
                 level=G.GAME.hands['Flush Five'].level})
            delay(1.3)
    end,
    can_use = function(self, card)
        return true
    end
}

SMODS.Consumable {
    key = 'kindness',
    set = 'Planet',
    pos = { x = 1, y = 0 },
    config = { extra = {
        hand_type = "High Card",
        levels = 1,
        hand_type = "Pair",
        hand_type = "Three of a Kind",
        hand_type = "Four of a Kind",
        hand_type = "Five of a Kind"
    } },
    loc_txt = {
        name = 'Kindness',
        text = {
        [1] = 'Levels up: {C:attention}High Card{}, {C:attention}Pair{},',
        [2] = '{C:attention}Three of a Kind{}, {C:attention}Four of a Kind{},',
        [3] = '{C:attention}Five of a Kind{}'
    }
    },
    cost = 5,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'Planets',
    use = function(self, card, area, copier)
        local used_card = copier or card
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                { handname = localize('High Card', 'poker_hands'), 
                  chips = G.GAME.hands['High Card'].chips, 
                  mult = G.GAME.hands['High Card'].mult, 
                  level = G.GAME.hands['High Card'].level })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = true
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = nil
                    return true
                end
            }))
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+'..tostring(1) })
            delay(1.3)
            level_up_hand(card, "High Card", true, 1)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, 
                {handname=localize('High Card', 'poker_hands'), 
                 chips = G.GAME.hands['High Card'].chips, 
                 mult = G.GAME.hands['High Card'].mult, 
                 level=G.GAME.hands['High Card'].level})
            delay(1.3)
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                { handname = localize('Pair', 'poker_hands'), 
                  chips = G.GAME.hands['Pair'].chips, 
                  mult = G.GAME.hands['Pair'].mult, 
                  level = G.GAME.hands['Pair'].level })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = true
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = nil
                    return true
                end
            }))
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+'..tostring(1) })
            delay(1.3)
            level_up_hand(card, "Pair", true, 1)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, 
                {handname=localize('Pair', 'poker_hands'), 
                 chips = G.GAME.hands['Pair'].chips, 
                 mult = G.GAME.hands['Pair'].mult, 
                 level=G.GAME.hands['Pair'].level})
            delay(1.3)
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                { handname = localize('Three of a Kind', 'poker_hands'), 
                  chips = G.GAME.hands['Three of a Kind'].chips, 
                  mult = G.GAME.hands['Three of a Kind'].mult, 
                  level = G.GAME.hands['Three of a Kind'].level })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = true
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = nil
                    return true
                end
            }))
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+'..tostring(1) })
            delay(1.3)
            level_up_hand(card, "Three of a Kind", true, 1)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, 
                {handname=localize('Three of a Kind', 'poker_hands'), 
                 chips = G.GAME.hands['Three of a Kind'].chips, 
                 mult = G.GAME.hands['Three of a Kind'].mult, 
                 level=G.GAME.hands['Three of a Kind'].level})
            delay(1.3)
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                { handname = localize('Four of a Kind', 'poker_hands'), 
                  chips = G.GAME.hands['Four of a Kind'].chips, 
                  mult = G.GAME.hands['Four of a Kind'].mult, 
                  level = G.GAME.hands['Four of a Kind'].level })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = true
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = nil
                    return true
                end
            }))
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+'..tostring(1) })
            delay(1.3)
            level_up_hand(card, "Four of a Kind", true, 1)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, 
                {handname=localize('Four of a Kind', 'poker_hands'), 
                 chips = G.GAME.hands['Four of a Kind'].chips, 
                 mult = G.GAME.hands['Four of a Kind'].mult, 
                 level=G.GAME.hands['Four of a Kind'].level})
            delay(1.3)
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                { handname = localize('Five of a Kind', 'poker_hands'), 
                  chips = G.GAME.hands['Five of a Kind'].chips, 
                  mult = G.GAME.hands['Five of a Kind'].mult, 
                  level = G.GAME.hands['Five of a Kind'].level })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = true
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = nil
                    return true
                end
            }))
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+'..tostring(1) })
            delay(1.3)
            level_up_hand(card, "Five of a Kind", true, 1)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, 
                {handname=localize('Five of a Kind', 'poker_hands'), 
                 chips = G.GAME.hands['Five of a Kind'].chips, 
                 mult = G.GAME.hands['Five of a Kind'].mult, 
                 level=G.GAME.hands['Five of a Kind'].level})
            delay(1.3)
    end,
    can_use = function(self, card)
        return true
    end
}