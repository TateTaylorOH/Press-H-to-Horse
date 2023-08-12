Scriptname DES_RegisterAnimationOnPlayerLoad extends ReferenceAlias

Actor Property PlayerRef auto

Event OnPlayerLoadGame()
	RegisterForAnimationEvent(PlayerRef, "tailHorseDismount")
EndEvent