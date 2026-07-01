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

// Export UPComPlayerInput::execResetKeysToDefault(FFrame&, void* const)
native function ResetKeysToDefault();

// Export UPComPlayerInput::execGetBindExtended(FFrame&, void* const)
native function bool GetBindExtended(string Str, out KeyBind Bind, optional bool bExactMatch = false);

// Export UPComPlayerInput::execGetBindFromCommand(FFrame&, void* const)
native function KeyBind GetBindFromCommand(string Cmd, bool bGamepad, optional int nAlternate = 0);

// Export UPComPlayerInput::execExtendedStringToKeybind(FFrame&, void* const)
native function KeyBind ExtendedStringToKeybind(string Str, string Cmd);

// Export UPComPlayerInput::execKeybindToExtendedString(FFrame&, void* const)
native function string KeybindToExtendedString(const out KeyBind Bind);

// xiloe: UDK is bitching again, I don't think we need this anyways
// Export UPComPlayerInput::execGetBind(FFrame&, void* const)
//native function string GetBind(const out name Key, const optional out KeyBind ModifierKeyBind);

// Export UPComPlayerInput::execGetKeybindWithCurrentModifiers(FFrame&, void* const)
native function KeyBind GetKeybindWithCurrentModifiers(const out name Key);

// Export UPComPlayerInput::execStoreMouseSettings(FFrame&, void* const)
native function StoreMouseSettings();

// Export UPComPlayerInput::execReadMouseSettings(FFrame&, void* const)
native function ReadMouseSettings();

simulated function SetDirty()
{
    //return;    
}

exec function SetMouseInput(bool bInvert, bool bSmooth, float fSensitivity)
{
    //return;    
}

exec function SetLookSensitivity(float fSensitivity, optional float fSensitivityY = 0.0000000)
{
    //return;    
}

exec function SetAimAcceleration(float fLookAccel)
{
    //return;    
}

event float GetDisplayLookSensitivity()
{
    //return ReturnValue;    
}

event float GetDisplayLookSensitivityY()
{
    //return ReturnValue;    
}

exec function SetBindExtended(const string ExtendedBinding, string Command)
{   
    //return;    
}

event SetCommandBind(string Command, bool bGamepad, int nAlternate, const string ExtendedBinding)
{
    //return;    
}

exec function UnbindKey(const out name BindName)
{
    //return;    
}

exec event UnbindCommandAll(string Command)
{
    //return;    
}

exec function UnbindCommand(string Command, bool bGamepad, optional int nAlternate = 0)
{
    //return;    
}

exec function Jump()
{
    //return;    
}

defaultproperties
{
    //c_bUseServerBindings=true
    m_nKeybindConfigSet=1
    m_nMinLookSensitivity=0.1500000
    m_nMaxLookSensitivity=6.5000000
}