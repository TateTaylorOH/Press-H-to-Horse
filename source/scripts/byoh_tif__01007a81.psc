;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname BYOH_TIF__01007A81 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
FUNCTION Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(GetOwningQuest() as BYOHHouseBuildingScript).BuyHorse(akSpeaker)
Actor MountToRename = (GetOwningQuest().getAliasByName("HouseHorse") as ReferenceAlias).GetActorRef()
(Quest.GetQuest("DES_RenameHorseQuest") as DES_RenameHorseQuestScript).renameAnyHorse(MountToRename)
(Quest.GetQuest("DES_RenameHorseQuest") as DES_HorseInventoryScript).FirstTimeEquipHorse(MountToRename)
;END CODE
ENDFUNCTION
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
