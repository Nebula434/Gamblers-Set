--- Hexcode: #f84ea6
--- Alt idea for joker, 'When played, this card will be replaced with a random card from your deck.'
--- GOAL: The "number" is meant to be a random number between 1 & 4
--- !!ROLLED AT THE START OF THE HAND!!
--- If the number falls on 1, the first card scored will re-trigger 2 times
--- if it falls on 2, the first card will apply 100 chips on trigger
--- if it falls on 3, the first card will apply a x3 mult on current mult.
--- if it falls on 4, the first card will do nothing, temporarily debuffing.
SMODS.Atlas {
    key = 'set',
    path = "gambler_joker.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = 'Joker',
    name = 'Gamblers Roll',
    loc_vars = function(self, info_queue, card)
		return { vars = { 
            1,
            card.ability.extra.chance,
            2,
            card.ability.extra.chips, 
            card.ability.extra.x_mult, 
            colours = 
                { HEX('f84ea6'),
            100
            }
        }
    }
	end,
    loc_txt = {
        label = 'Gambler Joker',
        name = 'Gamblers Roll',
        text = { -- 1/2 chance to re-trigger first card, apply 100 chips, apply x3 mult. or do nothing 
            '{C:green}#1# in #2#{} chance to {V:1}Jackpot{}',
            '{C:green}#1# in #2#{} chance to do nothing.',
            '{V:1}Jackpot{}',
            'On first card scored,{C:Chips}+#100#{} Chips and {X:red,C:white}X3{} Mult{}',
            }
        },
    config = {extra = {chips = 100, x_mult = 3, chance = 2}}, --- TODO VERIFY CHANCE WORKS PROPERLY
    unlocked = true,
    discovered = true,
    rarity = 3,
    atlas = 'Gambler_set',
    pos = {x = 0, y = 0},
    cost = 4,
    calculate = function(self, info_queue, card)
        if context.joker_main and SMODS.pseudorandom_probability(card, 'GamblerJoker', 1, card.ability.extra.chance) then
            return {
                chips = card.ability.extra.chips,
                xmult = card.ability.extra.x_mult,
                }
            end
        end,
}