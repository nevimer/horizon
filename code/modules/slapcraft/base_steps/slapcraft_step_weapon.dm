/// This steps can check sufficient weapon variables, such as sharpness or force
/datum/slapcraft_step/weapon
	abstract_type = /datum/slapcraft_step/weapon
	insert_item = FALSE
	check_types = FALSE
	list_desc = "sharp implement"
	/// Whether the step requires any sharpness
	var/require_sharpness = TRUE
	/// Required force of the item.
	var/force = 0

/datum/slapcraft_step/weapon/can_perform(mob/living/user, obj/item/item)
	if(require_sharpness && !item.get_sharpness())
		return FALSE
	if(item.force < force)
		return FALSE
	return TRUE

/datum/slapcraft_step/weapon/play_perform_sound(mob/living/user, obj/item/item, obj/item/slapcraft_assembly/assembly)
	// Sharpness was required, so play a slicing sound
	if(require_sharpness)
		playsound(assembly, 'sound/weapons/slice.ogg', 50, TRUE, -1)
	// Else, play an attack sound if there is one.
	else if (item.hitsound)
		playsound(assembly, item.hitsound, 50, TRUE, -1)

/datum/slapcraft_step/weapon/sharp
	require_sharpness = TRUE
