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

;-- FUNCTIONs ---------------------------------------

FUNCTION OnInit()

	PlayerREF = game.GetPlayer()
ENDFUNCTION

; Skipped compiler generated GetState

; Skipped compiler generated GoToState

FUNCTION ChangeHorseSaddle(armor SaddleToEquip)

	;HorseToReSaddle = game.GetPlayersLastRiddenHorse()
	;IF !HorseToReSaddle && StablesPlayersHorse.GetActorReference() as Bool
		HorseToReSaddle = StablesPlayersHorse.GetActorReference()
	;ENDIF
	IF HorseToReSaddle
		debug.trace("ccBGSSSE034: Current horse is " + HorseToReSaddle as String, 0)
		IF DisallowedHorses.find(HorseToReSaddle.GetActorBase(), 0) != -1 || HorseToReSaddle.HasKeyword(ccDisallowSaddleSwap)
			debug.trace("CCBGSSSE034: Current horse cannot have saddle changed", 0)
			MessageCannotChangeSaddle.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
		ELSEIF HorseToReSaddle.HasKeyword(SpecialHorseKeyword) && !HorseToReSaddle.IsInFaction(PlayerHorseFaction)
			debug.trace("CCBGSSSE034: Current horse is still wild, cannot change saddle", 0)
			ccBGSSSE034_MessageMustBeTamedSaddle.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
		ELSEIF SaddleToEquip
			;IF PlayerREF.GetItemCount(Gold001 as form) >= 100
				PlayerREF.RemoveItem(Gold001 as form, 100, false, none)
				CCHorseArmorDialogueQuest.RemoveHorseArmor()
				HorseToReSaddle.UnequipItemSlot(45)
				HorseToReSaddle.EquipItem(SaddleToEquip as form, 1 as Bool, false)
				MessageSaddleChanged.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
			;else
			;	MessageNotEnoughGold.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
			;ENDIF
		else
			CCHorseArmorDialogueQuest.RemoveHorseArmor()
			HorseToReSaddle.UnequipItemSlot(45)
			HorseToReSaddle.EquipItem(DummySaddle as form, 1 as Bool, false)
			MessageSaddleRemoved.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
		ENDIF
	else
		MessageNoHorsesOwned.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
	ENDIF
ENDFUNCTION
