/datum/species/robotic
	say_mod = "beeps"
	default_color = "0F0"
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_RADIMMUNE,
		TRAIT_VIRUSIMMUNE,
		TRAIT_NOBREATH,
		TRAIT_TOXIMMUNE,
		TRAIT_NOCLONELOSS,
		TRAIT_GENELESS,
		TRAIT_STABLEHEART,
		TRAIT_LIMBATTACHMENT,
		TRAIT_NO_HUSK,
		TRAIT_OXYIMMUNE,
	)
	mutant_bodyparts = list()
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	reagent_flags = PROCESS_SYNTHETIC
	coldmod = 0.5
	burnmod = 1.1
	heatmod = 1.2
	brutemod = 1.1
	siemens_coeff = 1.2 //Not more because some shocks will outright crit you, which is very unfun
	mutant_organs = list(/obj/item/organ/cyberimp/arm/power_cord)
	mutantbrain = /obj/item/organ/brain/ipc_positron
	mutantstomach = /obj/item/organ/stomach/robot_ipc
	mutantears = /obj/item/organ/ears/robot_ipc
	mutanttongue = /obj/item/organ/tongue/robot_ipc
	mutanteyes = /obj/item/organ/eyes/robot_ipc
	mutantlungs = /obj/item/organ/lungs/robot_ipc
	mutantheart = /obj/item/organ/heart/robot_ipc
	mutantliver = /obj/item/organ/liver/robot_ipc
	exotic_blood = /datum/reagent/fuel/oil
	scream_sounds = list(
		NEUTER = 'sound/voice/scream_silicon.ogg',
	)
	species_descriptors = list(
		/datum/descriptor/age/robot
	)

/datum/species/robotic/spec_life(mob/living/carbon/human/H)
	// Deal damage when we're in crit because otherwise robotics can't die (immune to oxyloss)
	if(H.stat == SOFT_CRIT || H.stat == HARD_CRIT)
		H.adjustFireLoss(1)
		if(prob(10))
			to_chat(H, SPAN_WARNING("Alert: Critical damage taken! Cooling systems failing!"))
			do_sparks(3, TRUE, H)

/datum/species/robotic/spec_revival(mob/living/carbon/human/H)
	playsound(H.loc, 'sound/machines/chime.ogg', 50, 1, -1)
	H.visible_message(SPAN_NOTICE("[H]'s monitor lights up."), SPAN_NOTICE("All systems nominal. You're back online!"))

/datum/species/robotic/on_species_gain(mob/living/carbon/human/C)
	. = ..()
	var/obj/item/organ/appendix/appendix = C.getorganslot(ORGAN_SLOT_APPENDIX)
	if(appendix)
		appendix.Remove(C)
		qdel(appendix)

/datum/species/robotic/random_name(gender,unique,lastname)
	var/randname = pick(GLOB.posibrain_names)
	randname = "[randname]-[rand(100, 999)]"
	return randname

/datum/species/robotic/ipc
	name = "I.P.C."
	id = "ipc"
	flavor_text = "A robotic lifeform. Most sport a screen, instead of a humanoid face. Surface level damage is easy to repair, but they're sensitive to electronic disruptions."
	species_traits = list(
		ROBOTIC_DNA_ORGANS,
		MUTCOLORS_PARTSONLY,
		EYECOLOR,
		LIPS,
		HAIR,
		NOEYESPRITES,
		ROBOTIC_LIMBS,
		NOTRANSSTING,
		REVIVES_BY_HEALING,
	)
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"ipc_antenna" = ACC_RANDOM,
		"ipc_screen" = ACC_RANDOM,
		"ipc_chassis" = ACC_RANDOM,
	)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	limbs_icon = 'icons/mob/species/ipc_parts.dmi'
	hair_alpha = 210
	sexes = 0
	var/datum/action/innate/monitor_change/screen
	var/saved_screen = "Blank"

/datum/species/robotic/ipc/spec_revival(mob/living/carbon/human/H)
	. = ..()
	//TODO: fix this
	/*H.dna.mutant_bodyparts["ipc_screen"][MUTANT_INDEX_NAME] = "BSOD"
	sleep(3 SECONDS)*/
	H.dna.mutant_bodyparts["ipc_screen"][MUTANT_INDEX_NAME] = saved_screen

/datum/species/robotic/ipc/spec_death(gibbed, mob/living/carbon/human/H)
	. = ..()
	saved_screen = H.dna.mutant_bodyparts["ipc_screen"][MUTANT_INDEX_NAME]
	//TODO: fix this
	/*H.dna.mutant_bodyparts["ipc_screen"][MUTANT_INDEX_NAME] = "BSOD"
	sleep(3 SECONDS)*/
	H.dna.mutant_bodyparts["ipc_screen"][MUTANT_INDEX_NAME] = "Blank"

