Scriptname DES_HorseEquipScript extends ReferenceAlias  
{This script checks for OnItemAdded and OnItemRemoved EVENTs on the horse that is currently being interacted with. It will then call FUNCTIONs to control equipping and unequipping items.}

EVENT OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	Actor PlayersHorse = self.GetActorReference()
	(self.GetOwningQuest() as DES_HorseInventoryScript).EquipItem(akBaseItem, aiItemCount, akItemReference, akSourceContainer, PlayersHorse)
ENDEVENT

EVENT OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	Actor PlayersHorse = self.GetActorReference()
	(self.GetOwningQuest() as DES_HorseInventoryScript).UnequipItem(akBaseItem, aiItemCount, akItemReference, akSourceContainer, PlayersHorse)
ENDEVENT