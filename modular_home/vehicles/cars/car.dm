// /obj/vehicle/sealed/car
// 	layer = ABOVE_MOB_LAYER
// 	anchored = TRUE
// 	default_driver_move = FALSE
// //	var/car_traits = NONE //Bitflag for special behavior such as kidnapping
// //	var/engine_sound = 'sound/vehicles/carrev.ogg'
// 	var/last_enginesound_time
// //	var/engine_sound_length = 20 //Set this to the length of the engine sound
// //	var/escape_time = 200 //Time it takes to break out of the car

// /obj/vehicle/sealed/car/Initialize()
// 	. = ..()
// 	LoadComponent(/datum/component/riding)

// /obj/vehicle/sealed/car/generate_actions()
// 	. = ..()
// 	initialize_controller_action_type(/datum/action/vehicle/sealed/remove_key, VEHICLE_CONTROL_DRIVE)
// 	if(car_traits & CAN_KIDNAP)
// 		initialize_controller_action_type(/datum/action/vehicle/sealed/dump_kidnapped_mobs, VEHICLE_CONTROL_DRIVE)

// /obj/vehicle/sealed/car/driver_move(mob/user, direction)
// 	if(key_type && !is_key(inserted_key))
// 		to_chat(user, "<span class='warning'>[src] has no key inserted!</span>")
// 		return FALSE
// 	var/datum/component/riding/R = GetComponent(/datum/component/riding)
// 	R.handle_ride(user, direction)
// 	if(world.time < last_enginesound_time + engine_sound_length)
// 		return
// 	last_enginesound_time = world.time
// 	playsound(src, engine_sound, 100, TRUE)

// /obj/vehicle/sealed/car/MouseDrop_T(atom/dropping, mob/living/M)
// /* 	if(!istype(M) || !CHECK_MOBILITY(M, MOBILITY_USE))
// 		return FALSE */
// 	if(isliving(dropping) && M != dropping)
// 		var/mob/living/L = dropping
// 		L.visible_message("<span class='warning'>[M] starts forcing [L] into [src]!</span>")
// 		mob_try_forced_enter(M, L)
// 	return ..()

// /obj/vehicle/sealed/car/mob_try_exit(mob/M, mob/user, silent = FALSE)
// 	if(M == user && (occupants[M] & VEHICLE_CONTROL_KIDNAPPED))
// 		to_chat(user, "<span class='notice'>You push against the back of [src] trunk to try and get out.</span>")
// 		if(!do_after(user, escape_time, target = src))
// 			return FALSE
// 		to_chat(user,"<span class='danger'>[user] gets out of [src]</span>")
// 		mob_exit(M, silent)
// 		return TRUE
// 	mob_exit(M, silent)
// 	return TRUE

// /obj/vehicle/sealed/car/attacked_by(obj/item/I, mob/living/user, attackchain_flags = NONE, damage_multiplier = 1)
// 	if(!I.force)
// 		return FALSE
// 	if(occupants[user])
// 		to_chat(user, "<span class='notice'>Your attack bounces off of the car's padded interior.</span>")
// 		return FALSE
// 	return ..()

// /obj/vehicle/sealed/car/attack_hand(mob/living/user, act_intent = user.combat_mode, unarmed_attack_flags)
// //	. = ..()
// 	if(!(car_traits & CAN_KIDNAP))
// 		return
// 	if(occupants[user])
// 		return
// 	to_chat(user, "<span class='notice'>You start opening [src]'s trunk.</span>")
// 	if(do_after(user, 30))
// 		if(return_amount_of_controllers_with_flag(VEHICLE_CONTROL_KIDNAPPED))
// 			to_chat(user, "<span class='notice'>The people stuck in [src]'s trunk all come tumbling out.</span>")
// 			DumpSpecificMobs(VEHICLE_CONTROL_KIDNAPPED)
// 		else
// 			to_chat(user, "<span class='notice'>It seems [src]'s trunk was empty.</span>")

