/obj/machinery/launchpad/violetspace
	name = "violetspace launchpad"
	desc = "A bluespace pad able to rotate matter through violetspace, teleporting it to or from nearby locations."
	icon = 'code/modules/archonic/icons/items_and_weapons.dmi'
	icon_state = "alien-pad-c"
	icon_teleport = "alien-pad-c"
	use_power = FALSE
	stationary = FALSE //only used to prevent deconstruction
	idle_power_usage = 0
	active_power_usage = 0
	teleport_speed = 15
	range = 200

/obj/machinery/launchpad/violetspace/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/violetspace_launchpad_remote/))
		var/obj/item/violetspace_launchpad_remote/L = I
		if(L.pad == WEAKREF(src)) //do not attempt to link when already linked
			return ..()
		L.pad = WEAKREF(src)
		to_chat(user, "<span class='notice'>You link [src] to [L].</span>")
	else
		return ..()

/obj/item/violetspace_launchpad_remote/
	name = "violetspace navigator"
	desc = "A crystal that can be used to hook onto the violetspace launchpad and navigate reality."
	icon = 'code/modules/archonic/icons/items_and_weapons.dmi'
	icon_state = "archonic_crystal"
	w_class = WEIGHT_CLASS_SMALL
	var/sending = TRUE
	//A weakref to our linked pad
	var/datum/weakref/pad


/obj/structure/window/plasma/reinforced/plastitanium/archonic
	name = "archonic crystal window"
	desc = "A durable looking window made archonic crystal."
	max_integrity = 600
	explosion_block = 50
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | LAVA_PROOF

/obj/item/eter_violet
	name = "Eter Violet"
	desc = "This book describes the secrets of the veil that seals Archous. This one is Crux CF's annotated copy, it has several added pages full of diagrams of complex machinery."
	icon = 'code/modules/archonic/icons/items_and_weapons.dmi'
	base_icon_state = "book"
	icon_state = "book"
	//worn_icon_state = "book"
	w_class = WEIGHT_CLASS_SMALL
	/// Helps determine the icon state of this item when it's used on self.
	var/book_open = FALSE

/obj/item/eter_violet/attack_self(mob/user, modifiers)
	. = ..()
	if(.)
		return

	if(book_open)
		close_animation()
		w_class = WEIGHT_CLASS_SMALL
	else
		open_animation()
		w_class = WEIGHT_CLASS_NORMAL

/*
 * Plays a little animation that shows the book opening and closing.
 */
/obj/item/eter_violet/proc/open_animation()
	book_open = TRUE
	icon_state = "[base_icon_state]_open"
	flick("[base_icon_state]_opening", src)

/// Plays a closing animation and resets the icon state.
/obj/item/eter_violet/proc/close_animation()
	book_open = FALSE
	icon_state = base_icon_state
	flick("[base_icon_state]_closing", src)

/obj/item/flashlight/lantern/jade/lamp_of_silence
	name = "\improper Lamp of Silence"
	desc = "An ornate, pale-green lantern. The words saltare in auream lucem are enscribed into the lamp"
	color = LIGHT_COLOR_GREEN
	light_range = 14
	light_power = 2
	light_color = LIGHT_COLOR_GREEN

/obj/machinery/door/namedoor
	name = "door"
	desc = "This door only opens for its owner."
	icon = 'icons/obj/doors/blastdoor.dmi'
	icon_state = "closed"
	explosion_block = 3
	heat_proof = TRUE
	max_integrity = 600
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | LAVA_PROOF
	damage_deflection = 70
	var/owner_name = "Crux CF"

/obj/machinery/door/namedoor/Bumped(atom/movable/AM)
	return !density && ..()

/obj/machinery/door/namedoor/try_to_activate_door(mob/user)
	add_fingerprint(user)
	if(operating)
		return
	if(check_name(user))
		if(density)
			open()
		else
			close()
	else if(density)
		do_animate("deny")

/obj/machinery/door/namedoor/update_icon_state()
	. = ..()
	icon_state = density ? "closed" : "open"

/obj/machinery/door/namedoor/proc/check_name(mob/user)
	if(user.real_name == owner_name)
		return TRUE
	return FALSE

/obj/machinery/door/namedoor/do_animate(animation)
	switch(animation)
		if("opening")
			flick("opening", src)
			playsound(src, 'sound/machines/blastdoor.ogg', 30, TRUE)
		if("closing")
			flick("closing", src)
			playsound(src, 'sound/machines/blastdoor.ogg', 30, TRUE)
		if("deny")
			//Deny animation would be nice to have.
			playsound(src, 'sound/machines/buzz-sigh.ogg', 30, TRUE)


/obj/projectile/beam/archonic/death
	name = "archonic annihilation beam"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	light_color = "#ff1a75"
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/archonic
	muzzle_type = /obj/effect/projectile/muzzle/archonic
	impact_type = /obj/effect/projectile/impact/archonic
	damage = 1000

/obj/projectile/beam/archonic/death/on_hit(atom/target, blocked = FALSE)
	. = ..()
	//new /obj/effect/temp_visual/archous_flash/huge/fading(get_turf(target))
	if(isliving(target)) //if the target isn't alive, so is a wall or something
		var/mob/living/M = target
		M.archonic_flash()
		M.dust()
	explosion(target, 2, 3, 4, 7)


/obj/effect/projectile/impact/archonic
	name = "archonic impact"
	icon_state = "impact_hcult"

/obj/effect/projectile/tracer/archonic
	name = "archonic beam"
	icon_state = "hcult"

/obj/effect/projectile/muzzle/archonic
	icon_state = "muzzle_hcult"
