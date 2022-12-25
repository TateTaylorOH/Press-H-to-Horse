Scriptname DES_LouisDeathFrostScript   extends ReferenceAlias

EVENT onDeath(actor killer)
	Actor Frost = Game.GetFormFromFile(0x97E1E, "Skyrim.esm") as Actor
	(Quest.GetQuest("DES_RenameHorseQuest") as DES_RenameHorseQuestScript).EquipHorse(Frost)
ENDEVENT