// /* /obj/vehicle/sealed/car/proc/mob_try_forced_enter(mob/forcer, mob/M, silent = FALSE)
// 	if(!istype(M))
// 		return FALSE
// 	if(occupant_amount() >= max_occupants)
// 		return FALSE
// 	var/atom/old_loc = loc
// 	if(do_mob(forcer, M, get_enter_delay(M), extra_checks=CALLBACK(src, /obj/vehicle/sealed/car/proc/is_car_stationary, old_loc)))
// 		mob_forced_enter(M, silent)
// 		return TRUE
// 	return FALSE

// /obj/vehicle/sealed/car/proc/is_car_stationary(atom/old_loc)
// 	return (old_loc == loc)

// /obj/vehicle/sealed/car/proc/mob_forced_enter(mob/M, silent = FALSE)
// 	if(!silent)
// 		M.visible_message("<span class='warning'>[M] is forced into \the [src]!</span>")
// 	M.forceMove(src)
// 	add_occupant(M, VEHICLE_CONTROL_KIDNAPPED) */


// /datum/component/riding
// 	var/last_vehicle_move = 0 //used for move delays
// /* 	var/last_move_diagonal = FALSE
// 	var/vehicle_move_delay = 2 //tick delay between movements, lower = faster, higher = slower
// 	var/keytype */

// 	var/slowed = FALSE
// 	var/slowvalue = 1

// /* 	var/list/riding_offsets = list()	//position_of_user = list(dir = list(px, py)), or RIDING_OFFSET_ALL for a generic one.
// 	var/list/directional_vehicle_layers = list()	//["[DIRECTION]"] = layer. Don't set it for a direction for default, set a direction to null for no change.
// 	var/list/directional_vehicle_offsets = list()	//same as above but instead of layer you have a list(px, py)
// 	var/list/allowed_turf_typecache
// 	var/list/forbid_turf_typecache			 */		//allow typecache for only certain turfs, forbid to allow all but those. allow only certain turfs will take precedence.
// 	var/allow_one_away_from_valid_turf = TRUE		//allow moving one tile away from a valid turf but not more.
// //	var/override_allow_spacemove = FALSE
// 	var/drive_verb = "drive"
// 	var/ride_check_rider_incapacitated = FALSE
// 	var/ride_check_rider_restrained = FALSE
// 	var/ride_check_ridden_incapacitated = FALSE
// 	var/list/offhands = list() // keyed list containing all the current riding offsets associated by mob

// 	var/del_on_unbuckle_all = FALSE

// /datum/component/riding/Initialize()
// 	if(!ismovable(parent))
// 		return COMPONENT_INCOMPATIBLE
// 	RegisterSignal(parent, COMSIG_MOVABLE_BUCKLE, .proc/vehicle_mob_buckle)
// 	RegisterSignal(parent, COMSIG_MOVABLE_UNBUCKLE, .proc/vehicle_mob_unbuckle)
// 	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, .proc/vehicle_moved)

// /* /datum/component/riding/proc/vehicle_mob_unbuckle(datum/source, mob/living/M, force = FALSE)
// 	var/atom/movable/AM = parent
// 	restore_position(M)
// 	unequip_buckle_inhands(M)
// 	if(del_on_unbuckle_all && !AM.has_buckled_mobs())
// 		qdel(src) */

// /datum/component/riding/proc/vehicle_mob_buckle(datum/source, mob/living/M, force)
// 	handle_vehicle_offsets(M.buckled?.dir)

// /* /datum/component/riding/proc/handle_vehicle_layer(dir)
// 	var/atom/movable/AM = parent
// 	var/static/list/defaults = list(TEXT_NORTH = OBJ_LAYER, TEXT_SOUTH = ABOVE_MOB_LAYER, TEXT_EAST = ABOVE_MOB_LAYER, TEXT_WEST = ABOVE_MOB_LAYER)
// 	. = defaults["[dir]"]
// 	if(directional_vehicle_layers["[dir]"])
// 		. = directional_vehicle_layers["[dir]"]
// 	if(isnull(.))	//you can set it to null to not change it.
// 		. = AM.layer
// 	AM.layer = .
//  */
// /* /datum/component/riding/proc/set_vehicle_dir_layer(dir, layer)
// 	directional_vehicle_layers["[dir]"] = layer

