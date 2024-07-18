#define INTERFACE_MESSAGE 1
#define INTERFACE_CONTROL 2
#define INTERFACE_RESTRAIN 3
#define SOE_HEALTH_RESTORE -50


/*
//////////////////////////Items & Outfits////////////////////////////
*/

/obj/item/spear/archous
	icon_state = "archonic_spear0"
	name = "\improper Archonic Shard"
	desc = "A shard of archonic crystal, transformed into a powerful weapon. The prefered weapon of archonicists."
	icon = 'code/modules/archonic/icons/items_and_weapons.dmi'
	base_icon_state = "archonic_spear"
	icon_prefix = "archonic_spear"
	worn_icon_state = "none"
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	lefthand_file = 'code/modules/archonic/icons/inhands/lefthand.dmi'
	righthand_file = 'code/modules/archonic/icons/inhands/righthand.dmi'
	sharpness = SHARP_EDGED
	force = 30
	throwforce = 250
	wound_bonus = 0
	bare_wound_bonus = 20
	block_chance = 120
	armour_penetration = 200
	max_integrity = 300
	var/wielded = FALSE
	force_unwielded = 30
	force_wielded = 80

/obj/item/spear/archous/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, PROC_REF(on_unwield))

/// triggered on wield of two handed item
/obj/item/spear/archous/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER
	sharpness = SHARP_POINTY
	attack_verb_continuous = list("stabs", "jabs", "impales", "penetrates", "preforates")
	attack_verb_simple = list("stab", "jab", "impale", "penetrate", "preforate")
	wielded = TRUE

/// triggered on unwield of two handed item
/obj/item/spear/archous/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")

	wielded = FALSE

/obj/item/spear/archous/attack(mob/living/M, mob/user)
	. = ..()
	if(wielded)
		M.archonic_flash()

/obj/item/spear/archous/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(prob(final_block_chance))
		if(attack_type == PROJECTILE_ATTACK)
			owner.visible_message("<span class='danger'>[owner] absorbs [attack_text] with [src]!</span>")
			playsound(src, 'sound/weapons/sear.ogg', 100, TRUE)
			return TRUE
		else
			playsound(src, 'sound/weapons/parry.ogg', 75, TRUE)
			owner.visible_message("<span class='danger'>[owner] parries [attack_text] with [src]!</span>")
			return TRUE
	return FALSE

/obj/machinery/power/rtg/abductor/archonic
	name = "Archonic Tap"
	desc = "An archonic power source that produces energy from a tether to Archous's light."
	var/deactivated = FALSE

/obj/machinery/power/rtg/abductor/archonic/examine(mob/user)
	. = ..()
	if(deactivated)
		. += "<span class='revenminor'>The status display reads: Tether failure detected.</span>"
		return
	if(in_range(user, src) || isobserver(user))
		. += "<span class='notice'>The status display reads: Power generation now at <b>[power_gen*0.001]</b>kW.</span>"

/obj/machinery/power/rtg/abductor/archonic/proc/deactivate()
	visible_message("<span class='revenwarning'>\The [src]'s lights flicker off.</span>")
	deactivated = TRUE
	power_gen = 0

/obj/machinery/power/rtg/abductor/archonic/proc/reactivate()
	visible_message("<span class='revenwarning'>\The [src]'s lights turn back on with a faint hum.</span>")
	deactivated = FALSE
	power_gen = 20000

/obj/item/abductor/alien_omnitool/archonic
	name = "violet actuator"

/obj/item/archonic
	icon = 'icons/obj/antags/abductor.dmi'
	lefthand_file = 'icons/mob/inhands/antag/abductor_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/abductor_righthand.dmi'

