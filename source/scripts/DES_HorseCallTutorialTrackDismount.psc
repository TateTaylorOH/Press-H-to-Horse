Scriptname DES_HorseCallTutorialTrackDismount extends ReferenceAlias

EVENT OnInit()
    RegisterForAnimationEVENT (PlayerRef, "tailHorseDismount")
ENDEVENT

EVENT OnPlayerLoad()
    RegisterForAnimationEVENT (PlayerRef, "tailHorseDismount")
ENDEVENT

Actor Property PlayerRef Auto