// /datum/component/riding/proc/vehicle_moved(datum/source, oldLoc, dir)
// 	SIGNAL_HANDLER

// 	var/atom/movable/AM = parent
// 	if (isnull(dir))
// 		dir = AM.dir
// 	AM.set_glide_size(DELAY_TO_GLIDE_SIZE(vehicle_move_delay), FALSE)
// 	for(var/i in AM.buckled_mobs)
// 		ride_check(i)
// 	handle_vehicle_offsets(dir)
// 	handle_vehicle_layer(dir)

// /datum/component/riding/proc/ride_check(mob/living/M)
// 	var/atom/movable/AM = parent
// 	var/mob/AMM = AM
// 	if((ride_check_rider_restrained && M.restrained(TRUE)) || (ride_check_rider_incapacitated && M.incapacitated(FALSE, TRUE)) || (ride_check_ridden_incapacitated && istype(AMM) && AMM.incapacitated(FALSE, TRUE)))
// 		AM.visible_message("<span class='warning'>[M] falls off of [AM]!</span>")
// 		AM.unbuckle_mob(M)
// 	return TRUE
//  */
// /* /datum/component/riding/proc/force_dismount(mob/living/M)
// 	var/atom/movable/AM = parent
// 	AM.unbuckle_mob(M) */

// /datum/component/riding/proc/additional_offset_checks()
// 	return TRUE

// /* /datum/component/riding/proc/handle_vehicle_offsets(dir)
// 	var/atom/movable/AM = parent
// 	var/AM_dir = "[dir]"
// 	var/passindex = 0
// 	if(AM.has_buckled_mobs())
// 		for(var/m in AM.buckled_mobs)
// 			passindex++
// 			var/mob/living/buckled_mob = m
// 			var/list/offsets = get_offsets(passindex)
// 			var/rider_dir = get_rider_dir(passindex)
// 			buckled_mob.setDir(rider_dir)
// 			for(var/offsetdir in offsets)
// 				if(offsetdir == AM_dir)
// 					var/list/diroffsets = offsets[offsetdir]
// 					buckled_mob.pixel_x = diroffsets[1]
// 					if(diroffsets.len >= 2)
// 						buckled_mob.pixel_y = diroffsets[2]
// 					if(diroffsets.len == 3)
// 						buckled_mob.layer = diroffsets[3]
// 					break
// 	if (!additional_offset_checks())
// 		return
// 	var/list/static/default_vehicle_pixel_offsets = list(TEXT_NORTH = list(0, 0), TEXT_SOUTH = list(0, 0), TEXT_EAST = list(0, 0), TEXT_WEST = list(0, 0))
// 	var/px = default_vehicle_pixel_offsets[AM_dir]
// 	var/py = default_vehicle_pixel_offsets[AM_dir]
// 	if(directional_vehicle_offsets[AM_dir])
// 		if(isnull(directional_vehicle_offsets[AM_dir]))
// 			px = AM.pixel_x
// 			py = AM.pixel_y
// 		else
// 			px = directional_vehicle_offsets[AM_dir][1]
// 			py = directional_vehicle_offsets[AM_dir][2]
// 	AM.pixel_x = px
// 	AM.pixel_y = py

// /datum/component/riding/proc/set_vehicle_dir_offsets(dir, x, y)
// 	directional_vehicle_offsets["[dir]"] = list(x, y)

// //Override this to set your vehicle's various pixel offsets
// /datum/component/riding/proc/get_offsets(pass_index) // list(dir = x, y, layer)
// 	. = list(TEXT_NORTH = list(0, 0), TEXT_SOUTH = list(0, 0), TEXT_EAST = list(0, 0), TEXT_WEST = list(0, 0))
// 	if(riding_offsets["[pass_index]"])
// 		. = riding_offsets["[pass_index]"]
// 	else if(riding_offsets["[RIDING_OFFSET_ALL]"])
// 		. = riding_offsets["[RIDING_OFFSET_ALL]"]

