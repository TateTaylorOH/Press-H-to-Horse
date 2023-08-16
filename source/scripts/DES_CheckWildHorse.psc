Scriptname DES_CheckWildHorse extends ReferenceAlias  
{This script checks to see if wild horses are still named "Wild Horse". H2Horse will not allow you to equip horses named exactly "Wild Horse" so that people need to pay to register them.}

GlobalVariable Property DES_IsWildHorse auto

Event OnActivate(ObjectReference akActionRef)
	Actor ThisHorse = self.GetActorRef()
	IF (ThisHorse.GetDisplayName()) == "Wild Horse"
		DES_IsWildHorse.SetValue(1)
	ELSE
		DES_IsWildHorse.SetValue(0)
	ENDIF
ENDEVENT