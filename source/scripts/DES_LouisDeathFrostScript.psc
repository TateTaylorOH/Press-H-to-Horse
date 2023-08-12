Scriptname DES_LouisDeathFrostScript   extends ReferenceAlias

EVENT onDeath(actor killer)
	Actor Frost = Game.GetFormFromFile(0x97E1F, "Skyrim.esm") as Actor
	(Quest.GetQuest("DES_RenameHorseQuest") as DES_HorseInventoryScript).FirstTimeEquipHorse(Frost)
	;debug.NotIFication("he dead")
ENDEVENT