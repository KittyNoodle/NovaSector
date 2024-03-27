GLOBAL_LIST_INIT(voidic_ambience,list(
	'sound/ambience/ambiicesting2.ogg',
	'sound/ambience/ambiicesting4.ogg',
	'sound/ambience/ambiicesting5.ogg',
	'sound/ambience/ambimaint6.ogg',
	'sound/ambience/ambimaint7.ogg',
))

GLOBAL_LIST_INIT(deep_voidic_ambience,list(
	'sound/ambience/ambiicemelody1.ogg',
	'sound/ambience/ambiicesting1.ogg',
	'sound/ambience/ambiicesting5.ogg',
	'sound/ambience/ambiicesting4.ogg',
	'sound/ambience/ambimaint7.ogg',
))

GLOBAL_LIST_INIT(jupiter_ambience,list(
	'sound/ambience/ambiicetheme.ogg',
	'sound/ambience/ambiicemelody2.ogg',
	'sound/ambience/ambiicemelody3.ogg',
	'sound/ambience/ambiicemelody4.ogg',
	'sound/ambience/ambiicesting5.ogg',
))

/*library list
ambiicemelody2
ambireebe3
ambiicemelody3
ambiicemelody4
*/

/*terror list
ambiicesting2
ambiicesting4
ambiicesting5
ambimaint6
ambimaint7

*/

/area/ruin/space/has_grav/powered/library
	requires_power = FALSE
	name = "The Library of Jupiter"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "library"

/area/ruin/space/has_grav/powered/library/interchange
	requires_power = FALSE
	has_gravity = 2.9
	name = "Voidic Interchange"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "library"


/datum/atmosphere/voidic
	id = VOIDIC_DEFAULT_ATMOS

	base_gases = list(
		/datum/gas/oxygen=12,
		/datum/gas/nitrogen=6,
	)
	normal_gases = list(
		/datum/gas/oxygen=16,
		/datum/gas/nitrogen=4,
	)
	restricted_gases = list(
		/datum/gas/plasma=0.1,
		/datum/gas/bz=1.2,
		/datum/gas/miasma=1.2,
		/datum/gas/water_vapor=0.1,
	)
	restricted_chance = 0	// NOVA EDIT: Disables restricted gases from rolling - Original value (30)

	minimum_pressure = 50
	maximum_pressure = 60

	minimum_temp = 340
	maximum_temp = 36

/area/voidic
	name = "Voidic"
	icon_state = "explored"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = UNIQUE_AREA
	ambience_index = AMBIENCE_ICEMOON
	sound_environment = SOUND_ENVIRONMENT_UNDERWATER
	ambient_buzz = 'sound/ambience/cavesound3.ogg'
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	min_ambience_cooldown = 50 SECONDS
	max_ambience_cooldown = 150 SECONDS

/area/voidic/deep
	ambient_buzz = 'sound/ambience/VoidsEmbrace.ogg'
	min_ambience_cooldown = 70 SECONDS
	max_ambience_cooldown = 220 SECONDS
	has_gravity = 0
	sound_environment = SOUND_ENVIRONMENT_UNDERWATER

/area/voidic/deep/toodeep
	//make it declone you
