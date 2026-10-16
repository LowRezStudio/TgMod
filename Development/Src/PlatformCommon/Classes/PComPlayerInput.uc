class PComPlayerInput extends PlayerInput within PlayerController
    transient
    native
    config(Input)
    hidecategories(Object,UIRoot);

const m_nMinDisplayLookSensitivity = 1.0;

const m_nMaxDisplayLookSensitivity = 100.0;

var bool c_bDirty;
var config bool c_bUseServerBindings;
var config bool c_bJumpEnabled;
var config string c_sCurrentProfile;
var int m_nKeybindConfigSet;
var float m_nMinLookSensitivity;
var float m_nMaxLookSensitivity;
var int m_RecCastMode;

native function ResetKeysToDefault();  // Export UPComPlayerInput::execResetKeysToDefault(FFrame&, void* const)

native function bool GetBindExtended(string Str, out KeyBind Bind, optional bool bExactMatch=false);  // Export UPComPlayerInput::execGetBindExtended(FFrame&, void* const)

native function KeyBind GetBindFromCommand(string Cmd, optional int nAlternate=0);  // Export UPComPlayerInput::execGetBindFromCommand(FFrame&, void* const)

native function KeyBind ExtendedStringToKeybind(string Str, string Cmd);  // Export UPComPlayerInput::execExtendedStringToKeybind(FFrame&, void* const)

native function string KeybindToExtendedString(const out KeyBind Bind);  // Export UPComPlayerInput::execKeybindToExtendedString(FFrame&, void* const)

native function string GetBind(const out Name Key);  // Export UPComPlayerInput::execGetBind(FFrame&, void* const)

native function KeyBind GetKeybindWithCurrentModifiers(const out name Key);  // Export UPComPlayerInput::execGetKeybindWithCurrentModifiers(FFrame&, void* const)

native function StoreMouseSettings();  // Export UPComPlayerInput::execStoreMouseSettings(FFrame&, void* const)

native function ReadMouseSettings();  // Export UPComPlayerInput::execReadMouseSettings(FFrame&, void* const)

simulated function SetDirty() { }

exec function SetMouseInput(bool bInvert, bool bSmooth, float fSensitivity) { }

exec function SetLookSensitivity(float fSensitivity, optional float fSensitivityY=0.0000000) { }

event float GetDisplayLookSensitivity() { }

event float GetDisplayLookSensitivityY() { }

exec function SetBindExtended(const string ExtendedBinding, string Command) { }

event SetCommandBind(string Command, int nAlternate, const string ExtendedBinding) { }

exec function UnbindKey(const out name BindName) { }

exec event UnbindCommandAll(string Command) { }

exec function UnbindCommand(string Command, optional int nAlternate=0) { }

exec function Jump() { }

defaultproperties
{
    c_bUseServerBindings=true
    m_nKeybindConfigSet=1
    m_nMinLookSensitivity=0.1500000
    m_nMaxLookSensitivity=6.5000000
}
