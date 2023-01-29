/datum/species/human
	name = "Human"
	id = "human"
	flavor_text = "One of the most well-known species across the stars. Most enjoy fried foods, and dislike raw or uncooked meats."
	default_color = "FFF"
	species_traits = list(
		EYECOLOR,
		HAIR,
		FACEHAIR,
		LIPS,
		HAS_FLESH,
		HAS_BONE,
	)
	default_mutant_bodyparts = list(
		"ears" = ACC_NONE,
		"tail" = ACC_NONE,
		"wings" = ACC_NONE,
	)
	use_skintones = 1
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = GROSS | RAW | CLOTH
	liked_food = JUNKFOOD | FRIED
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	payday_modifier = 1
