//TODO: Split me!
/datum/job/home
	department_head = list("Free Trade Union")
	supervisors = "karma, and the crew."
	title = "Drifter"
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS
	faction = FACTION_TRADERSHIP
	total_positions = 12
	spawn_positions = 12
	selection_color = "#535357"
	exp_granted_type = EXP_TYPE_CREW
	outfit = /datum/outfit/job/home


/datum/job/home/headship
	title = "Housemate"
	total_positions = 12
	spawn_positions = 12
	selection_color ="#d4d4d4"
	outfit = /datum/outfit/job/miner

/datum/job/home/headship/doctor
	title = "House Doctor"
	total_positions = 12
	spawn_positions = 12
	selection_color ="#d4d4d4"
	outfit = /datum/outfit/job/home/doctor

/datum/outfit/job/home/doctor
	ears = /obj/item/radio/headset/headset_med
	suit =  /obj/item/clothing/suit/toggle/labcoat/paramedic
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	belt = /obj/item/storage/belt/medical/paramedic
	l_pocket = /obj/item/pda/medical
	suit_store = /obj/item/flashlight/pen/paramedic
	backpack_contents = list(/obj/item/roller=1)

	pda_slot = ITEM_SLOT_LPOCKET
/datum/job/home/headship/engineer
	title = "House Maintainer"
	total_positions = 12
	spawn_positions = 12
	selection_color ="#d4d4d4"
	outfit = /datum/outfit/job/home/engineer

/datum/outfit/job/home/engineer
	name = "Engimate"
	belt = /obj/item/storage/belt/utility
	uniform = /obj/item/clothing/under/rank/engineering/chief_engineer/home
	gloves = /obj/item/clothing/gloves/color/chief_engineer

/obj/item/clothing/under/rank/engineering/chief_engineer/home
	desc = "A valuable white jumpsuit with suspenders, lined with light armour and radiation shielding. Completely immune to fire."
	name = "fancy engineering jumpsuit"
	armor = list(MELEE = 10, BULLET = 0, LASER = 0, ENERGY = 10, BOMB = 10, BIO = 10, RAD = 10, FIRE = 100, ACID = 40)


/datum/job/home/headship/housemaster
	title = "Housemaster"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD|DEADMIN_POSITION_SECURITY
	department_head = list("Free Trade Union")
	faction = FACTION_TRADERSHIP
	total_positions = 1
	spawn_positions = 1
	supervisors = "karma, and the crew."
	selection_color = "#ffffff"
	req_admin_notify = 1
	minimal_player_age = 14
	exp_requirements = 180
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_COMMAND
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/home/housemaster
	plasmaman_outfit = /datum/outfit/plasmaman/captain

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SEC

	liver_traits = list(TRAIT_ROYAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_CAPTAIN
	departments_list = list(
		/datum/job_department/command,
		)

	family_heirlooms = list(/obj/item/reagent_containers/food/drinks/flask/gold)

	mail_goodies = list(
		/obj/item/clothing/mask/cigarette/cigar/havana = 20,
		/obj/item/storage/fancy/cigarettes/cigars/havana = 15,
		/obj/item/reagent_containers/food/drinks/bottle/champagne = 10
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_BOLD_SELECT_TEXT | JOB_REOPEN_ON_ROUNDSTART_LOSS

	voice_of_god_power = 1.4 //Command staff has authority

/obj/item/card/id/advanced/home
	wildcard_slots = WILDCARD_NAME_ALL // Fuck restrictions
	icon_state = "card_black"
	worn_icon_state = "card_black"

/datum/outfit/job/home
	name = "Crewmate"
	id = /obj/item/card/id/advanced/home
	ears = /obj/item/radio/headset
	backpack = /obj/item/storage/backpack/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	duffelbag = /obj/item/storage/backpack/duffelbag/explorer
	shoes = /obj/item/clothing/shoes/workboots/mining
	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/rank/cargo/miner/lavaland
	id_trim = /datum/id_trim/job
	implants = list(/obj/item/implant/deathrattle)
	belt = /obj/item/storage/belt/utility/full/engi

/datum/outfit/job/home/housemaster
	name = "Housemaster's Outfit"
	jobtype = /datum/job/home/headship/housemaster
	uniform = /obj/item/clothing/under/pants/camo/home
	id = /obj/item/card/id/advanced/home
	ears = /obj/item/radio/headset
	belt = /obj/item/storage/belt/military
	shoes = /obj/item/clothing/shoes/jackboots
	box = /obj/item/storage/box/survival/engineer
	implants = list(/obj/item/implant/mindshield, /obj/item/implant/krav_maga, /obj/item/implant/deathrattle, /obj/item/implant/health)
	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	id_trim = /datum/id_trim/job/captain
	pda_slot = ITEM_SLOT_POCKETS
	gloves = /obj/item/clothing/gloves/color/captain
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1, /obj/item/station_charter=1, /obj/item/gun/energy/e_gun/mini=1, /obj/item/modular_computer/tablet/preset/advanced/command=1)
	skillchips = list(/obj/item/skillchip/disk_verifier, /obj/item/skillchip/wine_taster, /obj/item/skillchip/job/engineer)
	var/special_charter

/obj/item/clothing/under/pants/camo/home
	name = "tactical pants"
	desc = "A pair of woodland camouflage pants. Probably not the best choice for a space station. Lined with kevlar, however, whatever good that does. Fireproof!"
	armor = list(MELEE = 30, BULLET = 30, LASER = 30, ENERGY = 25, BOMB = 40, BIO = 10, RAD = 10, FIRE = 100, ACID = 40)

