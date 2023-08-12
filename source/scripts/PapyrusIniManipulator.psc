ScriptName PapyrusIniManipulator

String FUNCTION GetVersion() Global Native

Bool FUNCTION IniDataExists(Int iLevel, String sPath, String sSection = "", String sKey = "") Global Native
Bool FUNCTION ClearIniData(Int iLevel, String sPath, String sSection = "", String sKey = "") Global Native
Bool FUNCTION DestroyIniData(Int iLevel, String sPath, String sSection = "", String sKey = "") Global Native
String[] FUNCTION GetIniData(Int iLevel, String sPath, String sSection = "", String sKey = "") Global Native

Bool FUNCTION PullBoolFromIni(String sPath, String sSection, String sKey, Bool bDefault) Global Native
Int FUNCTION PullIntFromIni(String sPath, String sSection, String sKey, Int iDefault) Global Native
Float FUNCTION PullFloatFromIni(String sPath, String sSection, String sKey, Float fDefault) Global Native
String FUNCTION PullStringFromIni(String sPath, String sSection, String sKey, String sDefault) Global Native

Bool FUNCTION PushBoolToIni(String sPath, String sSection = "", String sKey = "", Bool bValue, Bool bForce = False) Global Native
Bool FUNCTION PushIntToIni(String sPath, String sSection = "", String sKey = "", Int iValue, Bool bForce = False) Global Native
Bool FUNCTION PushFloatToIni(String sPath, String sSection = "", String sKey = "", Float fValue, Bool bForce = False) Global Native
Bool FUNCTION PushStringToIni(String sPath, String sSection = "", String sKey = "", String sValue, Bool bForce = False) Global Native
