Scriptname DES_HorseCallTutorialTrackDismount extends Quest

Event OnInit()
    RegisterForAnimationEvent (PlayerRef, "tailHorseDismount")
EndEvent

Event OnPlayerLoad()
    RegisterForAnimationEvent (PlayerRef, "tailHorseDismount")
EndEvent

Actor Property PlayerRef Auto