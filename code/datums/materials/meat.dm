///It's gross, gets the name of it's owner, and is all kinds of fucked up
/datum/material/meat
	name = "meat"
	desc = "Meat"
	id = /datum/material/meat // So the bespoke versions are categorized under this
	color = rgb(214, 67, 67)
	greyscale_colors = rgb(214, 67, 67)
	categories = list(MAT_CATEGORY_RIGID = TRUE, MAT_CATEGORY_BASE_RECIPES = TRUE, MAT_CATEGORY_ITEM_MATERIAL=TRUE)
	sheet_type = /obj/item/stack/sheet/meat
	value_per_unit = 0.05
	strength_modifier = 0.7
	armor_modifiers = list(MELEE = 0.3, BULLET = 0.3, LASER = 1.2, ENERGY = 1.2, BOMB = 0.3, BIO = 0, RAD = 0.7, FIRE = 1, ACID = 1)
	item_sound_override = 'sound/effects/meatslap.ogg'
	turf_sound_override = FOOTSTEP_MEAT
	texture_layer_icon_state = "meat"

/datum/material/meat/mob_meat
	init_flags = MATERIAL_INIT_BESPOKE
	var/subjectname = ""
	var/subjectjob = null

/datum/material/meat/mob_meat/Initialize(_id, mob/living/source)
	if(!istype(source))
		return FALSE

	name = "[source?.name ? "[source.name]'s" : "mystery"] [initial(name)]"

	if(source.real_name)
		subjectname = source.real_name
	else if(source.name)
		subjectname = source.name

	if(ishuman(source))
		var/mob/living/carbon/human/human_source = source
		subjectjob = human_source.job

	return ..()

/datum/material/meat/species_meat
	init_flags = MATERIAL_INIT_BESPOKE

/datum/material/meat/species_meat/Initialize(_id, datum/species/source)
	if(!istype(source))
		return FALSE

	name = "[source?.name || "mystery"] [initial(name)]"
	return ..()
