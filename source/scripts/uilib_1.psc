;/ Decompiled by Champollion V1.0.1
Source   : UILIB_1.psc
ModIFied : 2014-08-20 14:16:49
Compiled : 2014-08-20 14:16:51
User     : User
Computer : USER-PC
/;
scriptName UILIB_1 extends Form
{SkyUILib API - Version 1}

;-- Properties --------------------------------------

;-- Variables ---------------------------------------
Int iDefaultIndex
Int iStartIndex
Int iInput
String[] sOptions
Bool bMenuOpen
String sInput
String sTitle
String sInitialText

;-- FUNCTIONs ---------------------------------------

FUNCTION TextInputMenu_Open(Form akClient) global

	akClient.RegisterForModEVENT("UILIB_1_textInputOpen", "OnTextInputOpen")
	akClient.RegisterForModEVENT("UILIB_1_textInputClose", "OnTextInputClose")
	ui.OpenCustomMenu("uilib/uilib_1_textinputmenu", 0)
ENDFUNCTION

Bool FUNCTION NotIFicationMenu_PrepareArea() global

	Int iVersion = ui.GetInt("HUD Menu", "_global.uilib_1.NotIFicationArea.UILIB_VERSION")
	IF iVersion == 0
		Int iHandle = uicallback.Create("HUD Menu", "_root.HUDMovieBaseInstance.createEmptyMovieClip")
		IF !iHandle
			return false
		ENDIF
		uicallback.PushString(iHandle, "uilib_1_notIFicationAreaContainer")
		uicallback.PushInt(iHandle, -16380)
		IF !uicallback.Send(iHandle)
			return false
		ENDIF
		ui.InvokeString("HUD Menu", "_root.HUDMovieBaseInstance.uilib_1_notIFicationAreaContainer.loadMovie", "uilib/uilib_1_notIFicationarea.swf")
		utility.Wait(0.500000)
		iVersion = ui.GetInt("HUD Menu", "_global.uilib_1.NotIFicationArea.UILIB_VERSION")
		IF iVersion == 0
			ui.InvokeString("HUD Menu", "_root.HUDMovieBaseInstance.uilib_1_notIFicationAreaContainer.loadMovie", "exported/uilib/uilib_1_notIFicationarea.swf")
			utility.Wait(0.500000)
			iVersion = ui.GetInt("HUD Menu", "_global.uilib_1.NotIFicationArea.UILIB_VERSION")
			IF iVersion == 0
				debug.Trace("===== UILib: NotIFication injection failed =====", 0)
				return false
			ENDIF
			ui.InvokeString("HUD Menu", "_root.HUDMovieBaseInstance.uilib_1_notIFicationAreaContainer.SetRootPath", "exported/")
		ENDIF
	ENDIF
	return true
ENDFUNCTION

FUNCTION ListMenu_Open(Form akClient) global

	akClient.RegisterForModEVENT("UILIB_1_listMenuOpen", "OnListMenuOpen")
	akClient.RegisterForModEVENT("UILIB_1_listMenuClose", "OnListMenuClose")
	ui.OpenCustomMenu("uilib/uilib_1_listmenu", 0)
ENDFUNCTION

FUNCTION ListMenu_Release(Form akClient) global

	akClient.UnregisterForModEVENT("UILIB_1_listMenuOpen")
	akClient.UnregisterForModEVENT("UILIB_1_listMenuClose")
ENDFUNCTION

FUNCTION ListMenu_SetData(String asTitle, String[] asOptions, Int aiStartIndex, Int aiDefaultIndex) global

	ui.InvokeNumber("CustomMenu", "_root.listDialog.setPlatform", (game.UsingGamepad() as Int) as Float)
	ui.InvokeStringA("CustomMenu", "_root.listDialog.initListData", asOptions)
	Int iHandle = uicallback.Create("CustomMenu", "_root.listDialog.initListParams")
	IF iHandle
		uicallback.PushString(iHandle, asTitle)
		uicallback.PushInt(iHandle, aiStartIndex)
		uicallback.PushInt(iHandle, aiDefaultIndex)
		uicallback.Send(iHandle)
	ENDIF
ENDFUNCTION

