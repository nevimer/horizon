/datum/map_config/gaia
	map_name = "Gaia Planet In Name"
	map_path = "map_files/gaia"
	map_file = "gaia.dmm"

	traits = list(
		list(
			"Up" = 1,
		),
		list(
			"Up" = 1,
			"Down" = -1,
			"Baseturf" = "/turf/open/openspace",
		),
		list(
			"Up" = 1,
			"Down" = -1,
			"Baseturf" = "/turf/open/openspace",
		),
		list(
			"Up" = 1,
			"Down" = -1,
			"Baseturf" = "/turf/open/openspace",
		),
		list(
			"Up" = 1,
			"Down" = -1,
			"Baseturf" = "/turf/open/openspace",
		),
		list(
			"Up" = 1,
			"Down" = -1,
			"Baseturf" = "/turf/open/openspace",
		),
		list(
			"Down" = -1,
			"Baseturf" = "/turf/open/openspace",
		),

	)

	space_ruin_levels = 4

	minetype = "none"

	global_trading_hub_type = /datum/trade_hub/worldwide/skyline

	allow_custom_shuttles = TRUE
	shuttles = list(
		"cargo" = "cargo_skyline",
		"mining" = "common_vista",
		"emergency" = "emergency_skyline",
		"whiteship" = "whiteship_kilo",
		"ferry" = null,
	)

//	job_faction = FACTION_SKYLINESHIP

//	overflow_job = /datum/job/skyline/off_duty

//	overmap_object_type = /datum/overmap_object/shuttle/ship/skyline

	overmap_object_type = /datum/overmap_object/shuttle/planet/icebox
	weather_controller_type = /datum/weather_controller/gaia
	atmosphere_type = /datum/atmosphere/gaia
	day_night_controller_type = /datum/day_night_controller
	ore_node_seeder_type = /datum/ore_node_seeder

	banned_event_tags = list(TAG_SPACE)
