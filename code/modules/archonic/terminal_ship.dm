/obj/machinery/launchpad/violetspace
	name = "violetspace launchpad"
	desc = "A violetspace pad able to rotate matter through violetspace, teleporting it to or from any location."
	icon = 'code/modules/archonic/icons/items_and_weapons.dmi'
	icon_state = "vpad-idle"
	icon_teleport = "vpad-beam"
	use_power = FALSE
	stationary = FALSE //only used to prevent deconstruction
	idle_power_usage = 0
	active_power_usage = 0
	teleport_speed = 9
	range = 250
	teleport_beam = "cosmic_beam"
	display_name = "VSLP-P-018"

/obj/machinery/launchpad/violetspace/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/violetspace_launchpad_remote))
		var/obj/item/violetspace_launchpad_remote/L = I
		if(L.pad == WEAKREF(src)) //do not attempt to link when already linked
			return ..()
		L.pad = WEAKREF(src)
		to_chat(user, "<span class='notice'>You link [src] to [L].</span>")
	else
		return ..()

/obj/item/violetspace_launchpad_remote
	name = "violetspace navigator"
	desc = "A crystal that can be used to hook onto the violetspace launchpad and navigate reality."
	icon = 'code/modules/archonic/icons/items_and_weapons.dmi'
	icon_state = "archonic_crystal"
	w_class = WEIGHT_CLASS_SMALL
	var/sending = TRUE
	//A weakref to our linked pad
	var/datum/weakref/pad

/obj/item/violetspace_launchpad_remote/Initialize(mapload, pad) //remote spawns linked to the briefcase pad
	. = ..()
	src.pad = WEAKREF(pad)

/obj/item/violetspace_launchpad_remote/attack_self(mob/user)
	. = ..()
	ui_interact(user)
	to_chat(user, span_notice("[src] projects a display onto your mind."))


/obj/item/violetspace_launchpad_remote/ui_state(mob/user)
	return GLOB.inventory_state

/obj/item/violetspace_launchpad_remote/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "VioletPadRemote")
		ui.open()
	ui.set_autoupdate(TRUE)

/obj/item/violetspace_launchpad_remote/ui_data(mob/user)
	var/list/data = list()
	var/obj/machinery/launchpad/violetspace/our_pad = pad.resolve()
	data["has_pad"] = our_pad ? TRUE : FALSE
	if(!our_pad)
		return data

	data["pad_name"] = our_pad.display_name
	data["range"] = our_pad.range
	data["x"] = our_pad.x_offset
	data["y"] = our_pad.y_offset
	return data

/obj/item/violetspace_launchpad_remote/proc/teleport(mob/user, obj/machinery/launchpad/pad)
	if(QDELETED(pad))
		to_chat(user, span_warning("ERROR: Launchpad not responding. Check launchpad integrity."))
		return
	var/error_reason = pad.teleport_checks()
	if(error_reason)
		to_chat(user, span_warning(error_reason))
		return
	pad.doteleport(user, sending)

/obj/item/violetspace_launchpad_remote/ui_act(action, params)
	. = ..()
	if(.)
		return
	var/obj/machinery/launchpad/violetspace/our_pad = pad.resolve()
	if(!our_pad)
		pad = null
		return TRUE
	switch(action)
		if("set_pos")
			var/new_x = text2num(params["x"])
			var/new_y = text2num(params["y"])
			our_pad.set_offset(new_x, new_y)
			. = TRUE
		if("move_pos")
			var/plus_x = text2num(params["x"])
			var/plus_y = text2num(params["y"])
			our_pad.set_offset(
				x = our_pad.x_offset + plus_x,
				y = our_pad.y_offset + plus_y
			)
			. = TRUE
		if("rename")
			. = TRUE
			var/new_name = params["name"]
			if(!new_name)
				return
			our_pad.display_name = new_name
		if("remove")
			. = TRUE
			if(usr && tgui_alert(usr, "Are you sure?", "Unlink Launchpad", list("Confirm", "Abort")) == "I'm Sure")
				our_pad = null
		if("launch")
			sending = TRUE
			teleport(usr, our_pad)
			. = TRUE
		if("pull")
			sending = FALSE
			teleport(usr, our_pad)
			. = TRUE

/obj/structure/window/plasma/reinforced/plastitanium/archonic
	name = "archonic crystal window"
	desc = "A durable looking window made archonic crystal."
	max_integrity = 600
	explosion_block = 50
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
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | LAVA_PROOF
	damage_deflection = 70
	var/owner_name = "Crux CF"

/obj/machinery/door/namedoor/Bumped(atom/movable/AM)
	return !density && ..()

/obj/machinery/door/namedoor/try_to_activate_door(mob/user, access_bypass = FALSE)
	add_fingerprint(user)
	if(operating)
		return
	if(check_name(user))
		if(density)
			open()
		else
			close()
	else if(density)
		run_animation(DOOR_DENY_ANIMATION)

/obj/machinery/door/namedoor/update_icon_state()
	. = ..()
	icon_state = density ? "closed" : "open"

/obj/machinery/door/namedoor/proc/check_name(mob/user)
	if(user.real_name == owner_name)
		return TRUE
	return FALSE

/obj/machinery/door/namedoor/animation_effects(animation)
	switch(animation)
		if(DOOR_OPENING_ANIMATION)
			playsound(src, 'sound/machines/blastdoor.ogg', 30, TRUE)
		if(DOOR_CLOSING_ANIMATION)
			playsound(src, 'sound/machines/blastdoor.ogg', 30, TRUE)
		if(DOOR_DENY_ANIMATION)
			//Deny animation would be nice to have.
			playsound(src, 'sound/machines/buzz-sigh.ogg', 30, TRUE)

/obj/projectile/beam/archonic/death
	damage = 300
	hitscan = TRUE
	muzzle_type = /obj/effect/projectile/muzzle/laser/emitter
	tracer_type = /obj/effect/projectile/tracer/laser/emitter
	impact_type = /obj/effect/projectile/impact/laser/emitter
	impact_effect_type = null
	light_color = "#80002A"
	hitscan_light_intensity = 3
	hitscan_light_range = 0.75
	hitscan_light_color_override = "#80002A"
	muzzle_flash_intensity = 6
	muzzle_flash_range = 2
	muzzle_flash_color_override = "#80002A"
	impact_light_intensity = 7
	impact_light_range = 5.5
	impact_light_color_override = "#ca0054"

/obj/projectile/beam/archonic/death/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	new /obj/effect/temp_visual/archous_flash/huge/fading(get_turf(target))
	if(isliving(target))
		var/mob/living/L = target
		L.archonic_flash()
		L.dust(TRUE, TRUE)
	explosion(target, heavy_impact_range = 2, light_impact_range = 3, flame_range = 0, flash_range = 9, explosion_cause = src)


/obj/effect/projectile/impact/archonic
	name = "archonic impact"
	icon_state = "impact_hcult"

/obj/effect/projectile/tracer/archonic
	name = "archonic beam"
	icon_state = "hcult"

/obj/effect/projectile/muzzle/archonic
	icon_state = "muzzle_hcult"
