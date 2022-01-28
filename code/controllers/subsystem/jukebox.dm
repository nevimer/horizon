SUBSYSTEM_DEF(jukebox)
	name = "Jukebox"
	flags = SS_BACKGROUND
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 1 SECONDS
	/// All tracks that jukeboxes can pick from to play.
	var/list/tracks = list()
	/// Remaining free channels, those get used and freed as songs start and end.
	var/list/free_channels = list()
	/// Currently playing tracks.
	var/list/playing_tracks = list()
	/// People subscribed to the jukebox playing songs
	var/list/controller_list = list()

/datum/controller/subsystem/jukebox/Initialize(timeofday)
	load_tracks()

	/// Load free channels
	for(var/i in CHANNEL_JUKEBOX_START to CHANNEL_JUKEBOX_END)
		free_channels += i

	return ..()

/datum/controller/subsystem/jukebox/fire(resumed)
	for(var/datum/jukebox_controller/controller in controller_list)
		/// Safety check because clients are a HECK
		if(!controller.client)
			qdel(controller)
		controller.loudest_jukebox_volume = 0

	for(var/datum/jukebox_playing_track/played_track in playing_tracks)
		if(played_track.end_when <= world.time)
			qdel(played_track)
			continue
		played_track.update_controllers(controller_list)
		if(MC_TICK_CHECK)
			return

/datum/controller/subsystem/jukebox/proc/add_controller(datum/jukebox_controller/controller)
	controller_list += controller
	for(var/datum/jukebox_playing_track/played_track in playing_tracks)
		controller.add_played_track(played_track)

/datum/controller/subsystem/jukebox/proc/remove_controller(datum/jukebox_controller/controller)
	for(var/datum/jukebox_playing_track/played_track in playing_tracks)
		controller.remove_played_track(played_track)
	controller_list -= controller

/datum/controller/subsystem/jukebox/proc/load_tracks()
	/// Unload already existing tracks in cases of re-loading the tracks
	tracks.Cut()

	var/list/to_load_tracks = flist("[global.config.directory]/jukebox_music/sounds/")

	for(var/some_file in to_load_tracks)
		var/datum/jukebox_track/track = new()
		track.song_path = file("[global.config.directory]/jukebox_music/sounds/[some_file]")
		var/list/param_list = splittext(some_file,"+")
		if(param_list.len != 4)
			continue
		track.song_artist = param_list[1]
		track.song_title = param_list[2]
		track.song_length = (text2num(param_list[3]) SECONDS)
		track.song_beat = ((text2num(param_list[4]) / 60) SECONDS)
		tracks += track

/datum/controller/subsystem/jukebox/proc/get_free_channel()
	if(!free_channels.len)
		return
	var/channel = free_channels[free_channels.len]
	free_channels.len--
	return channel

/datum/controller/subsystem/jukebox/proc/free_channel(channel)
	free_channels += channel
