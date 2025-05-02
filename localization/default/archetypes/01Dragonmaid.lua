return {
    descriptions = {
        Joker = {
            j_joy_dmaid_kitchen = {
                name = "{C:joy_effect}Kitchen Dragonmaid",
                text = {
                    {
                        "{C:attention}#1#{} free {C:green}Reroll{} for each",
                        "{C:joy_normal}\"Dragonmaid\"{} when obtained",
                    },
                    {
                        "{C:attention}Transforms{} into {C:joy_effect}\"Dragonmaid Tinkhec\"",
                        "when {C:attention}Blind{} is selected",
                    }
                },
            },
            j_joy_dmaid_tinkhec = {
                name = "{C:joy_effect}Dragonmaid Tinkhec",
                text = {
                    {
                        "{C:joy_normal}\"Dragonmaids\"{} each",
                        "give {C:mult}+#1#{} Mult",
                    },
                    {
                        "{C:attention}Transforms{} into {C:joy_effect}\"Kitchen Dragonmaid\"",
                        "at end of round",
                    }
                },
            },
            j_joy_dmaid_parlor = {
                name = "{C:joy_effect}Parlor Dragonmaid",
                text = {
                    {
                        "{C:attention}#1# Booster Tag{} when obtained",
                        "if you own {C:attention}#2#{} {C:joy_normal}\"Dragonmaids\"{},",
                        "gaining an extra for every {C:attention}#3#{} more",
                        "and send {C:attention}#4#{} {C:joy_normal}\"Dragonmaid\"{} to the {C:attention}GY{}",
                    },
                    {
                        "{C:attention}Transforms{} into {C:joy_effect}\"Dragonmaid Lorpar\"",
                        "when {C:attention}Blind{} is selected",
                    },
                },
            },
            j_joy_dmaid_lorpar = {
                name = "{C:joy_effect}Dragonmaid Lorpar",
                text = {
                    {
                        "{C:joy_normal}\"Dragonmaids\"{} each",
                        "give {X:mult,C:white}X#1#{} Mult",
                    },
                    {
                        "{C:attention}Transforms{} into {C:joy_effect}\"Parlor Dragonmaid\"",
                        "at end of round",
                    },
                },
            },
            j_joy_dmaid_nurse = {
                name = "{C:joy_effect}Nurse Dragonmaid",
                text = {
                    {
                        "{C:green}#1# in #2#{} chance to {C:attention}revive #3#{}",
                        "{C:blue}Common{} {C:joy_normal}\"Dragonmaid\"{} when obtained",
                    },
                    {
                        "{C:attention}Transforms{} into {C:joy_effect}\"Dragonmaid Ernus\"",
                        "when {C:attention}Blind{} is selected",
                    },
                },
            },
            j_joy_dmaid_ernus = {
                name = "{C:joy_effect}Dragonmaid Ernus",
                text = {
                    {
                        "{C:mult}+#1#{} Mult for each",
                        "{C:joy_normal}\"Dragonmaid\"{} in the {C:attention}GY{}",
                    },
                    {
                        "{C:attention}Transforms{} into {C:joy_effect}\"Nurse Dragonmaid\"",
                        "at end of round",
                    },
                },
            },
            j_joy_dmaid_laundry = {
                name = "{C:joy_effect}Laundry Dragonmaid",
                text = {
                    {
                        "Sends {C:attention}#1#{} {C:joy_normal}Main Deck{} {C:joy_normal}\"Dragonmaid\"{}",
                        "to the {C:attention}GY{} when obtained",
                    },
                    {
                        "{C:attention}Transforms{} into {C:joy_effect}\"Dragonmaid Nudyarl\"",
                        "when {C:attention}Blind{} is selected",
                    },
                },
            },
            j_joy_dmaid_nudyarl = {
                name = "{C:joy_effect}Dragonmaid Nudyarl",
                text = {
                    {
                        "{C:chips}+#1#{} Chips for each",
                        "{C:joy_normal}\"Dragonmaid\"{} in the {C:attention}GY{}",
                    },
                    {
                        "{C:attention}Transforms{} into {C:joy_effect}\"Laundry Dragonmaid\"",
                        "at end of round",
                    },
                },
            },
            j_joy_dmaid_chamber = {
                name = "{C:joy_effect}Chamber Dragonmaid",
                text = {
                    {
                        "{C:attention}#1# Voucher Tag{} when obtained",
                        "if you own {C:attention}#2#{} {C:joy_normal}\"Dragonmaids\"{},",
                        "gaining an extra for every {C:attention}#3#{} more",
                        "and send {C:attention}#4#{} {C:joy_normal}\"Dragonmaid\"{} to the {C:attention}GY{}",
                    },
                    {
                        "{C:attention}Transforms{} into {C:joy_effect}\"Dragonmaid Stern\"",
                        "when {C:attention}Blind{} is selected",
                    },
                },
            },
            j_joy_dmaid_stern = {
                name = "{C:joy_effect}Dragonmaid Stern",
                text = {
                    {
                        "{C:green}#1# in #2#{} chance to {C:attention}revive #3#{}",
                        "{C:green}Uncommon{} or {C:red}Rare{} {C:joy_normal}\"Dragonmaid\"{}",
                        "when obtained",
                    },
                    {
                        "{C:attention}Transforms{} into {C:joy_effect}\"Chamber Dragonmaid\"",
                        "at end of round",
                    },
                },
            },
            j_joy_dmaid_lady = {
                name = "{C:joy_fusion}Lady's Dragonmaid",
                text = {
                    {
                        "Adds {C:joy_fusion}\"House Dragonmaid\"{} to the",
                        "{C:joy_spell}Extra Deck{} when summoned",
                        "{C:inactive}(Must have room){}",
                    },
                    {
                        "{C:green}#1# in #2#{} chance to {C:attention}transform{} into an",
                        "{C:green}Uncommon{} {C:joy_normal}\"Dragonmaid\"{}",
                        "when {C:attention}Blind{} is selected",
                    },
                },
                joy_summon_conditions = {
                    "{C:attention}2{} {C:attention}Jokers{},",
                    "including a {C:joy_normal}\"Dragonmaid\"{}"
                }
            },
            j_joy_dmaid_house = {
                name = "{C:joy_fusion}House Dragonmaid",
                text = {
                    {
                        "{X:mult,C:white}X#1#{} Mult for each {C:joy_normal}\"Dragonmaid\"{}",
                        "{C:inactive}(Currently{} {X:mult,C:white}X#2#{} {C:inactive}Mult){}",
                    },
                    {
                        "{C:attention}Jokers{} in the {C:attention}GY{} count for",
                        "{C:joy_normal}\"Dragonmaid\"{} abilities",
                    },
                    {
                        "{C:attention}Transforms{} into {C:joy_fusion}\"Dragonmaid Sheou\"",
                        "after {C:attention}#3#{} rounds {C:inactive}(#4#/#3#){}",
                    },
                },
                joy_summon_conditions = {
                    "{C:attention}2{} {C:joy_normal}\"Dragonmaids\"{}"
                }
            },
            j_joy_dmaid_sheou = {
                name = "{C:joy_fusion}Dragonmaid Sheou",
                text = {
                    {
                        "{C:attention}Jokers{} in the {C:attention}GY{} count for",
                        "{C:joy_normal}\"Dragonmaid\"{} abilities",
                    },
                    {
                        "When {C:attention}Boss Blind{} is selected,",
                        "disables its effects then {C:attention}transforms{} into",
                        "{C:joy_fusion}\"House Dragonmaid\"{} and creates {C:attention}#1#{}",
                        "{C:blue}Common{} {C:joy_normal}\"Dragonmaid\"{}",
                        "{C:inactive}(Must have room){}",
                    },
                },
            },
        }
    },
    misc = {
        dictionary = {
            k_joy_archetype_dmaid = "Dragonmaid",
        }
    }
}
