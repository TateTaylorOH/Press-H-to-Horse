Scriptname DES_RegisterAnimationOnPlayerLoad extends ReferenceAlias

Actor Property PlayerRef auto

EVENT OnPlayerLoadGame()
	RegisterForAnimationEVENT(PlayerRef, "tailHorseDismount")
ENDEVENT