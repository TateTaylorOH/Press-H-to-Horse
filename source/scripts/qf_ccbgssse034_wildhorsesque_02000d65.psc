;/ Decompiled by Champollion V1.0.1
Source   : QF_ccBGSSSE034_WildHorsesQue_02000D65.psc
ModIFied : 2021-08-19 11:15:00
Compiled : 2021-08-24 17:21:27
User     : builds
Computer : RKVBGSGPUVM04
/;
scriptName QF_ccBGSSSE034_WildHorsesQue_02000D65 extends Quest hidden

;-- Properties --------------------------------------
Quest property ccBGSSSE034_Misc_Horse07_BrownSpotted auto
referencealias property Alias_HorseWild07_WhiteSpotted auto
referencealias property Alias_HorseMap auto
referencealias property Alias_HorseName07 auto
referencealias property Alias_HorseName27 auto
referencealias property Alias_HorseName23 auto
referencealias property Alias_HorseName18 auto
referencealias property Alias_HostlerRef auto
referencealias property Alias_HorseName09 auto
referencealias property Alias_HorseName17 auto
Quest property ccBGSSSE034_Misc_Horse06_WhiteSpotted auto
referencealias property Alias_HorseName02 auto
referencealias property Alias_HorseName01 auto
referencealias property Alias_HorseWild08_UnicornREF auto
referencealias property Alias_HorseName22 auto
referencealias property Alias_HorseWild04_RedBrown auto
Quest property ccBGSSSE034_Misc_Horse05_RedBrown auto
referencealias property Alias_HorseName20 auto
referencealias property Alias_HorseName08 auto
referencealias property Alias_HorseWild05_Pale auto
miscobject property HorseMap auto
referencealias property Alias_HorseName16 auto
Quest property ccBGSSSE034_Misc_Horse02_Black auto
Quest property ccBGSSSE034_Misc_Horse01_Chestnut auto
referencealias property Alias_HorseName14 auto
referencealias property Alias_HorseName29 auto
globalvariable property TamedHorseCounter auto
Quest property ccBGSSSE034_Misc_Horse03_GreyBlack auto
referencealias property Alias_HorseName03 auto
referencealias property Alias_HorseName12 auto
referencealias property Alias_HorseNotes auto
referencealias property Alias_HorseName19 auto
referencealias property Alias_HorseWild06_BrownSpotted auto
Quest property ccBGSSSE034_Misc_Horse04_Pale auto
referencealias property Alias_HorseWild02_Black auto
referencealias property Alias_HorseWild03_GreyBlack auto
miscobject property Gold001 auto
referencealias property Alias_HorseName25 auto
referencealias property Alias_HorseName24 auto
referencealias property Alias_HorseName05 auto
referencealias property Alias_HorseName28 auto
referencealias property Alias_NewHorseName auto
referencealias property Alias_HorseName13 auto
referencealias property Alias_HorseName15 auto
referencealias property Alias_HorseName11 auto
referencealias property Alias_HorseWild01_Chestnut auto
objectreference property CalcelmoObjectRef auto
referencealias property Alias_HorseName30 auto
referencealias property Alias_HorseName21 auto
referencealias property Alias_HorseName06 auto
referencealias property Alias_HorseName10 auto
referencealias property Alias_HorseName04 auto
referencealias property Alias_HorseName26 auto

;-- Variables ---------------------------------------

;-- FUNCTIONs ---------------------------------------

FUNCTION Fragment_2()

	IF !self.GetStageDone(1)
		self.SetObjectiveCompleted(0, true)
		self.CompleteQuest()
	ENDIF
	Alias_HorseWild01_Chestnut.GetRef().Enable(false)
	Alias_HorseWild02_Black.GetRef().Enable(false)
	Alias_HorseWild03_GreyBlack.GetRef().Enable(false)
	Alias_HorseWild04_RedBrown.GetRef().Enable(false)
	Alias_HorseWild05_Pale.GetRef().Enable(false)
	Alias_HorseWild06_BrownSpotted.GetRef().Enable(false)
	Alias_HorseWild07_WhiteSpotted.GetRef().Enable(false)
	ccBGSSSE034_Misc_Horse01_Chestnut.Start()
	ccBGSSSE034_Misc_Horse02_Black.Start()
	ccBGSSSE034_Misc_Horse03_GreyBlack.Start()
	ccBGSSSE034_Misc_Horse04_Pale.Start()
	ccBGSSSE034_Misc_Horse05_RedBrown.Start()
	ccBGSSSE034_Misc_Horse06_WhiteSpotted.Start()
	ccBGSSSE034_Misc_Horse07_BrownSpotted.Start()
ENDFUNCTION

; Skipped compiler generated GetState

; Skipped compiler generated GoToState

FUNCTION Fragment_7()

	IF Alias_HostlerRef.GetRef() == none
		debug.trace("CCBGSSSE034: All hostlers are dead, use Calcelmo as backup", 0)
		Alias_HostlerRef.ForceRefTo(CalcelmoObjectRef)
	ENDIF
	Alias_HostlerRef.GetActorRef().AddItem(Alias_HorseMap.GetRef() as form, 1, false)
	Alias_HostlerRef.GetActorRef().AddItem(Alias_HorseNotes.GetRef() as form, 1, false)
	self.SetStage(1)
ENDFUNCTION
;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 0
Scriptname QF_ccBGSSSE034_WildHorsesQue_02000D65 Extends Quest Hidden

;BEGIN ALIAS PROPERTY HorseName14
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName14 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName13
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName13 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseWild07_WhiteSpotted
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseWild07_WhiteSpotted Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName23
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName23 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName06
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName06 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName29
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName29 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY NewHorseName
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_NewHorseName Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName22
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName22 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName24
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName24 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName16
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName16 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseWild05_Pale
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseWild05_Pale Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseMap
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseMap Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName18
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName18 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseWild02_Black
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseWild02_Black Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName17
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName17 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseWild01_Chestnut
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseWild01_Chestnut Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName15
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName15 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName01 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName28
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName28 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseWild06_BrownSpotted
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseWild06_BrownSpotted Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName20
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName20 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName03
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName03 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName09
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName09 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseNotes
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseNotes Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName02
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName02 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName19
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName19 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName08
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName08 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName10
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName10 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName27
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName27 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HostlerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HostlerRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName21
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName21 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName30
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName30 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseWild04_RedBrown
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseWild04_RedBrown Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName12
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName12 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseWild08_UnicornREF
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseWild08_UnicornREF Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName26
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName26 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName25
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName25 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName11
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName11 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseWild03_GreyBlack
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseWild03_GreyBlack Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName04
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName04 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName05
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName05 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HorseName07
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HorseName07 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_7
FUNCTION Fragment_7()
;BEGIN CODE
;WARNING: Unable to load fragment source from FUNCTION Fragment_7 in script QF_ccBGSSSE034_WildHorsesQue_02000D65
;Source NOT loaded
;END CODE
ENDFUNCTION
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
FUNCTION Fragment_2()
;BEGIN CODE
;WARNING: Unable to load fragment source from FUNCTION Fragment_2 in script QF_ccBGSSSE034_WildHorsesQue_02000D65
;Source NOT loaded
;END CODE
ENDFUNCTION
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