// /datum/component/riding/proc/set_riding_offsets(index, list/offsets)
// 	if(!islist(offsets))
// 		return FALSE
// 	riding_offsets["[index]"] = offsets
//  */
// //Override this to set the passengers/riders dir based on which passenger they are.
// //ie: rider facing the vehicle's dir, but passenger 2 facing backwards, etc.
// /datum/component/riding/proc/get_rider_dir(pass_index)
// 	var/atom/movable/AM = parent
// 	return AM.dir

// //KEYS
// /* /datum/component/riding/proc/keycheck(mob/user)
// 	return !keytype || user?.is_holding_item_of_type(keytype)

// //BUCKLE HOOKS
// /datum/component/riding/proc/restore_position(mob/living/buckled_mob)
// 	if(buckled_mob)
// 		buckled_mob.pixel_x = 0
// 		buckled_mob.pixel_y = 0
// 		if(buckled_mob.client)
// 			buckled_mob.client.view_size.resetToDefault()

// //MOVEMENT
// /datum/component/riding/proc/turf_check(turf/next, turf/current)
// 	if(allowed_turf_typecache && !allowed_turf_typecache[next.type])
// 		return (allow_one_away_from_valid_turf && allowed_turf_typecache[current.type])
// 	else if(forbid_turf_typecache && forbid_turf_typecache[next.type])
// 		return (allow_one_away_from_valid_turf && !forbid_turf_typecache[current.type])
// 	return TRUE
//  */
// /* /datum/component/riding/proc/handle_ride(mob/user, direction)
// 	var/atom/movable/AM = parent
// 	if(user && user.incapacitated())
// 		Unbuckle(user)
// 		return
// 	if(world.time < last_vehicle_move + ((last_move_diagonal? 2 : 1) * vehicle_move_delay))
// 		return
// 	last_vehicle_move = world.time

// 	if(keycheck(user))
// 		var/turf/next = get_step(AM, direction)
// 		var/turf/current = get_turf(AM)
// 		if(!istype(next) || !istype(current))
// 			return	//not happening.
// 		if(!turf_check(next, current))
// 			to_chat(user, "Your \the [AM] can not go onto [next]!")
// 			return
// 		if(!Process_Spacemove(direction) || !isturf(AM.loc))
// 			return
// 		step(AM, direction)

// 		if((direction & (direction - 1)) && (AM.loc == next))		//moved diagonally
// 			last_move_diagonal = TRUE
// 		else
// 			last_move_diagonal = FALSE

// 		handle_vehicle_offsets(direction)
// 		handle_vehicle_layer(direction)
// 	else
// 		to_chat(user, "<span class='notice'>You'll need the keys in one of your hands to drive [AM].</span>") */

// /* /datum/component/riding/proc/Unbuckle(atom/movable/M)
// 	addtimer(CALLBACK(parent, /atom/movable/.proc/unbuckle_mob, M), 0, TIMER_UNIQUE)

// /datum/component/riding/proc/Process_Spacemove(direction)
// 	var/atom/movable/AM = parent
// 	return override_allow_spacemove || AM.has_gravity() */

// /datum/component/riding/proc/account_limbs(mob/living/M)
// 	if(!slowed) //wtf
// 		vehicle_move_delay = vehicle_move_delay + slowvalue
// 		slowed = TRUE
// 	else if(slowed)
// 		vehicle_move_delay = vehicle_move_delay - slowvalue
// 		slowed = FALSE

// ///////Yes, I said humans. No, this won't end well...//////////
// /datum/component/riding/human
// 	del_on_unbuckle_all = TRUE
// 	var/fireman_carrying = FALSE

// /datum/component/riding/human/Initialize()
// 	. = ..()
// 	directional_vehicle_layers = list(TEXT_NORTH = ABOVE_MOB_LAYER, TEXT_SOUTH = ABOVE_MOB_LAYER, TEXT_EAST = ABOVE_MOB_LAYER, TEXT_WEST = ABOVE_MOB_LAYER)
// 	RegisterSignal(parent, COMSIG_HUMAN_MELEE_UNARMED_ATTACK, .proc/on_host_unarmed_melee)