/datum/species/robotic/ipc/on_species_gain(mob/living/carbon/human/C)
	. = ..()
	if(!screen)
		screen = new
		screen.Grant(C)
	var/chassis = C.dna.mutant_bodyparts["ipc_chassis"]
	if(!chassis)
		return
	var/datum/sprite_accessory/ipc_chassis/chassis_of_choice = GLOB.sprite_accessories["ipc_chassis"][chassis[MUTANT_INDEX_NAME]]
	if(chassis_of_choice)
		limbs_id = chassis_of_choice.icon_state
		if(chassis_of_choice.color_src)
			species_traits += MUTCOLORS
		C.update_body()

/datum/species/robotic/ipc/on_species_loss(mob/living/carbon/human/C)
	. = ..()
	if(screen)
		screen.Remove(C)
	..()

/datum/action/innate/monitor_change
	name = "Screen Change"
	check_flags = AB_CHECK_CONSCIOUS
	icon_icon = 'icons/mob/actions/actions_silicon.dmi'
	button_icon_state = "drone_vision"

/datum/action/innate/monitor_change/Activate()
	var/mob/living/carbon/human/H = owner
	var/new_ipc_screen = input(usr, "Choose your character's screen:", "Monitor Display") as null|anything in GLOB.sprite_accessories["ipc_screen"]
	if(!new_ipc_screen)
		return
	H.dna.species.mutant_bodyparts["ipc_screen"][MUTANT_INDEX_NAME] = new_ipc_screen
	H.update_body()

/datum/species/robotic/synthliz
	name = "Synthetic Lizardperson"
	id = "synthliz"
	flavor_text = "A robotic lifeform. This model looks similar to reptiles. Surface level damage is easy to repair, but they're sensitive to electronic disruptions."
	species_traits = list(
		ROBOTIC_DNA_ORGANS,
		MUTCOLORS,EYECOLOR,
		LIPS,
		HAIR,
		ROBOTIC_LIMBS,
		NOTRANSSTING,
		REVIVES_BY_HEALING,
	)
	default_mutant_bodyparts = list(
		"ipc_antenna" = ACC_RANDOM,
		"tail" = ACC_RANDOM,
		"snout" = ACC_RANDOM,
		"legs" = "Digitigrade Legs",
		"taur" = ACC_NONE,
	)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	limbs_icon = 'icons/mob/species/synthliz_parts_greyscale.dmi'

/datum/species/robotic/synthliz/get_random_body_markings(list/passed_features)
	var/name = pick("Synth Pecs Lights", "Synth Scutes", "Synth Pecs")
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/datum/species/robotic/synth_anthro
	name = "Synthetic Anthromorph"
	id = "synthanthro"
	flavor_text = "A robotic lifeform. This model is designed to appear similar to anthromorphs. Surface level damage is easy to repair, but they're sensitive to electronic disruptions."
	species_traits = list(
		ROBOTIC_DNA_ORGANS,
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAIR,
		ROBOTIC_LIMBS,
		NOTRANSSTING,
		REVIVES_BY_HEALING,
	)
	default_mutant_bodyparts = list(
		"tail" = ACC_RANDOM,
		"snout" = ACC_RANDOM,
		"horns" = ACC_NONE,
		"ears" = ACC_RANDOM,
		"legs" = ACC_RANDOM,
		"taur" = ACC_NONE,
		"wings" = ACC_NONE,
		"neck" = ACC_NONE,
	)
	limbs_icon = 'icons/mob/species/mammal_parts_greyscale.dmi'
	limbs_id = "mammal"

// Somewhat of a paste from the mammal's random features, because they're supposed to mimick them in appearance.
/datum/species/robotic/synth_anthro/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	var/main_color
	var/second_color
	var/third_color
	var/random = rand(1,7)
	switch(random)
		if(1)
			main_color = "FFFFFF"
			second_color = "333333"
			third_color = "333333"
		if(2)
			main_color = "FFFFDD"
			second_color = "DD6611"
			third_color = "AA5522"
		if(3)
			main_color = "DD6611"
			second_color = "FFFFFF"
			third_color = "DD6611"
		if(4)
			main_color = "CCCCCC"
			second_color = "FFFFFF"
			third_color = "FFFFFF"
		if(5)
			main_color = "AA5522"
			second_color = "CC8833"
			third_color = "FFFFFF"
		if(6)
			main_color = "FFFFDD"
			second_color = "FFEECC"
			third_color = "FFDDBB"
		if(7) //Oh no you've rolled the sparkle dog
			main_color = random_color()
			second_color = random_color()
			third_color = random_color()
	returned["mcolor"] = main_color
	returned["mcolor2"] = second_color
	returned["mcolor3"] = third_color
	return returned
