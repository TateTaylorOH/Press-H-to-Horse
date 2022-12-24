;/ Decompiled by Champollion V1.0.1
Source   : ccBGSSSE034_SaddleQuestScript.psc
Modified : 2021-08-19 11:15:01
Compiled : 2021-08-24 17:21:27
User     : builds
Computer : RKVBGSGPUVM04
/;
scriptName ccBGSSSE034_SaddleQuestScript extends Quest
{Handles changing saddle on and renaming last ridden horse}

;-- Properties --------------------------------------
actorbase[] property DisallowedHorses auto
faction property PlayerFaction auto
message property MessageNotEnoughGold auto
message property MessageNoHorsesOwned auto
armor property DummySaddle auto
Quest property Stables auto
message property ccBGSSSE034_MessageCantChangeSaddle auto
ccbgssse034_wildhorsesquestscript property WildHorsesQuest auto
cchorsearmorchangescript property CCHorseArmorDialogueQuest auto
faction property PlayerHorseFaction auto
message property MessageHorseNamed auto
message property MessageSaddleRemoved auto
message property MessageSaddleChanged auto
keyword property ccDisallowSaddleSwap auto
message property MessageCannotChangeSaddle auto
keyword property SpecialHorseKeyword auto
message property ccBGSSSE034_MessageMustBeTamedSaddle auto
referencealias property StablesPlayersHorse auto
miscobject property Gold001 auto

;-- Variables ---------------------------------------
Actor PlayerREF
Actor HorseToReSaddle
Actor HorseToRename

;-- Functions ---------------------------------------

function OnInit()

	PlayerREF = game.GetPlayer()
endFunction

; Skipped compiler generated GetState

; Skipped compiler generated GotoState

function ChangeHorseSaddle(armor SaddleToEquip)

	;HorseToReSaddle = game.GetPlayersLastRiddenHorse()
	;if !HorseToReSaddle && StablesPlayersHorse.GetActorReference() as Bool
		HorseToReSaddle = StablesPlayersHorse.GetActorReference()
	;endIf
	if HorseToReSaddle
		debug.trace("ccBGSSSE034: Current horse is " + HorseToReSaddle as String, 0)
		if DisallowedHorses.find(HorseToReSaddle.GetActorBase(), 0) != -1 || HorseToReSaddle.HasKeyword(ccDisallowSaddleSwap)
			debug.trace("CCBGSSSE034: Current horse cannot have saddle changed", 0)
			MessageCannotChangeSaddle.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
		elseIf HorseToReSaddle.HasKeyword(SpecialHorseKeyword) && !HorseToReSaddle.IsInFaction(PlayerHorseFaction)
			debug.trace("CCBGSSSE034: Current horse is still wild, cannot change saddle", 0)
			ccBGSSSE034_MessageMustBeTamedSaddle.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
		elseIf SaddleToEquip
			;if PlayerREF.GetItemCount(Gold001 as form) >= 100
				PlayerREF.RemoveItem(Gold001 as form, 100, false, none)
				CCHorseArmorDialogueQuest.RemoveHorseArmor()
				HorseToReSaddle.UnequipItemSlot(45)
				HorseToReSaddle.EquipItem(SaddleToEquip as form, 1 as Bool, false)
				MessageSaddleChanged.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
			;else
			;	MessageNotEnoughGold.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
			;endIf
		else
			CCHorseArmorDialogueQuest.RemoveHorseArmor()
			HorseToReSaddle.UnequipItemSlot(45)
			HorseToReSaddle.EquipItem(DummySaddle as form, 1 as Bool, false)
			MessageSaddleRemoved.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
		endIf
	else
		MessageNoHorsesOwned.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
	endIf
endFunction
