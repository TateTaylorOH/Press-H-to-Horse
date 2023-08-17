Scriptname DES_LouisDeathFrostScript   extends ReferenceAlias

EVENT onDeath(actor killer)
	Actor Frost = Game.GetFormFromFile(0x97E1F, "Skyrim.esm") as Actor
	(GetOwningQuest() as DES_HorseInventoryScript).FirstTimeEquipHorse(Frost)
	;debug.Notification("he dead")
ENDEVENT