ScriptName PapyrusIniManipulator

String Function GetVersion() Global Native

Bool Function IniDataExists(Int iLevel, String sPath, String sSection = "", String sKey = "") Global Native
Bool Function ClearIniData(Int iLevel, String sPath, String sSection = "", String sKey = "") Global Native
Bool Function DestroyIniData(Int iLevel, String sPath, String sSection = "", String sKey = "") Global Native
String[] Function GetIniData(Int iLevel, String sPath, String sSection = "", String sKey = "") Global Native

Bool Function PullBoolFromIni(String sPath, String sSection, String sKey, Bool bDefault) Global Native
Int Function PullIntFromIni(String sPath, String sSection, String sKey, Int iDefault) Global Native
Float Function PullFloatFromIni(String sPath, String sSection, String sKey, Float fDefault) Global Native
String Function PullStringFromIni(String sPath, String sSection, String sKey, String sDefault) Global Native

Bool Function PushBoolToIni(String sPath, String sSection = "", String sKey = "", Bool bValue, Bool bForce = False) Global Native
Bool Function PushIntToIni(String sPath, String sSection = "", String sKey = "", Int iValue, Bool bForce = False) Global Native
Bool Function PushFloatToIni(String sPath, String sSection = "", String sKey = "", Float fValue, Bool bForce = False) Global Native
Bool Function PushStringToIni(String sPath, String sSection = "", String sKey = "", String sValue, Bool bForce = False) Global Native
