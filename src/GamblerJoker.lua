--- Hexcode: 1d4fd7
--- Alt idea for joker, 'When played, this card will be replaced with a random card from your deck.'
--- GOAL: The "number" is meant to be a random number between 1 & 4
--- !!ROLLED AT THE START OF THE HAND!!
--- If the number falls on 1, the first card scored will re-trigger 2 times
--- if it falls on 2, the first card will apply 100 chips on trigger
--- if it falls on 3, the first card will apply a x3 mult on current mult.
--- if it falls on 4, the first card will do nothing, temporarily debuffing.
SMODS.Atlas {
    key = "gambler_set",
    path = "gambler_joker.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "GamblerJoker"
    name = "Gambler's Roll",
    loc_txt = {
        label = 'Gambler Joker',
        name = "Gambler's Roll",
        text = {
            '{C:green}#1# in #4#{} chance to re-trigger first card scored',
            '{C:green}#1# in #4#{} chance to apply 100 chips on first card scored',
            '{C:green}#1# in #4#{} chance to apply {X:}x3{} Mult on first card scored',
            '{C:green}#1# in #4#{} chance to do nothing"
        }
    config = {extra = {mult = 3, chips = 100, x_mult = 3, chance = 4}}, --- TODO VERIFY CHANCE WORKS PROPERLY
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.x_mult, card.ability.extra.chance } }
	end,
        rarity = 2,
        atlas = "gambler_set",
        pos = {x = 0, y = 0},
        cost = 4,
        calculate = function(self, info_queue, card)
            local rolled = math.random(1, 4)
            if rolled == 1 then
                card.ability.extra.mult = 2
            elseif rolled == 2 then
                card.ability.extra.chips = 100
            elseif rolled == 3 then
                card.ability.extra.x_mult = 3
            elseif rolled == 4 then
                -- do nothing
            end
        end
    },
}