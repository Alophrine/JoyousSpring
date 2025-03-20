JoyousSpring.get_graveyard_count = function()
    if not JoyousSpring.graveyard then return 0 end

    local total = 0
    for _, t in pairs(JoyousSpring.graveyard) do
        total = total + t.count
    end
    return total
end

---Get all materials in G.jokers that fulfill **property_list**
---@param property_list material_properties[]
---@param different_names boolean?
---@param for_tribute boolean?
---@return Card[]
JoyousSpring.get_materials_owned = function(property_list, different_names, for_tribute)
    if not G.jokers then return {} end

    local materials = {}
    local keys = {}
    for _, joker in ipairs(G.jokers.cards) do
        if not property_list or #property_list == 0 then
            if not keys[joker.config.center_key] or not different_names then
                table.insert(materials, joker)
                keys[joker.config.center_key] = true
            end
        else
            for _, property in ipairs(property_list) do
                if keys[joker.config.center_key] and different_names then
                    break
                end
                if JoyousSpring.is_material(joker, property, for_tribute and "TRIBUTE" or nil) then
                    table.insert(materials, joker)
                    keys[joker.config.center_key] = true
                    break
                end
            end
        end
    end
    return materials
end

---Count all materials in G.jokers that fulfill **property_list**
---@param property_list material_properties[]
---@param different_names boolean?
---@return integer
JoyousSpring.count_materials_owned = function(property_list, different_names)
    return #JoyousSpring.get_materials_owned(property_list, different_names)
end

---Get all materials in graveyard that fulfill **property_list**
---@param property_list material_properties[]
---@param to_revive boolean? Checks if it can be revived
---@param different_names boolean?
---@return string[]
JoyousSpring.get_materials_in_graveyard = function(property_list, to_revive, different_names)
    if not JoyousSpring.graveyard then return {} end

    local materials = {}
    for key, t in pairs(JoyousSpring.graveyard) do
        local count = t.count
        local summonable = t.summonable
        if count > 0 then
            if not (to_revive and (G.P_CENTERS[key].config.extra.joyous_spring.cannot_revive or summonable < 1)) then
                if not property_list or #property_list == 0 then
                    for i = 1, (different_names and 1 or count) do
                        table.insert(materials, key)
                    end
                else
                    for _, property in ipairs(property_list) do
                        if JoyousSpring.is_material_center(key, property) then
                            for i = 1, (different_names and 1 or count) do
                                table.insert(materials, key)
                            end
                            break
                        end
                    end
                end
            end
        end
    end
    return materials
end

---Count all materials in graveyard that fulfill **property_list**
---@param property_list material_properties[]
---@param to_revive boolean? Checks if it can be revived
---@param different_names boolean?
---@return integer
JoyousSpring.count_materials_in_graveyard = function(property_list, to_revive, different_names)
    return #JoyousSpring.get_materials_in_graveyard(property_list, to_revive, different_names)
end

