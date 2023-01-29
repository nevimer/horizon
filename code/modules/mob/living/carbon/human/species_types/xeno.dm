/datum/species/xeno
	// A cloning mistake, crossing human and xenomorph DNA
	name = "Xenomorph Hybrid"
	id = "xeno"
	flavor_text = "While their true origin is unknown, many believe them to be a cross between humanoid and xenomorph DNA. Much less dangerous than their feral cousins. They enjoy meat, but can consume just about anything."
	say_mod = "hisses"
	default_color = "0F0"
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	default_mutant_bodyparts = list(
		"tail" = "Xenomorph Tail",
		"legs" = "Digitigrade Legs",
		"xenodorsal" = ACC_RANDOM,
		"xenohead" = ACC_RANDOM,
		"taur" = ACC_NONE,
	)
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	liked_food = MEAT
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	limbs_icon = 'icons/mob/species/xeno_parts_greyscale.dmi'
	damage_overlay_type = "xeno"
	scream_sounds = list(
		NEUTER = 'sound/voice/hiss6.ogg',
	)
