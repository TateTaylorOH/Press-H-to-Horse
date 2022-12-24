;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF__000E8BC3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor Frost = MS03Grane.getactorreference()
Frost.SetAV("CarryWeight", 100.0)
Frost.AddSpell(DES_HorseFear)
(PlayersHorseEquipAlias as DES_HorseEquipScript).SaddleBags = True
Frost.AddItem(DES_Saddle, 1)
GetOwningQuest().setStage(225)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

FavorDialogueScript Property DialogueFavorGeneric  Auto

Spell Property DES_HorseFear auto

MiscObject Property DES_Saddle auto

ReferenceAlias Property PlayersHorseEquipAlias auto

ReferenceAlias Property MS03Grane auto
