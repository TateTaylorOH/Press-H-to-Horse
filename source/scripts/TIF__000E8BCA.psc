;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname TIF__000E8BCA Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
FUNCTION Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
pFDS.Persuade(akSpeaker)
;END CODE
ENDFUNCTION
;END FRAGMENT

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

FavorDialogueScript Property pFDS  Auto  
