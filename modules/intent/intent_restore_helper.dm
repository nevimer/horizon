/mob/
	var/a_intent = INTENT_HELP//Living
	var/list/possible_a_intents = null//Living
/mob/living/
	possible_a_intents = list(INTENT_HELP, INTENT_HARM)
/mob/living/carbon/
	possible_a_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, INTENT_HARM)
/mob/verb/a_intent_change(input as text, mob/user)
	set name = "a-intent"
	set hidden = TRUE
	show_message("2")

	if(!possible_a_intents || !possible_a_intents.len)
		show_message("1")
		return

	if(input in possible_a_intents)
		show_message("3")

		a_intent = input
	else
		var/current_intent = possible_a_intents.Find(a_intent)
		show_message("4")

		if(!current_intent)
			// Failsafe. Just in case some badmin was playing with VV.
			current_intent = 1

		if(input == INTENT_HOTKEY_RIGHT)
			current_intent += 1
		if(input == INTENT_HOTKEY_LEFT)
			current_intent -= 1

		// Handle looping
		if(current_intent < 1)
			current_intent = possible_a_intents.len
		if(current_intent > possible_a_intents.len)
			current_intent = 1

		a_intent = possible_a_intents[current_intent]
		show_message("6")

	if(hud_used?.action_intent)
		show_message("5")

		hud_used.action_intent.icon_state = "[a_intent]"

/atom/movable/screen/act_intent
	name = "intent"
	icon_state = "help"
	screen_loc = ui_acti

/atom/movable/screen/act_intent/Click(location, control, params)
	usr.a_intent_change(INTENT_HOTKEY_RIGHT)

/atom/movable/screen/act_intent/segmented/Click(location, control, params)
	if(INTENT_STYLE)
		var/_x = text2num(params2list(params)["icon-x"])
		var/_y = text2num(params2list(params)["icon-y"])
		var/mob/living/owner = usr
		if(_x<=16 && _y<=16)
			owner.set_combat_mode(!owner.combat_mode, FALSE)
			owner.a_intent_change("harm")

		else if(_x<=16 && _y>=17)
			owner.set_combat_mode(!owner.combat_mode, FALSE)
			owner.a_intent_change("help")

		else if(_x>=17 && _y<=16)
			usr.a_intent_change("grab")

		else if(_x>=17 && _y>=17)
			usr.a_intent_change("disarm")
	else
		return ..()

#define INTENT_HELP   "help"
#define INTENT_GRAB   "grab"
#define INTENT_DISARM "disarm"
#define INTENT_HARM   "harm"
//NOTE: INTENT_HOTKEY_* defines are not actual intents!
//they are here to support hotkeys
#define INTENT_HOTKEY_LEFT  "left"
#define INTENT_HOTKEY_RIGHT "right"

/datum/keybinding/carbon/select_help_intent
	hotkey_keys = list("1")
	name = "select_help_intent"
	full_name = "Select help intent"
	description = ""
	category = CATEGORY_CARBON

/datum/keybinding/carbon/select_help_intent/down(client/user)
	. = ..()
	user.mob?.a_intent_change(INTENT_HELP)
	return TRUE

/datum/keybinding/carbon/select_disarm_intent
	hotkey_keys = list("2")
	name = "select_disarm_intent"
	full_name = "Select disarm intent"
	description = ""
	category = CATEGORY_CARBON

/datum/keybinding/carbon/select_disarm_intent/down(client/user)
	. = ..()
	user.mob?.a_intent_change(INTENT_DISARM)
	return TRUE

/datum/keybinding/carbon/select_grab_intent
	hotkey_keys = list("3")
	name = "select_grab_intent"
	full_name = "Select grab intent"
	description = ""
	category = CATEGORY_CARBON

/datum/keybinding/carbon/select_grab_intent/down(client/user)
	. = ..()
	user.mob?.a_intent_change(INTENT_GRAB)
	return TRUE

/datum/keybinding/carbon/select_harm_intent
	hotkey_keys = list("4")
	name = "select_harm_intent"
	full_name = "Select harm intent"
	description = ""
	category = CATEGORY_CARBON

/datum/keybinding/carbon/select_harm_intent/down(client/user)
	. = ..()
	user.mob?.a_intent_change(INTENT_HARM)
	return TRUE
