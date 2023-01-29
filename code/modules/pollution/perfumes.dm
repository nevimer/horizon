/obj/item/perfume
	desc = "A bottle of pleasantly smelling fragrance."
	icon = 'icons/obj/items/perfume.dmi'
	icon_state = "perfume"
	inhand_icon_state = "cleaner"
	worn_icon_state = "spraybottle"
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	item_flags = NOBLUDGEON
	/// What type of the pollutant will this perfume be using
	var/fragrance_type
	/// How many uses remaining has it got
	var/uses_remaining = 10
	/// Whether the cap of the perfume is on or off
	var/cap = TRUE
	/// Whether we have a cap or not
	var/has_cap = TRUE

/obj/item/perfume/Initialize()
	. = ..()
	update_appearance()

/obj/item/perfume/update_icon_state()
	icon_state = (has_cap && cap) ? "[initial(icon_state)]_cap" : initial(icon_state)
	return ..()

/obj/item/perfume/examine(mob/user)
	. = ..()
	if(uses_remaining)
		. += "It has [uses_remaining] use\s left."
	else
		. += "It is empty."
	if(has_cap)
		. += SPAN_NOTICE("Alt-click [src] to [ cap ? "take the cap off" : "put the cap on"].")

/obj/item/perfume/AltClick(mob/user)
	if(has_cap && user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY, FALSE, TRUE))
		cap = !cap
		to_chat(user, SPAN_NOTICE("The cap on [src] is now [cap ? "on" : "off"]."))
		update_appearance()

/obj/item/perfume/afterattack(atom/attacked, mob/user, proximity)
	. = ..()
	if(.)
		return
	if(!ismovable(attacked))
		return
	if(has_cap && cap)
		to_chat(user, SPAN_WARNING("Take the cap off first!"))
		return TRUE
	if(uses_remaining <= 0)
		to_chat(user, SPAN_WARNING("\The [src] is empty!"))
		return TRUE
	uses_remaining--
	var/turf/my_turf = get_turf(user)
	my_turf.pollute_turf(fragrance_type, 20)
	user.visible_message(SPAN_NOTICE("[user] sprays [attacked] with \the [src]."), SPAN_NOTICE("You spray [attacked] with \the [src]."))
	user.changeNext_move(CLICK_CD_RANGE*2)
	playsound(my_turf, 'sound/effects/spray2.ogg', 50, TRUE, -6)
	attacked.AddComponent(/datum/component/temporary_pollution_emission, fragrance_type, 5, 30 MINUTES)

/obj/item/perfume/cologne
	name = "cologne bottle"
	desc = "This one is sure to attract ladies."
	fragrance_type = /datum/pollutant/fragrance/cologne

/obj/item/perfume/wood
	name = "wood perfume bottle"
	fragrance_type = /datum/pollutant/fragrance/wood

/obj/item/perfume/rose
	name = "rose perfume bottle"
	fragrance_type = /datum/pollutant/fragrance/rose

/obj/item/perfume/jasmine
	name = "jasmine perfume bottle"
	fragrance_type = /datum/pollutant/fragrance/jasmine

/obj/item/perfume/mint
	name = "mint perfume bottle"
	fragrance_type = /datum/pollutant/fragrance/mint

/obj/item/perfume/vanilla
	name = "vanilla perfume bottle"
	fragrance_type = /datum/pollutant/fragrance/vanilla

/obj/item/perfume/pear
	name = "pear perfume bottle"
	fragrance_type = /datum/pollutant/fragrance/pear

/obj/item/perfume/strawberry
	name = "strawberry perfume bottle"
	fragrance_type = /datum/pollutant/fragrance/strawberry

/obj/item/perfume/cherry
	name = "cherry perfume bottle"
	fragrance_type = /datum/pollutant/fragrance/cherry

/obj/item/perfume/amber
	name = "amber perfume bottle"
	fragrance_type = /datum/pollutant/fragrance/amber

/obj/item/perfume/nectarine
	name = "nectarine perfume bottle"
	fragrance_type = /datum/pollutant/fragrance/nectarine
