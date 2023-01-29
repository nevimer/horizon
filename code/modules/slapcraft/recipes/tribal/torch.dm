/datum/slapcraft_recipe/torch
	name = "torch"
	examine_hint = "You could craft a torch, starting by adding dried leaf to a log..."
	category = SLAP_CAT_TRIBAL
	steps = list(
	/datum/slapcraft_step/log,
	/datum/slapcraft_step/dried_leaf,
	/datum/slapcraft_step/tool/knife/carve_torch
	)
	result_type = /obj/item/flashlight/flare/torch

/datum/slapcraft_step/log
	desc = "Start with a log."
	finished_desc = "A dried leaf has been added."
	item_types = list(/obj/item/grown/log)
	blacklist_item_types = list(
	/obj/item/grown/log/steel,
	/obj/item/grown/log/bamboo
	)

/datum/slapcraft_step/dried_leaf
	desc = "Add a dried leaf to a log."
	finished_desc = "A dried leaf has been added."

	start_msg = "%USER% begins wrapping the log with some dried leaf."
	start_msg_self = "You begin wrapping the log with some dried leaf."
	finish_msg = "%USER% wraps the log with some dried leaf."
	finish_msg_self = "You wrap the log with some dried leaf."
	item_types = list(
	/obj/item/food/grown/tobacco,
	/obj/item/food/grown/tea,
	/obj/item/food/grown/ash_flora/mushroom_leaf,
	/obj/item/food/grown/ambrosia/vulgaris,
	/obj/item/food/grown/ambrosia/deus,
	/obj/item/food/grown/wheat
	)

/datum/slapcraft_step/dried_leaf/can_perform(mob/living/user, obj/item/item, obj/item/slapcraft_assembly/assembly)
	if(!HAS_TRAIT(item, TRAIT_DRIED))
		return FALSE
	return TRUE

/datum/slapcraft_step/tool/knife/carve_torch
	desc = "Carve the torch from a log."
	todo_desc = "You could carve out the torch and piece it together..."

	start_msg = "%USER% begins to cobble the torch together."
	start_msg_self = "You begin to cobble the torch together."
	finish_msg = "%USER% finishes cobbling the torch together."
	finish_msg_self = "You finish cobbling the torch together."