---Get the keys to all matrerials in G.jokers and graveyard that fulfill **property_list**
---@param property_list material_properties[]
---@param to_revive boolean? Checks if it can be revived
---@param different_names boolean?
---@return string[]
JoyousSpring.get_all_material_keys = function(property_list, to_revive, different_names)
    local gy = JoyousSpring.get_materials_in_graveyard(property_list, to_revive, different_names)
    local owned = JoyousSpring.get_materials_owned(property_list, different_names)
    for _, card in ipairs(owned) do
        gy[#gy + 1] = card.config.center_key or nil
    end
    return gy
end

---Count all materials in G.jokers and graveyard that fulfill **property_list**
---@param property_list material_properties[]
---@param to_revive boolean? Checks if it can be revived
---@param different_names boolean?
---@return integer
JoyousSpring.count_all_materials = function(property_list, to_revive, different_names)
    return JoyousSpring.count_materials_in_graveyard(property_list, to_revive, different_names) +
        JoyousSpring.count_materials_owned(property_list, different_names)
end

JoyousSpring.get_materials_in_collection = function(property_list)
    local pool = {}
    for k, _ in pairs(G.P_CENTERS) do
        if k:sub(1, 2) == "j_" then
            for _, property in ipairs(property_list) do
                if JoyousSpring.is_material_center(k, property) then
                    table.insert(pool, k)
                end
            end
        end
    end
    return pool
end

---Count all Extra Deck types (Fusion, Synchro, Xyz, Link) are owned
---@return integer
JoyousSpring.extra_deck_types_owned = function()
    local fusion = (JoyousSpring.count_materials_owned({ { summon_type = "FUSION" } }) > 0) and 1 or 0
    local synchro = (JoyousSpring.count_materials_owned({ { summon_type = "SYNCHRO" } }) > 0) and 1 or 0
    local xyz = (JoyousSpring.count_materials_owned({ { summon_type = "XYZ" } }) > 0) and 1 or 0
    local link = (JoyousSpring.count_materials_owned({ { summon_type = "LINK" } }) > 0) and 1 or 0

    return fusion + synchro + xyz + link
end

---Get index of value in array
---@param array table
---@param value any
---@return integer?
JoyousSpring.index_of = function(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return nil
end

---Gets column (index) of joker in G.jokers
---@param joker Card
---@return integer?
JoyousSpring.get_joker_column = function(joker)
    return G.jokers and JoyousSpring.index_of(G.jokers.cards or {}, joker) or 0
end

---Get not owned card in **keys** list
---@param keys string[]
---@param count_debuffed boolean?
---@return table
JoyousSpring.get_not_owned = function(keys, count_debuffed)
    local not_owned = {}
    for _, key in ipairs(keys) do
        if not next(SMODS.find_card(key, count_debuffed)) then
            table.insert(not_owned, key)
        end
    end
    if #not_owned == 0 then
        not_owned = { keys[1] }
    end
    return not_owned
end

---Empties the graveyard
JoyousSpring.empty_graveyard = function()
    for _, t in pairs(JoyousSpring.graveyard) do
        t.count = 0
        t.summonable = 0
    end
end

---Adds a tag that creates a joker with *card_key* to the shop
---@param card_key string
JoyousSpring.add_monster_tag = function(card_key)
    local tag = Tag('tag_joy_monster')
    tag.ability.monster = card_key
    G.GAME.joy_last_monster_tag = card_key
    add_tag(tag)
end

---Flips a random card in *card_list*
---@param card_list table|Card[]
---@param facing? 'front'|'back' If card has to be facing a direction for it to be flipped
---@param seed? string
---@return table|Card|nil
JoyousSpring.flip_random_card = function(source_card, card_list, facing, seed)
    local facing_cards = {}
    for j, card in ipairs(card_list) do
        if not facing or card.facing == facing then
            facing_cards[#facing_cards + 1] = card
        end
    end
    local pick = pseudorandom_element(facing_cards, pseudoseed(seed or "JoyousSpring"))
    if pick then
        pick:flip(source_card)
    end
    return pick
end

---Add random tag. Stolen from Cryptid
JoyousSpring.add_random_tag = function()
    local tag_key = get_next_tag_key("JoyousSpring")
    local i = 0
    while tag_key == "tag_boss" and i < 6 do
        tag_key = get_next_tag_key("JoyousSpring")
        i = i + 1
    end
    tag_key = tag_key ~= "tag_boss" and tag_key or "tag_double"
    local tag = Tag(tag_key)
    if tag.name == "Orbital Tag" then
        local _poker_hands = {}
        for k, v in pairs(G.GAME.hands) do
            if v.visible then
                _poker_hands[#_poker_hands + 1] = k
            end
        end
        tag.ability.orbital_hand = pseudorandom_element(_poker_hands, pseudoseed("cry_pickle_orbital"))
    end
    add_tag(tag)
end

---Checks if a card is a playing card
---@param card table|Card
---@return boolean
JoyousSpring.is_playing_card = function(card)
    return card and (card.ability.set == 'Enhanced' or card.ability.set == 'Default') and true or false
end

---Calculate flips effect activation
---@param card Card|table
---@param context CalcContext|table
---@return boolean `true` if it just activated its flip effect
JoyousSpring.calculate_flip_effect = function(card, context)
    if (context.joy_card_flipped and context.joy_card_flipped == card and card.facing == "front") or
        (context.setting_blind and context.main_eval and JoyousSpring.flip_effect_active(card)) then
        if card.facing == 'back' then
            card:flip(card)
        end
        card.ability.extra.joyous_spring.flip_active = true
        SMODS.calculate_effect({ message = localize("k_joy_flip") }, card)
        SMODS.calculate_context({ joy_flip_activated = card, joy_other_context = context })
        return true
    end
    if not context.blueprint_card and context.end_of_round and context.main_eval and context.game_over == false then
        card.ability.extra.joyous_spring.flip_active = false
        if JoyousSpring.should_trap_flip(card) then
            card:flip(card)
            if card.facing == 'back' then
                SMODS.calculate_effect({ message = localize("k_joy_set") }, card)
            end
        end
    end
    return false
end

---Detach material from Joker
---@param card Card|table
---@param value integer?
JoyousSpring.ease_detach = function(card, value)
    if not JoyousSpring.is_summon_type(card, "XYZ") then
        return
    end
    local value = value or card.ability.extra.detach or 1
    card.ability.extra.joyous_spring.xyz_materials = math.max(0, card.ability.extra.joyous_spring.xyz_materials - value)
end

---Flip all cards in all areas or in *area*
---@param source Card?
---@param flip_direction 'front'|'back'?
---@param areas CardArea[]|table[]?
JoyousSpring.flip_all_cards = function(source, flip_direction, areas)
    local flip_areas = areas or { G.jokers, G.consumeables, G.hand }

    for _, area in ipairs(flip_areas) do
        local any_flipped = false
        for _, card in ipairs(area.cards) do
            if not flip_direction or card.facing ~= flip_direction then
                card:flip(source)
                any_flipped = true
            end
        end
        if flip_direction == 'back' and any_flipped then
            area:shuffle(source and source.config.center.key or "JoyousSpring")
        end
    end
end

---Counts all cards in *areas* (or all areas) flipped in *flip_direction*
---@param flip_direction 'front'|'back'?
---@param areas CardArea[]|table[]?
---@return integer
JoyousSpring.count_flipped = function(flip_direction, areas)
    local flip_areas = areas or { G.jokers, G.consumeables, G.hand }
    local flip_direction = flip_direction or 'back'
    local count = 0
    for _, area in ipairs(flip_areas) do
        for _, card in ipairs(area.cards) do
            if card.facing == flip_direction then
                count = count + 1
            end
        end
    end
    return count
end

---Levels up hand (with proper animation)
---@param card Card|table
---@param hand_key string
---@param instant boolean?
---@param amount integer?
JoyousSpring.level_up_hand = function(card, hand_key, instant, amount)
    if not instant then
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            {
                handname = localize(hand_key, 'poker_hands'),
                chips = G.GAME.hands[hand_key].chips,
                mult = G.GAME.hands[hand_key].mult,
                level = G.GAME.hands[hand_key].level
            })
    end
    level_up_hand(card, hand_key, instant, amount)
    if not instant then
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
            { mult = 0, chips = 0, handname = '', level = '' })
    end
end

JoyousSpring.create_pseudorandom = function(property_list, seed, must_have_room, not_owned, edition, card_limit_modif)
    if not must_have_room or (#G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit + (card_limit_modif or 0)) then
        local choices = JoyousSpring.get_materials_in_collection(property_list)
        if not_owned then
            choices = JoyousSpring.get_not_owned(choices)
        end
        local key_to_add = pseudorandom_element(choices, seed or pseudoseed("JoyousSpring"))
        if key_to_add then
            return SMODS.add_card({
                key = key_to_add,
                edition = edition
            })
        end
    end
    return nil
end

JoyousSpring.get_material_attributes = function(card_list, count_debuffed)
    local attributes = {
        LIGHT = false,
        DARK = false,
        WATER = false,
        FIRE = false,
        EARTH = false,
        WIND = false,
        DIVINE = false
    }
    for _, card in ipairs(card_list) do
        if type(card) == "table" and (not count_debuffed or not card.debuff) and JoyousSpring.is_monster_card(card) then
            if not JoyousSpring.is_all_attributes(card) then
                attributes[card.ability.extra.joyous_spring.attribute] = true
            end
        else
            local card_center = G.P_CENTERS[card]
            if card_center and card_center.config and card_center.config.extra and
                type(card_center.config.extra) == "table" and
                card_center.config.extra.joyous_spring and not card_center.config.extra.joyous_spring.is_all_attributes then
                attributes[card_center.config.extra.joyous_spring.attribute] = true
            end
        end
    end
    for _, card in ipairs(card_list) do
        if type(card) == "table" and (not count_debuffed or not card.debuff) and JoyousSpring.is_monster_card(card) then
            if JoyousSpring.is_all_attributes(card) then
                for k, v in pairs(attributes) do
                    if not v then
                        attributes[k] = true
                        break
                    end
                end
            end
        else
            local card_center = G.P_CENTERS[card]
            if card_center and card_center.config and card_center.config.extra and
                type(card_center.config.extra) == "table" and
                card_center.config.extra.joyous_spring and card_center.config.extra.joyous_spring.is_all_attributes then
                for k, v in pairs(attributes) do
                    if not v then
                        attributes[k] = true
                        break
                    end
                end
            end
        end
    end

    return attributes
end

JoyousSpring.get_attribute_count = function(card_list, count_debuffed)
    local count = 0
    local attributes = JoyousSpring.get_material_attributes(card_list, count_debuffed)
    for k, v in pairs(attributes) do
        if v then
            count = count + 1
        end
    end
    return count
end

--- Talisman compat
to_big = to_big or function(num)
    return num
end
