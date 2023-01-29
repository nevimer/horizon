/datum/component/mob_holder/
	var/list/containers_within
	var/atom/parent_holder


/datum/nomming_container
	var/atom/parent
	var/list/contents
	var/name
	var/flavour_post_nom = "You are within what appears to be a dark, damp container. You cannot see your surroundings, yet \
	a sense of mystery surrounds you."
	var/current_index
	/post_creation()
		name = "\improper Default Nomming Apperatus"
		flavour_post_nom = parent.parent_holder.client.prefs.nom_container_list[current_index].flavour_post_nom || initial(flavour_post_nom)


/datum/component/mob_holder/Initialize(...)
	. = ..()
	if(!istype(parent, /atom/))
		return COMPONENT_INCOMPATIBLE

/datum/component/mob_holder/RegisterWithParent()
	. = ..()
	parent_holder = parent
	init_noms()

/datum/preferences/var/nomming = TRUE
/datum/preferences/var/list/nom_container_list = list()

/datum/component/mob_holder/proc/init_noms()
	if(parent_holder.client?.preferences.nomming = TRUE)
		for(var/datum/nomming_container in parent_holder.containers_within)
			nomming_container.post_creation()
			nomming_container.current_index = Find(parent_holder.containers_within)
/datum/component/mob_holder/proc/nom(atom/being_vored)

