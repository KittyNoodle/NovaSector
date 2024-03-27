/area/shuttle/terminal
	name = "Terminal"
	requires_power = TRUE
	area_limited_icon_smoothing = /area/shuttle/terminal

/area/shuttle/terminal/bridge
	name = "Terminal Bridge"
	icon_state = "bridge"

/area/shuttle/terminal/eva
	name = "Terminal EVA"

/area/shuttle/terminal/hallway
	name = "Terminal Hallway"

/area/shuttle/terminal/engine
	name = "Terminal Engine"
	icon_state = "engine"

/area/shuttle/terminal/crew
	name = "Terminal Bedroom"
	icon_state = "heads_quarters"

/area/shuttle/terminal/medbay
	name = "Terminal Medbay"
	icon_state = "medbay"

/area/shuttle/terminal/relic
	name = "Terminal Reliquary"

//
//////////PINKROSE///////////
//

/area/shuttle/pinkrose
	name = "Pinkrose"
	requires_power = TRUE
	area_limited_icon_smoothing = /area/shuttle/pinkrose

/area/shuttle/pinkrose/medical
	name = "Pinkrose Medical"
	icon_state = "medbay"

/area/shuttle/pinkrose/engineering
	name = "Pinkrose Engineering"
	icon_state = "engine"

/area/shuttle/pinkrose/kitchen
	name = "Pinkrose Kitchen"
	icon_state = "kitchen"

/area/shuttle/pinkrose/hallway
	name = "Pinkrose Central Hallway"
	icon_state = "centralhall"

/area/shuttle/pinkrose/hallway/port
	name = "Pinkrose Port Hallway"
	icon_state = "porthall"

/area/shuttle/pinkrose/hallway/starboard
	name = "Pinkrose Starboard Hallway"
	icon_state = "starboardhall"

/area/shuttle/pinkrose/bridge
	name = "Pinkrose Flight Deck"
	icon_state = "bridge"

/area/shuttle/pinkrose/dorm
	name = "Pinkrose Dorms"
	icon_state = "dorms"

/area/shuttle/pinkrose/bathroom
	name = "Pinkrose Restroom"
	icon_state = "toilet"

/area/shuttle/pinkrose/cryo
	name = "Pinkrose Cryopod Room"
	icon_state = "commons"

/area/shuttle/pinkrose/cargo
	name = "Pinkrose Cargo Bay"
	icon_state = "cargo_bay"

/area/shuttle/pinkrose/storage
	name = "Pinkrose Storage"
	icon_state = "primary_storage"

/area/shuttle/pinkrose/maints
	name = "Pinkrose Maints"
	ambience_index = AMBIENCE_MAINT
	sound_environment = SOUND_AREA_TUNNEL_ENCLOSED
	forced_ambience = TRUE
	ambient_buzz = 'sound/ambience/source_corridor2.ogg'
	ambient_buzz_vol = 20

/area/shuttle/pinkrose/maints/port
	name = "Pinkrose Port Maintenance"
	icon_state = "portmaint"

/area/shuttle/pinkrose/maints/starboard
	name = "Pinkrose Starboard Maintenance"
	icon_state = "starboardmaint"
