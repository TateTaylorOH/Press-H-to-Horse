Scriptname DES_UnequipDeadHorse extends ObjectReference  
{Visually unequips armor from dead horses upon the miscitem being looted.}

Faction Property PlayerHorseFaction auto
Formlist Property DES_HorseArmors auto

EVENT OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	Actor DeadHorse = akOldContainer as Actor
	IF DeadHorse.IsDead()
		DeadHorse.RemoveItem(DES_HorseArmors)
		DeadHorse.UnequipAll()
	ENDIF
ENDEVENT