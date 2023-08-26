Scriptname DES_ForceLastRiddenHorse extends ReferenceAlias  
{Force's the player last ridden horse to this alias.}

Event OnActivate(ObjectReference akActionRef)
	Clear()
	Utility.Wait(0.1)
	self.ForceRefTo(Game.GetPlayersLastRiddenHorse())
ENDEVENT