/datum/sprite_accessory/ethereal_horns
	icon = 'icons/mob/human/species/ethereal/ethereal_horns.dmi'
	color_src = USE_ONE_COLOR
	key = "ethereal_horns"
	generic = "Ethereal Horns"
	genetic = TRUE
	organ_type = /obj/item/organ/external/ethereal_horns
	relevent_layers = list(BODY_FRONT_LAYER, BODY_ADJ_LAYER)
	recommended_species = list(SPECIES_ETHEREAL)

/datum/sprite_accessory/ethereal_horns/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	factual = FALSE
	color_src = null

/datum/sprite_accessory/ethereal_horns/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/ethereal_horns/helm
	name = "Helm"
	icon_state = "helm"

/datum/sprite_accessory/ethereal_horns/lunar
	name = "Lunar"
	icon_state = "lunar"

/datum/sprite_accessory/ethereal_horns/inward
	name = "Inward"
	icon_state = "inward"

/datum/sprite_accessory/ethereal_horns/majesty
	name = "Majesty"
	icon_state = "majesty"

/datum/sprite_accessory/ethereal_horns/clipped
	name = "Clipped"
	icon_state = "clipped"

/datum/sprite_accessory/ethereal_horns/sharp
	name = "Sharp"
	icon_state = "sharp"

/datum/sprite_accessory/tails/ethereal
	icon = 'icons/mob/human/species/ethereal/ethereal_tail.dmi'
	color_src = USE_ONE_COLOR
	relevent_layers = list(EXTERNAL_FRONT, EXTERNAL_BEHIND)
	recommended_species = list(SPECIES_ETHEREAL)
	organ_type = /obj/item/organ/external/tail/ethereal

/datum/sprite_accessory/tails/ethereal/long
	name = "Ethereal - Long"
	icon_state = "ethlong"

/datum/sprite_accessory/tails/ethereal/bifurcated
	name = "Ethereal - Bifurcated"
	icon_state = "ethbifurcated"

/datum/sprite_accessory/tails/ethereal/stubby
	name = "Ethereal - Stubby"
	icon_state = "ethstubby"
