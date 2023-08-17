Scriptname DES_CheckWildHorse extends ReferenceAlias  
{This script checks to see if wild horses are in the DES_RegisteredHorses faction. H2Horse will not allow you to equip horses if they are not in that faction so that people need to pay to fully use their Wild Horses.}

GlobalVariable Property DES_IsWildHorse auto
Faction Property DES_RegisteredHorses auto

Event OnActivate(ObjectReference akActionRef)
	Actor ThisHorse = self.GetActorRef()
	IF !ThisHorse.IsInFaction(DES_RegisteredHorses)
		DES_IsWildHorse.SetValue(1)
	ELSE
		DES_IsWildHorse.SetValue(0)
	ENDIF
ENDEVENT