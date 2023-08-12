;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF__000E8BC3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
FUNCTION Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor Frost = Game.GetFormFromFile(0x97E1F, "Skyrim.esm") as Actor
(Quest.GetQuest("DES_RenameHorseQuest") as DES_HorseInventoryScript).FirstTimeEquipHorse(Frost)
GetOwningQuest().setStage(225)
;END CODE
ENDFUNCTION
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

FavorDialogueScript Property DialogueFavorGeneric  Auto
