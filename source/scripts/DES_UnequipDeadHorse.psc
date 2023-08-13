Scriptname DES_UnequipDeadHorse extends ReferenceAlias  

Faction Property PlayerHorseFaction auto
Formlist Property DES_HorseArmors auto
Keyword Property DES_SaddleKeyword auto
Keyword Property DES_ArmorKeyword auto

EVENT OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	IF akBaseItem.HasKeyword(DES_SaddleKeyword) || akBaseItem.HasKeyword(DES_ArmorKeyword) && (akSourceContainer as Actor).IsInFaction(PlayerHorseFaction)
		(akSourceContainer as Actor).RemoveItem(DES_HorseArmors)
		(akSourceContainer as Actor).UnequipAll()
	ENDIF
ENDEVENT