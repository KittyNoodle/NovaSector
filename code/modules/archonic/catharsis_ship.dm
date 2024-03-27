/obj/item/clothing/gloves/color/yellow/black
	desc = "These gloves provide protection against electric shock. Made without the premium yellow coating, probably for cost reasons."
	name = "black insulated gloves"
	icon_state = "black"
	item_state = "blackgloves"

/obj/item/storage/belt/utility/black
	name = "toolbelt"
	desc = "Holds tools. This one is made of cheap synthleather."
	icon_state = "assault"
	item_state = "assault"

/obj/item/storage/belt/utility/black/full/PopulateContents()
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool(src)
	new /obj/item/crowbar(src)
	new /obj/item/wirecutters(src)
	new /obj/item/multitool(src)
	new /obj/item/stack/cable_coil(src,MAXCOIL,pick("red","yellow","orange"))

//HOLODISKS

/datum/preset_holoimage/nanocommander
	outfit_type = /datum/outfit/centcom/commander

/datum/preset_holoimage/ai
	nonhuman_mobtype = /mob/living/silicon/ai

/obj/item/disk/holodisk/catharsis/intro
	name = "Catharsis-Class Introduction Message"
	desc = "A holodisk containing the introductory message for the Catharsis-Class."
	preset_image_type = /datum/preset_holoimage/nanocommander
	preset_record_text = {"
	NAME Admiral Abraxis Rayne
	SAY Greetings crew of the Catharsis-Class.
	DELAY 65
	SAY As you may be aware, the Catharsis-Class is the primary vessel for the Nanotrasen Frontier Exploration Program.
	DELAY 80
	SAY The Catharsis-Class is equipped with the equipment necessary to hook onto the Nanotrasen Bluespace Slingshot System, a state-of-the-art transit system capable of extreme long-range transport.
	DELAY 100
	SAY For Mission Details, insert disk #2.
	DELAY 60
	SAY For Reactor Information and Maintenance, insert disk #3
	DELAY 60
	"}


/obj/item/disk/holodisk/catharsis/mission
	name = "Catharsis-Class DISK #2"
	desc = "A holodisk containing the mission details for the Catharsis-Class."
	preset_image_type = /datum/preset_holoimage/nanocommander
	preset_record_text = {"
	NAME Admiral Abraxis Rayne
	SAY Greetings crew of the Catharsis-Class.
	DELAY 75
	SAY The Nanotrasen Frontier Exploration Program was devised by visionary tactician and expert negotiator Commander Cristal-Spire to assist in the current corporate cold war.
	DELAY 100
	SAY Your mission and the mission of all others within the NTFEP takes you beyond the outer controlled systems, and past the limits of the ███████ █████████ ████.
	DELAY 100
	SAY Utilizing the long-range sensors on board every Catharsis-Class vessel, you will scout for suitible locations for Nanotrasen resource collection initiatives.
	DELAY 100
	SAY Every Catharsis-Class ship is equipped with a Pilot, Engineering Specialist, Endurance Specialist, and Medical Specialist. Further directons for each specalist are located in their quarters.
	DELAY 100
	SAY Remember, your mission is of high importance to Nanotrasen, and any attempts to mutiny are therefore punishable by death.
	DELAY 85
	SAY Glory to Nanotrasen!
	DELAY 70
	"}

/obj/item/disk/holodisk/catharsis/reactor
	name = "Catharsis-Class DISK #3"
	desc = "A holodisk containing the reactor information for the Catharsis-Class."
	preset_image_type = /datum/preset_holoimage/nanocommander
	preset_record_text = {"
	NAME Admiral Abraxis Rayne
	SAY Greetings crew of the Catharsis-Class.
	DELAY 45
	SAY The Catharsis-Class is equipped with a "Self Regulating Fission Pile Generator" or SRFPG.
	DELAY 70
	SAY The SRFPG was designed as low-cost low-risk alternative for the Supermatter Engine for the Catharsis, operating on a peak power generaton lifespan of 50 years.
	DELAY 80
	SAY The SRFPG is cabible of running entirely autonomously as long as it recives proper maintenance from your qualified engineering specialist, who is tasked with replacing worn down components of the SRFPG.
	DELAY 100
	SAY Replacement parts are located on the bow-facing side of the reactor. The longevity of your part supplies are heavily dependant on your engineer's punctuality with repair.
	DELAY 80
	SAY In the event of a radiation leak, there are radiation suits present in the reactor chamber.
	DELAY 70
	SAY Remember, the faster the repair, the longer the supplies last.
	DELAY 70
	"}

/obj/item/disk/holodisk/catharsis/engineering
	name = "Catharsis-Class Engineer Instruction"
	desc = "A holodisk containing the engineer instructions for the Catharsis-Class."
	preset_image_type = /datum/preset_holoimage/nanocommander
	preset_record_text = {"
	NAME Admiral Abraxis Rayne
	SAY Greetings Engineer of the Catharsis-Class.
	DELAY 55
	SAY G-G-G-G- #%&#*@-
	SOUND spark
	DELAY 50
	PRESET /datum/preset_holoimage/ai
	NAME Automated Error Handler
	SAY Data Corrupted. Unable to Read.
	DELAY 50
	"}

/obj/item/disk/holodisk/catharsis/medical
	name = "Catharsis-Class Medical Instruction"
	desc = "A holodisk containing the medical instructions for the Catharsis-Class."
	preset_image_type = /datum/preset_holoimage/nanocommander
	preset_record_text = {"
	NAME Admiral Abraxis Rayne
	SAY Greetings Medical Technican of the Catharsis-Class.
	DELAY 55
	SAY The Catharsis-Class is equipped with medical equipment for every situation, including a defibrillator in the case of a medical emergency.
	DELAY 70
	SAY Your primary purpose is to maintain the functionality of the crew of the Catharsis-Class. In the event that this is not possible please conta-a-a-a-a- $&#*$!&$-
	SOUND spark
	DELAY 50
	PRESET /datum/preset_holoimage/ai
	NAME Automated Error Handler
	SAY Data Corrupted. Unable to Read.
	DELAY 50
	"}

/obj/item/disk/holodisk/catharsis/endurance
	name = "Catharsis-Class Endurance Instruction"
	desc = "A holodisk containing the endurance instructions for the Catharsis-Class."
	preset_image_type = /datum/preset_holoimage/nanocommander
	preset_record_text = {"
	NAME Admiral Abraxis Rayne
	SAY Greetings Endurance Specialist of the Catharsis-Class.
	DELAY 55
	SAY Your mission, as the Endurance Specialist, is to provide food for the crew, alongside supporting crew cohesion and treating any psychological problems that may appear.
	DELAY 70
	SAY The Catharsis-Class is outfitted with a fully operational kitchen, complete with two freezers a food processor, and a microwave.
	DELAY 50
	SAY You also have a fully stocked Booze-O-Mat in your kitchen.
	DELAY 50
	SAY Glory to Nanotrasen.
	DELAY 50
	"}
