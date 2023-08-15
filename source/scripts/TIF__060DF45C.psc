;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__060DF45C Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor MountToRename = Game.GetPlayersLastRiddenHorse()
(Quest.GetQuest("DES_HorseHandler") as DES_RenameHorseQuestScript).renameUniqueHorse(MountToRename, (Game.GetPlayersLastRiddenHorse().GetDisplayName()))
PlayerRef.RemoveItem(Gold001, 500)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject Property Gold001 auto
Actor Property PlayerRef auto
