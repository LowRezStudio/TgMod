class Input extends Interaction
    transient
    native(UserInterface)
    config(Input)
    hidecategories(Object,UIRoot);

struct native KeyBind
{
    var config name Name;
    var init config string Command;
    var config bool Control;
    var config bool Shift;
    var config bool Alt;
    var config bool bIgnoreCtrl;
    var config bool bIgnoreShift;
    var config bool bIgnoreAlt;
    var config bool LeftShoulder;
    var config bool LeftTrigger;
    var config bool RightShoulder;
    var config bool RightTrigger;
    var config bool LeftThumbStick;
    var config bool RightThumbStick;
    var config bool bIgnorePadModifier;

    structdefaultproperties
    {
        Name="None"
        Command=""
        Control=false
        Shift=false
        Alt=false
        bIgnoreCtrl=false
        bIgnoreShift=false
        bIgnoreAlt=false
        LeftShoulder=false
        LeftTrigger=false
        RightShoulder=false
        RightTrigger=false
        LeftThumbStick=false
        RightThumbStick=false
        bIgnorePadModifier=false
    }
};

struct native TouchTracker
{
    var int Handle;
    var int TouchpadIndex;
    var Vector2D Location;
    var Object.EInputEvent EventType;
    var bool bTrapInput;

    structdefaultproperties
    {
        Handle=0
        TouchpadIndex=0
        Location=(X=0.0000000,Y=0.0000000)
        EventType=EInputEvent.IE_Pressed
        bTrapInput=false
    }
};

var config array<config KeyBind> Bindings;
var protectedwrite array<KeyBind> PressedKeys;
var const int CurrentControllerId;
var const Object.EInputEvent CurrentEvent;
var const float CurrentDelta;
var const float CurrentDeltaTime;
var native const map{VOID,VOID} NameToPtr;
var init native const array<init Pointer> AxisArray;
var const array<SeqEvent_Input> CachedInputEvents;
var const array<SeqEvent_AnalogInput> CachedAnalogInputEvents;
var const array<SeqEvent_TouchInput> CachedTouchInputEvents;
var const array<TouchTracker> CurrentTouches;

// Export UInput::execResetInput(FFrame&, void* const)
native function ResetInput();

// Export UInput::execGetBind(FFrame&, void* const)
native function string GetBind(const out name Key, const optional out KeyBind ModifierKeyBind);

// Export UInput::execGetKeybindWithCurrentModifiers(FFrame&, void* const)
native function KeyBind GetKeybindWithCurrentModifiers(const out name Key);

exec function SetBind(const out name BindName, string Command)
{
    local KeyBind NewBind;
    local int BindIndex;

    // End:0x4F
    if((Left(Command, 1) == "\"") && Right(Command, 1) == "\"")
    {
        Command = Mid(Command, 1, Len(Command) - 2);
    }
    BindIndex = Bindings.Length - 1;
    J0x66:

    // End:0xEC [Loop If]
    if(BindIndex >= 0)
    {
        // End:0xDE
        if(Bindings[BindIndex].Name == BindName)
        {
            Bindings[BindIndex].Command = Command;
            SaveConfig();
            return;
        }
        BindIndex--;
        // [Loop Continue]
        goto J0x66;
    }
    NewBind.Name = BindName;
    NewBind.Command = Command;
    Bindings[Bindings.Length] = NewBind;
    SaveConfig();
    //return;    
}
