Scriptname DES_LouisDeathFrostScript   extends ReferenceAlias

EVENT onDeath(actor killer)
	Actor Frost = MS03Grane.getactorreference()
	Frost.SetAV("CarryWeight", 100.0)
	Frost.AddSpell(DES_HorseFear)
	(PlayersHorseEquipAlias as DES_HorseEquipScript).SaddleBags = True
	Frost.AddItem(DES_Saddle, 1)
ENDEVENT

ReferenceAlias Property MS03Grane auto
Spell Property DES_HorseFear auto
ReferenceAlias Property PlayersHorseEquipAlias auto
MiscObject Property DES_Saddle auto