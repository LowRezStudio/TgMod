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
native function KeyBind GetBindFromCommand(string Cmd, optional int nAlternate = 0);

// Export UPComPlayerInput::execExtendedStringToKeybind(FFrame&, void* const)
native function KeyBind ExtendedStringToKeybind(string Str, string Cmd);

// Export UPComPlayerInput::execKeybindToExtendedString(FFrame&, void* const)
native function string KeybindToExtendedString(const out KeyBind Bind);

// Export UPComPlayerInput::execGetBind(FFrame&, void* const)
native function string GetBind(const out name Key, const optional out KeyBind ModifierKeyBind);

// Export UPComPlayerInput::execGetKeybindWithCurrentModifiers(FFrame&, void* const)
native function KeyBind GetKeybindWithCurrentModifiers(const out name Key);

// Export UPComPlayerInput::execStoreMouseSettings(FFrame&, void* const)
native function StoreMouseSettings();

// Export UPComPlayerInput::execReadMouseSettings(FFrame&, void* const)
native function ReadMouseSettings();

simulated function SetDirty()
{
    c_bDirty = true;
    //return;    
}

exec function SetMouseInput(bool bInvert, bool bSmooth, float fSensitivity)
{
    bInvertMouse = bInvert;
    bEnableMouseSmoothing = bSmooth;
    MouseSensitivity = fSensitivity;
    // End:0x61
    if(MouseSensitivity <= float(0))
    {
        MouseSensitivity = default.MouseSensitivity;
    }
    StoreMouseSettings();
    //return;    
}

exec function SetLookSensitivity(float fSensitivity, optional float fSensitivityY = 0.0000000)
{
    local float LookSensitivityIncrement;

    // End:0x2D
    if(fSensitivityY <= float(0))
    {
        fSensitivityY = fSensitivity;
    }
    // End:0x4D
    if(fSensitivityY <= float(0))
    {
        fSensitivityY = 1.0000000;
    }
    LookSensitivityIncrement = (m_nMaxLookSensitivity - m_nMinLookSensitivity) / 100.0000000;
    m_fLookSensitivity = (fSensitivity * LookSensitivityIncrement) + m_nMinLookSensitivity;
    m_fLookSensitivityY = (fSensitivityY * LookSensitivityIncrement) + m_nMinLookSensitivity;
    StoreMouseSettings();
    //return;    
}

event float GetDisplayLookSensitivity()
{
    local float LookSensitivityIncrement;

    LookSensitivityIncrement = (m_nMaxLookSensitivity - m_nMinLookSensitivity) / 100.0000000;
    return (m_fLookSensitivity - m_nMinLookSensitivity) / LookSensitivityIncrement;
    //return ReturnValue;    
}

event float GetDisplayLookSensitivityY()
{
    local float LookSensitivityIncrement;

    LookSensitivityIncrement = (m_nMaxLookSensitivity - m_nMinLookSensitivity) / 100.0000000;
    return (m_fLookSensitivityY - m_nMinLookSensitivity) / LookSensitivityIncrement;
    //return ReturnValue;    
}

exec function SetBindExtended(const string ExtendedBinding, string Command)
{
    local KeyBind oldBinding, newBinding;
    local bool bOldBinding;

    bOldBinding = GetBindExtended(ExtendedBinding, oldBinding, true);
    // End:0x63
    if(bOldBinding && oldBinding.Command == Command)
    {
        return;
    }
    // End:0x86
    if(bOldBinding)
    {
        Bindings.RemoveItem(oldBinding);
    }
    newBinding = ExtendedStringToKeybind(ExtendedBinding, Command);
    Bindings.AddItem(newBinding);
    //return;    
}

event SetCommandBind(string Command, int nAlternate, const string ExtendedBinding)
{
    local KeyBind oldCommandBinding, oldKeyBinding, newBinding;
    local int nOldIndex;
    local bool bKeyWasPreviouslyBound;

    oldCommandBinding = GetBindFromCommand(Command, nAlternate);
    bKeyWasPreviouslyBound = GetBindExtended(ExtendedBinding, oldKeyBinding, true);
    newBinding = ExtendedStringToKeybind(ExtendedBinding, Command);
    // End:0x97
    if(bKeyWasPreviouslyBound)
    {
        Bindings.RemoveItem(oldKeyBinding);
    }
    nOldIndex = Bindings.RemoveItem(oldCommandBinding);
    newBinding = ExtendedStringToKeybind(ExtendedBinding, Command);
    // End:0x112
    if(nOldIndex != -1)
    {
        Bindings.InsertItem(nOldIndex, newBinding);        
    }
    else
    {
        // End:0x13A
        if(nAlternate == 0)
        {
            Bindings.AddItem(newBinding);            
        }
        else
        {
            Bindings.InsertItem(0, newBinding);
        }
    }
    //return;    
}

exec function UnbindKey(const out name BindName)
{
    SetBind(BindName, "");
    //return;    
}

exec event UnbindCommandAll(string Command)
{
    local int BindIndex;
    local array<string> SplitCommand;
    local string AxisName;

    // End:0x4F
    if((Left(Command, 1) == "\"") && Right(Command, 1) == "\"")
    {
        Command = Mid(Command, 1, Len(Command) - 2);
    }
    // End:0x1BE
    if(InStr(Command, "Axis ") == 0)
    {
        SplitCommand = SplitString(Command, " ", true);
        // End:0xB1
        if(SplitCommand.Length >= 2)
        {
            AxisName = SplitCommand[1];
        }
        BindIndex = Bindings.Length - 1;
        J0xC8:

        // End:0x1BB [Loop If]
        if(BindIndex >= 0)
        {
            // End:0x123
            if(Bindings[BindIndex].Command == Command)
            {
                Bindings.Remove(BindIndex, 1);                
            }
            else
            {
                // End:0x1AD
                if(Left(string(Bindings[BindIndex].Name), 4) != "GBA_")
                {
                    // End:0x1AD
                    if(InStr(Bindings[BindIndex].Command, AxisName) != -1)
                    {
                        Bindings.Remove(BindIndex, 1);
                    }
                }
            }
            BindIndex--;
            // [Loop Continue]
            goto J0xC8;
        }        
    }
    else
    {
        BindIndex = Bindings.Length - 1;
        J0x1D5:

        // End:0x23B [Loop If]
        if(BindIndex >= 0)
        {
            // End:0x22D
            if(Bindings[BindIndex].Command == Command)
            {
                Bindings.Remove(BindIndex, 1);
            }
            BindIndex--;
            // [Loop Continue]
            goto J0x1D5;
        }
    }
    //return;    
}

exec function UnbindCommand(string Command, optional int nAlternate = 0)
{
    local KeyBind Binding;

    Binding = GetBindFromCommand(Command, nAlternate);
    UnbindKey(Binding.Name);
    //return;    
}

exec function Jump()
{
    // End:0x17
    if(c_bJumpEnabled)
    {
        super.Jump();
    }
    //return;    
}

defaultproperties
{
    c_bUseServerBindings=true
    m_nKeybindConfigSet=1
    m_nMinLookSensitivity=0.1500000
    m_nMaxLookSensitivity=6.5000000
}