/obj/item/proc/ArchonicCheck(mob/user)
	if(HAS_TRAIT(user, TRAIT_ABDUCTOR_TRAINING))
		return TRUE
	if(istype(user) && user.mind && HAS_TRAIT(user.mind, TRAIT_ABDUCTOR_TRAINING))
		return TRUE
	to_chat(user, "<span class='warning'>You can't figure out how this works!</span>")
	user.dropItemToGround(src, TRUE)
	if(ishuman(user))
		to_chat(user, "<span class='revendanger'>[src] heats up to an extreme temperature, burning your hand!</span>")
		var/mob/living/carbon/human/H = user
		H.Paralyze(70, TRUE)
		H.apply_damage(50, BURN, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
	return FALSE

/obj/item/archonic/interface_system
	name = "archonic interface system"
	desc = "A multi-purpose tool designed to archonically communitcate, restrain, or command anyone using an archonic bioresonance mimicry system."
	icon_state = "mind_device_message"
	inhand_icon_state = "silencer"
	var/mode = INTERFACE_MESSAGE
	var/modename = "TRANSMISSION"
	var/charge = 100
	var/self_charge = TRUE
	var/charge_amount = 5

/obj/item/archonic/interface_system/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/archonic/interface_system/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/archonic/interface_system/vv_edit_var(var_name, var_value)
	switch(var_name)
		if(NAMEOF(src, self_charge))
			if(var_value)
				START_PROCESSING(SSobj, src)
			else
				STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/archonic/interface_system/process()
	if(self_charge)
		if(charge < 100)
			adjust_charge(5)
	else
		return PROCESS_KILL

/obj/item/archonic/interface_system/proc/adjust_charge(amount)
	if(amount >= 0)
		charge = clamp(charge+amount, 0, 100)
		return TRUE
	else
		charge = clamp(charge+amount, 0, 100)
		return TRUE

/obj/item/archonic/interface_system/examine(mob/user)
	. = ..()
	if(!self_charge)
		. += "<span class='revenminor'>The internal archonic crystal reports a failure to form an archonic tether. Use sparingly.</span>"
	. += "The internal archonic crystal reports a <span class='hierophant'>[charge]%</span> internal charge."

/obj/item/archonic/interface_system/attack_self(mob/user)
	if(!ArchonicCheck(user))
		return

	switch(mode)
		if(INTERFACE_MESSAGE)
			mode = INTERFACE_CONTROL
			icon_state = "mind_device_control"
			modename = "COMMAND"
		if(INTERFACE_CONTROL)
			mode = INTERFACE_RESTRAIN
			icon_state = "mind_device_control"
			modename = "RESTRAIN"
		if(INTERFACE_RESTRAIN)
			mode = INTERFACE_MESSAGE
			icon_state = "mind_device_message"
			modename = "TRANSMISSION"
	to_chat(user, "<span class='notice'>You switch the device to [modename] MODE</span>")

/obj/item/archonic/interface_system/afterattack(atom/target, mob/living/user, flag, params)
	. = ..()
	if(!ArchonicCheck(user))
		return

	switch(mode)
		if(INTERFACE_CONTROL)
			interface_control(target, user)
		if(INTERFACE_RESTRAIN)
			interface_restrain(target, user)
		if(INTERFACE_MESSAGE)
			interface_message(target, user)

/obj/item/archonic/interface_system/proc/interface_control(atom/target, mob/living/user)
	if(ismachinery(target))
		interact_machine(target, user)
		return
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		var/command = stripped_input(user, "Enter the command for your target to follow.","Enter command")

		if(!command)
			if(C.mind && C.mind.has_antag_datum(/datum/antagonist/brainwashed))
				if(charge < 10)
					to_chat(user, "<span class='revennotice'>The archonic crystal within [src] hums uselessly.</span>")
					return
				adjust_charge(-10)
				to_chat(C, "<span class='revendanger'>[user]'s archonic interface system flashes into your eyes, clearing your mind of its influence.</span>")
				C.mind.remove_antag_datum(/datum/antagonist/brainwashed)
			return

		if(charge < 70)
			to_chat(user, "<span class='revennotice'>The archonic crystal within [src] hums uselessly.</span>")
			return

		if(QDELETED(user) || user.get_active_held_item() != src || loc != user)
			return

		adjust_charge(-70)
		new /obj/effect/temp_visual/archous_flash/fading(get_turf(src))
		C.archonic_flash()
		brainwash(C, command)
		to_chat(C, "<span class='revendanger'>A flash of violet light shoots out of [user]'s archonic interface system and burns into your eyes.</span>")
		user.visible_message("<span class='revenwarning'>[src] emits a flash of violet light</span>")
		to_chat(user, "<span class='revennotice'>You send the command to your target.</span>")

/obj/item/archonic/interface_system/proc/interface_message(atom/target, mob/living/user)
	if(ismachinery(target))
		interact_machine(target, user)
		return
	if(isliving(target))
		var/mob/living/L = target
		if(L.stat == DEAD)
			to_chat(user, "<span class='revenwarning'>Your target is dead!</span>")
			return
		var/message = stripped_input(user, "Write a message to send to your target's brain.","Enter message")
		if(!message)
			return
		if(QDELETED(L) || L.stat == DEAD)
			return

		if(charge < 1)
			to_chat(user, "<span class='revennotice'>The archonic crystal within [src] hums uselessly.</span>")
			return
		adjust_charge(-1)
		to_chat(L, "<span class='revenwarning'>You hear a voice in your head saying: </span><span class='hypnophrase'>[message]</span>")
		to_chat(user, "<span class='revennotice'>You send the message to your target.</span>")
		log_directed_talk(user, L, message, LOG_SAY, "abductor whisper")

/obj/item/archonic/interface_system/proc/interface_restrain(atom/target, mob/living/user)
	if(ismachinery(target))
		var/obj/machinery/M = target
		if(charge < 5)
			to_chat(user, "<span class='revennotice'>The archonic crystal within [src] hums uselessly.</span>")
			return
		adjust_charge(-5)
		M.emp_act(1)
		to_chat(user, "<span class='revennotice'>You deliver an electromagnetic pulse to your target.</span>")
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		if(C.stat == DEAD)
			to_chat(user, "<span class='revenwarning'>Your target is dead!</span>")
			return
		if(QDELETED(C) || C.stat == DEAD)
			return

		if(charge < 5)
			to_chat(user, "<span class='revennotice'>The archonic crystal within [src] hums uselessly.</span>")
			return
		adjust_charge(-5, user)

		to_chat(user, "<span class='revennotice'>You restrain your target.</span>")
		to_chat(C, "<span class='revenwarning'>Violet wires shoot out from [user]'s archonic interface system and wrap around you, holding you still. The wires quickly fade away, but their effect lingers.</span>")
		C.Paralyze(300, TRUE)
		C.Knockdown(400, TRUE)

/obj/item/archonic/interface_system/proc/interact_machine(atom/target, mob/living/user)
	var/obj/machinery/machine = target
	if(istype(machine, /obj/machinery/door))
		var/obj/machinery/door/D = machine
		if(charge < 1)
			to_chat(user, "<span class='revennotice'>The archonic crystal within [src] hums uselessly.</span>")
			return
		to_chat(user, "<span class='revennotice'>You point [src] at [src], forcing it to open.</span>")
		adjust_charge(-1)
		if(istype(D, /obj/machinery/door/airlock))
			var/obj/machinery/door/airlock/A = D
			A.locked = FALSE
		D.open()
		return

/*
///////////////////////////Archonic Flash///////////////////////////
*/

/obj/effect/temp_visual/silence_lightning
	icon = 'code/modules/archonic/icons/96x96.dmi'
	icon_state = "overaelectric"
	duration = 20
	pixel_x = -32
	pixel_y = -32
	alpha = 1

/obj/effect/temp_visual/silence_lightning/Initialize()
	. = ..()
	animate(src, alpha = 255, time = 5)

/obj/effect/temp_visual/archous_flash
	icon = 'code/modules/archonic/icons/96x96.dmi'
	icon_state = "arch_flash"
	plane = ABOVE_LIGHTING_PLANE
	duration = 12
	pixel_x = -32
	pixel_y = -32

/obj/effect/temp_visual/archous_flash/fading/Initialize()
	. = ..()
	animate(src, alpha = 0, time = duration)

/obj/effect/temp_visual/archous_flash/large
	icon = 'code/modules/archonic/icons/160x160.dmi'
	icon_state = "arch_flash"
	duration = 13
	pixel_x = -64
	pixel_y = -64

/obj/effect/temp_visual/archous_flash/large/fading/Initialize()
	. = ..()
	animate(src, alpha = 0, time = duration)

/obj/effect/temp_visual/archous_flash/huge
	icon = 'code/modules/archonic/icons/288x288.dmi'
	icon_state = "arch_flash"
	duration = 14
	pixel_x = -128
	pixel_y = -128

/obj/effect/temp_visual/archous_flash/huge/fading/Initialize()
	. = ..()
	animate(src, alpha = 0, time = duration)


/atom/movable/screen/fullscreen/archous_flash
	icon = 'code/modules/archonic/icons/fullscreen.dmi'
	icon_state = "archonic_flash"
	layer = CURSE_LAYER
	plane = FULLSCREEN_PLANE

/mob/living/proc/archonic_flash(type = /atom/movable/screen/fullscreen/archous_flash)
	overlay_fullscreen("archous", type)
	addtimer(CALLBACK(src, PROC_REF(clear_fullscreen), "archous", 25), 25)
	return TRUE

#undef INTERFACE_MESSAGE
#undef INTERFACE_CONTROL
#undef INTERFACE_RESTRAIN
#undef SOE_HEALTH_RESTORE
