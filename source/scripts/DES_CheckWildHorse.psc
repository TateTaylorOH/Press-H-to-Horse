Scriptname DES_CheckWildHorse extends ReferenceAlias  

GlobalVariable Property DES_IsWildHorse auto

Event OnActivate(ObjectReference akActionRef)
	Actor ThisHorse = self.GetActorRef()
	IF (ThisHorse.GetDisplayName()) == "Wild Horse"
		DES_IsWildHorse.SetValue(1)
	ELSE
		DES_IsWildHorse.SetValue(0)
	ENDIF
ENDEVENT