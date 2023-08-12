Scriptname DES_HorseEquipScript extends ReferenceAlias  

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	Actor PlayersHorse = self.GetActorReference()
	(self.GetOwningQuest() as DES_HorseInventoryScript).EquipItem(akBaseItem, aiItemCount, akItemReference, akSourceContainer, PlayersHorse)
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	Actor PlayersHorse = self.GetActorReference()
	(self.GetOwningQuest() as DES_HorseInventoryScript).UnequipItem(akBaseItem, aiItemCount, akItemReference, akSourceContainer, PlayersHorse)
EndEvent