FUNCTION TextInputMenu_SetData(String asTitle, String asInitialText) global

	ui.InvokeNumber("CustomMenu", "_root.textInputDialog.setPlatform", (game.UsingGamepad() as Int) as Float)
	String[] sData = new String[2]
	sData[0] = asTitle
	sData[1] = asInitialText
	ui.InvokeStringA("CustomMenu", "_root.textInputDialog.initData", sData)
ENDFUNCTION

FUNCTION TextInputMenu_Release(Form akClient) global

	akClient.UnregisterForModEVENT("UILIB_1_textInputOpen")
	akClient.UnregisterForModEVENT("UILIB_1_textInputClose")
ENDFUNCTION

FUNCTION OnTextInputClose(String AsEventName, String asInput, Float afCancelled, Form akSender)

	IF AsEventName == "UILIB_1_textInputClose"
		IF afCancelled as Bool
			sInput = ""
		else
			sInput = asInput
		ENDIF
		bMenuOpen = false
	ENDIF
ENDFUNCTION

FUNCTION OnListMenuClose(String AsEventName, String asStringArg, Float afInput, Form akSender)

	IF AsEventName == "UILIB_1_listMenuClose"
		iInput = afInput as Int
		bMenuOpen = false
	ENDIF
ENDFUNCTION

FUNCTION ShowNotIFicationIcon(String asMessage, String asIconPath, Int aiIconFrame, String asColor)

	IF !UILIB_1.NotIFicationMenu_PrepareArea()
		return 
	ENDIF
	Int iHandle = uicallback.Create("HUD Menu", "_root.HUDMovieBaseInstance.uilib_1_notIFicationAreaContainer.notIFicationArea.ShowIconMessage")
	IF iHandle
		uicallback.PushString(iHandle, asMessage)
		uicallback.PushString(iHandle, asColor)
		uicallback.PushString(iHandle, asIconPath)
		uicallback.PushInt(iHandle, aiIconFrame)
		uicallback.Send(iHandle)
	ENDIF
ENDFUNCTION

; Skipped compiler generated GoToState

; Skipped compiler generated GetState

Int FUNCTION ShowList(String asTitle, String[] asOptions, Int aiStartIndex, Int aiDefaultIndex)

	IF bMenuOpen
		return -1
	ENDIF
	bMenuOpen = true
	iInput = -1
	sTitle = asTitle
	sOptions = asOptions
	iStartIndex = aiStartIndex
	iDefaultIndex = aiDefaultIndex
	UILIB_1.ListMenu_Open(self as Form)
	while bMenuOpen
		utility.WaitMenuMode(0.100000)
	endWhile
	UILIB_1.ListMenu_Release(self as Form)
	return iInput
ENDFUNCTION

FUNCTION ShowNotIFication(String asMessage, String asColor)

	IF !UILIB_1.NotIFicationMenu_PrepareArea()
		return 
	ENDIF
	Int iHandle = uicallback.Create("HUD Menu", "_root.HUDMovieBaseInstance.uilib_1_notIFicationAreaContainer.notIFicationArea.ShowMessage")
	IF iHandle
		uicallback.PushString(iHandle, asMessage)
		uicallback.PushString(iHandle, asColor)
		uicallback.Send(iHandle)
	ENDIF
ENDFUNCTION

String FUNCTION ShowTextInput(String asTitle, String asInitialText)

	IF bMenuOpen
		return ""
	ENDIF
	bMenuOpen = true
	sInput = ""
	sTitle = asTitle
	sInitialText = asInitialText
	UILIB_1.TextInputMenu_Open(self as Form)
	while bMenuOpen
		utility.WaitMenuMode(0.100000)
	endWhile
	UILIB_1.TextInputMenu_Release(self as Form)
	return sInput
ENDFUNCTION

FUNCTION OnTextInputOpen(String AsEventName, String asStringArg, Float afNumArg, Form akSender)

	IF AsEventName == "UILIB_1_textInputOpen"
		UILIB_1.TextInputMenu_SetData(sTitle, sInitialText)
	ENDIF
ENDFUNCTION

FUNCTION OnListMenuOpen(String AsEventName, String asStringArg, Float afNumArg, Form akSender)

	IF AsEventName == "UILIB_1_listMenuOpen"
		UILIB_1.ListMenu_SetData(sTitle, sOptions, iStartIndex, iDefaultIndex)
	ENDIF
ENDFUNCTION
