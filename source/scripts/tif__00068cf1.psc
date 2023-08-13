;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname TIF__00068CF1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
FUNCTION Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
Game.GetPlayer().RemoveItem(Gold001, horsecost.value as int)
Alias_Horse.GetActorRef().SetFactionRank(PlayerHorseFaction, 1)
Alias_Horse.GetActorRef().SetFactionOwner(PlayerFaction)
PlayersHorse.ForceRefTo(Alias_Horse.GetActorRef())
game.IncrementStat( "Horses Owned" )
Actor MountToRename = Alias_Horse.GetActorRef()
(Quest.GetQuest("DES_HorseHandler") as DES_RenameHorseQuestScript).renameUniqueHorse(MountToRename, "Queen Alfsigr")
(Quest.GetQuest("DES_HorseHandler") as DES_HorseInventoryScript).FirstTimeEquipHorse(MountToRename)
;END CODE
ENDFUNCTION
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property PlayerHorseFaction  Auto  

MiscObject Property Gold001  Auto  

ReferenceAlias Property Alias_Horse  Auto  

Faction Property PlayerFaction  Auto  

ReferenceAlias Property PlayersHorse  Auto  

GlobalVariable Property Horsecost  Auto  
