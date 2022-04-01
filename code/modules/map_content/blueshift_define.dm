/datum/map_config/blueshift
	map_name = "Blueshift"
	map_path = "map_files/Blueshift"
	map_file = list("BlueShift_lower.dmm",
					"BlueShift_middle.dmm",
					"BlueShift_upper.dmm")

	traits = list(
					list("Up" = 1,
						"Linkage" = "Cross",
						"Baseturf" = "/turf/open/space/basic"),
					list("Up" = 1,
						"Down" = -1,
						"Baseturf" = "/turf/open/openspace",
						"Linkage" = "Cross"),
					list("Down" = -1,
						"Baseturf" = "/turf/open/openspace",
						"Linkage" = "Cross"))
	space_ruin_levels = 3

//	minetype = "none"

	global_trading_hub_type = /datum/trade_hub/worldwide/bearcat

	allow_custom_shuttles = TRUE

/* 	job_faction = FACTION_TRADERSHIP

	overflow_job = /datum/job/tradership_deckhand */

	overmap_object_type = /datum/overmap_object/shuttle/ship/bearcat

	amount_of_planets_spawned = 4

/datum/map_config/blueshift/get_map_info()
	return "You're aboard the <b>[map_name],</b> a survey and mercantile vessel affiliated with the Free Trade Union. \
	No meaningful authorities can claim the planets and resources in this uncharted sector, so their exploitation is entirely up to you - mine, poach and deforest all you want."
