/datum/species/vox
	// Bird-like humanoids
	name = "Vox"
	id = "vox"
	flavor_text = "Bird-like humanoids. Require nitrogen to breathe, rather than oxygen."
	eyes_icon = 'icons/mob/species/vox_eyes.dmi'
	limbs_icon = 'icons/mob/species/vox_parts_greyscale.dmi'
	say_mod = "shrieks"
	default_color = "0F0"
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE,
		HAIR,
		FACEHAIR,
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_RESISTCOLD,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutantlungs = /obj/item/organ/lungs/vox
	mutantbrain = /obj/item/organ/brain/vox
	mutanttongue = /obj/item/organ/tongue/avian
	breathid = "n2"
	default_mutant_bodyparts = list(
		"tail" = "Vox Tail",
		"legs" = "Digitigrade Legs",
		"snout" = "Vox Snout",
		"spines" = ACC_RANDOM,
	)
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	liked_food = MEAT | FRIED
	outfit_important_for_life = /datum/outfit/vox
	species_language_holder = /datum/language_holder/vox
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodytype = BODYTYPE_VOX
	snout_bodytype = BODYTYPE_VOX
	learnable_languages = list(
		/datum/language/common,
		/datum/language/vox,
	)
	scream_sounds = list(
		NEUTER = 'sound/voice/voxscream.ogg',
	)

/datum/species/vox/pre_equip_species_outfit(datum/job/J, mob/living/carbon/human/H, visualsOnly = FALSE)
	var/datum/outfit/vox/O = new /datum/outfit/vox
	H.equipOutfit(O, visualsOnly)
	H.internal = H.get_item_for_held_index(2)
	H.update_internals_hud_icon(1)

/datum/species/vox/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_vox_name()

	var/randname = vox_name()

	if(lastname)
		randname += " [lastname]"

	return randname

/datum/species/vox/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	returned["mcolor"] = pick("77DD88", "77DDAA", "77CCDD", "77DDCC")
	returned["mcolor2"] = pick("EEDD88", "EECC88")
	returned["mcolor3"] = pick("222222", "44EEFF", "44FFBB", "8844FF", "332233")
	return returned

/datum/species/vox/get_random_body_markings(list/passed_features)
	var/name = pick(list(
		"Vox",
		"Vox Hive",
		"Vox Nightling",
		"Vox Heart",
		"Vox Tiger",
	))
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings
