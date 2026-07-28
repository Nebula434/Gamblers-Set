--- Hexcode: #f84ea6
--- Alt idea for joker, 'When played, this card will be replaced with a random card from your deck.'
--- GOAL: The "number" is meant to be a random number between 1 & 4
--- !!ROLLED AT THE START OF THE HAND!!
--- If the number falls on 1, the first card scored will re-trigger 2 times
--- if it falls on 2, the first card will apply 100 chips on trigger
--- if it falls on 3, the first card will apply a x3 mult on current mult.
--- if it falls on 4, the first card will do nothing, temporarily debuffing.
SMODS.Atlas {
    key = 'gambler_roll',
    path = "gambler_joker.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = 'gambler_roll',
    name = 'Gamblers Roll',
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'Joker')
		return { vars = {
            numerator,
            denominator,
            card.ability.extra.odds,
            card.ability.extra.chips, 
            card.ability.extra.x_mult, 
            colours = 
                { HEX('f84ea6'),
            },
            100,
        }
    }
	end,
    loc_txt = {
        label = 'Gambler Joker',
        name = 'Gamblers Roll',
        text = { -- 1/2 chance to re-trigger first card, apply 100 chips, apply x3 mult. or do nothing 
            '{C:green}#1# in #2#{} chance to {V:1}Jackpot{}',
            '{V:1}Jackpot{}',
            'On first card scored, {X:chips,C:white}+#4#{} Chips and {X:red,C:white}X#5#{} Mult{}',
            }
        },
    config = {
        extra = {
            chips = 100, 
            x_mult = 3, 
            odds = 2,
            roll = 2
        }
    }, --- TODO VERIFY CHANCE WORKS PROPERLY
    unlocked = true,
    discovered = true,
    rarity = 2,
    atlas = 'gambler_roll',
    pos = {x = 0, y = 0},
    cost = 4,
    eternal_compat = false,
    calculate = function(self, card, context)

        if context.individual 
        and context.cardarea == G.play 
        and context.other_card == G.play.cards[1] then

            if SMODS.pseudorandom_probability(
                card,
                'gambler_roll',
                1,
                card.ability.extra.odds
            ) then

                return {
                    message = "Jackpot!",
                    chips = card.ability.extra.chips,
                    x_mult = card.ability.extra.x_mult
                }

            else
                return {
                    message = "No Luck!"
                }
            end
        end
    end
}