// /datum/component/riding/human/vehicle_mob_unbuckle(datum/source, mob/living/M, force = FALSE)
// 	var/mob/living/carbon/human/H = parent
// 	if(!length(H.buckled_mobs))
// 		H.remove_movespeed_modifier(/datum/movespeed_modifier/human_carry)
// 	if(!fireman_carrying)
// 		M.Stun(25)
// 	return ..()

// /datum/component/riding/human/vehicle_mob_buckle(datum/source, mob/living/M, force = FALSE)
// 	. = ..()
// 	var/mob/living/carbon/human/H = parent
// 	if(length(H.buckled_mobs))
// 		H.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/human_carry, TRUE)


// /datum/component/riding/human/proc/on_host_unarmed_melee(atom/target)
// 	var/mob/living/carbon/human/H = parent
// 	if(H.combat_mode && (target in H.buckled_mobs))
// 		force_dismount(target)

// /datum/component/riding/human/handle_vehicle_layer()
// 	. = ..()
// 	var/atom/movable/AM = parent
// 	if(AM.buckled_mobs && AM.buckled_mobs.len)
// 		for(var/mob/M in AM.buckled_mobs) //ensure proper layering of piggyback and carry, sometimes weird offsets get applied
// 			M.layer = MOB_LAYER
// 		if(!AM.buckle_lying)
// 			if(AM.dir == SOUTH)
// 				AM.layer = ABOVE_MOB_LAYER
// 			else
// 				AM.layer = OBJ_LAYER
// 		else
// 			if(AM.dir == NORTH)
// 				AM.layer = OBJ_LAYER
// 			else
// 				AM.layer = ABOVE_MOB_LAYER
// 	else
// 		AM.layer = MOB_LAYER

// /datum/component/riding/human/get_offsets(pass_index)
// 	var/mob/living/carbon/human/H = parent
// 	if(H.buckle_lying)
// 		return list(TEXT_NORTH = list(0, 6), TEXT_SOUTH = list(0, 6), TEXT_EAST = list(0, 6), TEXT_WEST = list(0, 6))
// 	else
// 		return list(TEXT_NORTH = list(0, 6), TEXT_SOUTH = list(0, 6), TEXT_EAST = list(-6, 4), TEXT_WEST = list( 6, 4))

// /datum/component/riding/human/additional_offset_checks()
// 	var/mob/living/carbon/human/H = parent
// 	return !H.buckled

// /datum/component/riding/human/force_dismount(mob/living/user)
// 	var/atom/movable/AM = parent
// 	AM.unbuckle_mob(user)
// 	user.Knockdown(60)
// 	user.Stun(50)
// 	user.visible_message("<span class='warning'>[AM] pushes [user] off of [AM.p_them()]!</span>")

// /datum/component/riding/cyborg
// 	del_on_unbuckle_all = TRUE

// /datum/component/riding/cyborg/Initialize()
// 	. = ..()
// 	directional_vehicle_layers = list(TEXT_NORTH = ABOVE_MOB_LAYER, TEXT_SOUTH = ABOVE_MOB_LAYER, TEXT_EAST = ABOVE_MOB_LAYER, TEXT_WEST = ABOVE_MOB_LAYER)

// /datum/component/riding/cyborg/ride_check(mob/user)
// 	var/atom/movable/AM = parent
// 	if(user.incapacitated())
// 		var/kick = TRUE
// 		if(iscyborg(AM))
// 			kick = FALSE
// 		if(kick)
// 			to_chat(user, "<span class='userdanger'>You fall off of [AM]!</span>")
// 			Unbuckle(user)
// 			return

// /datum/component/riding/cyborg/handle_vehicle_layer()
// 	var/atom/movable/AM = parent
// 	if(AM.buckled_mobs && AM.buckled_mobs.len)
// 		if(AM.dir == SOUTH)
// 			AM.layer = ABOVE_MOB_LAYER
// 		else
// 			AM.layer = OBJ_LAYER
// 	else
// 		AM.layer = MOB_LAYER

