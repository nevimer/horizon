/mob/proc/has_left_leg()
	return TRUE

/mob/living/carbon/has_left_leg()
	var/obj/item/bodypart/l_leg = get_bodypart(BODY_ZONE_L_LEG)
	if(l_leg)
		return TRUE
	else
		return FALSE

/mob/proc/has_right_leg()
	return TRUE

/mob/living/carbon/has_right_leg()
	var/obj/item/bodypart/r_leg = get_bodypart(BODY_ZONE_R_LEG)
	if(r_leg)
		return TRUE
	else
		return FALSE

//Limb numbers
/mob/proc/get_num_arms(check_disabled = TRUE)
	return 2

/mob/living/carbon/get_num_arms(check_disabled = TRUE)
	. = 0
	for(var/X in bodyparts)
		var/obj/item/bodypart/affecting = X
		if(affecting.body_part == ARM_RIGHT)
			if(!check_disabled)
				.++
		if(affecting.body_part == ARM_LEFT)
			if(!check_disabled)
				.++


//sometimes we want to ignore that we don't have the required amount of arms.
/mob/proc/get_arm_ignore()
	return 0

/mob/living/carbon/alien/larva/get_arm_ignore()
	return 1 //so we can still handcuff larvas.


/mob/proc/get_num_legs(check_disabled = TRUE)
	return 2

/mob/living/carbon/get_num_legs(check_disabled = TRUE)
	. = 0
	for(var/X in bodyparts)
		var/obj/item/bodypart/affecting = X
		if(affecting.body_part == LEG_RIGHT)
			if(!check_disabled)
				.++
		if(affecting.body_part == LEG_LEFT)
			if(!check_disabled)
				.++
