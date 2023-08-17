;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname ccBGSSSE034_TIF__02000DEE Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(Quest.GetQuest("DES_HorseHandler") as DES_RenameHorseQuestScript).renameAnyHorse(MountToRename)
PlayerRef.RemoveItem(Gold001, 1500)
MountToRename.AddToFaction(DES_RegisteredHorses)
DES_IsWildHorse.SetValue(0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject Property Gold001 auto
Actor Property PlayerRef auto
GlobalVariable Property DES_IsWildHorse auto
Faction Property DES_RegisteredHorses auto