// /datum/component/riding/cyborg/get_offsets(pass_index) // list(dir = x, y, layer)
// 	return list(TEXT_NORTH = list(0, 4), TEXT_SOUTH = list(0, 4), TEXT_EAST = list(-6, 3), TEXT_WEST = list( 6, 3))

// /datum/component/riding/cyborg/handle_vehicle_offsets()
// 	var/atom/movable/AM = parent
// 	if(AM.has_buckled_mobs())
// 		for(var/mob/living/M in AM.buckled_mobs)
// 			M.setDir(AM.dir)
// 			/* if(iscyborg(AM))
// 				var/mob/living/silicon/robot/R = AM
// 				if(istype(R.module))
// 					M.pixel_x = R.module.ride_offset_x[dir2text(AM.dir)]
// 					M.pixel_y = R.module.ride_offset_y[dir2text(AM.dir)]
// 			else */
// 			..()

// /datum/component/riding/cyborg/force_dismount(mob/living/M)
// 	var/atom/movable/AM = parent
// 	AM.unbuckle_mob(M)
// 	var/turf/target = get_edge_target_turf(AM, AM.dir)
// 	var/turf/targetm = get_step(get_turf(AM), AM.dir)
// 	M.Move(targetm)
// 	M.visible_message("<span class='warning'>[M] is thrown clear of [AM]!</span>")
// 	M.throw_at(target, 14, 5, AM)
// 	M.Knockdown(60)

// /datum/component/riding/proc/equip_buckle_inhands(mob/living/carbon/human/user, amount_required = 1, mob/living/riding_target_override)
// 	var/list/equipped
// 	var/mob/living/L = riding_target_override ? riding_target_override : user
// 	for(var/amount_needed = amount_required, amount_needed > 0, amount_needed--)
// 		var/obj/item/riding_offhand/inhand = new
// 		inhand.rider = L
// 		inhand.parent = parent
// 		if(!user.put_in_hands(inhand, TRUE))
// 			qdel(inhand) // it isn't going to be added to offhands anyway
// 			break
// 		LAZYADD(equipped, inhand)
// 	var/amount_equipped = LAZYLEN(equipped)
// 	// if(amount_equipped)
// 	// 	LAZYADD(offhands[L], equipped)
// 	if(amount_equipped >= amount_required)
// 		return TRUE
// 	unequip_buckle_inhands(L)
// 	return FALSE

// // /datum/component/riding/proc/unequip_buckle_inhands(mob/living/carbon/user)
// // 	// for(var/a in offhands[user])
// // 	// 	LAZYREMOVE(offhands[user], a)
// // 	// 	if(a) //edge cases null entries
// // 	// 		var/obj/item/riding_offhand/O = a
// // 	// 		if(O.parent != parent)
// // 	// 			CRASH("RIDING OFFHAND ON WRONG MOB")
// // 	// 		else if(!O.selfdeleting)
// // 	// 			qdel(O)
// // 	return TRUE

// /obj/item/riding_offhand
// 	name = "offhand"
// 	icon = 'icons/obj/items_and_weapons.dmi'
// 	icon_state = "offhand"
// 	w_class = WEIGHT_CLASS_HUGE
// 	item_flags = ABSTRACT | DROPDEL | NOBLUDGEON
// 	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
// 	// var/mob/living/carbon/rider
// 	// var/mob/living/parent
// 	// var/selfdeleting = FALSE

// /obj/item/riding_offhand/dropped(mob/user)
// 	selfdeleting = TRUE
// 	. = ..()

// /obj/item/riding_offhand/equipped()
// 	if(loc != rider && loc != parent)
// 		selfdeleting = TRUE
// 		qdel(src)
// 	. = ..()

// /obj/item/riding_offhand/Destroy()
// 	var/atom/movable/AM = parent
// 	if(selfdeleting)
// 		if(rider in AM.buckled_mobs)
// 			AM.unbuckle_mob(rider)
// 	. = ..()
