class UIRoot extends Object
    abstract
    native(UserInterface)
    config(Engine)
    hidecategories(Object,UIRoot);

const DEFAULT_SIZE_X = 1024;
const DEFAULT_SIZE_Y = 768;
const MAX_SUPPORTED_GAMEPADS = 24;

enum EInputPlatformType
{
    IPT_PC,                         // 0
    IPT_360,                        // 1
    IPT_PS3,                        // 2
    IPT_MAX                         // 3
};

struct native UIRangeData
{
    var(Range) float CurrentValue;
    var(Range) float MinValue;
    var(Range) float MaxValue;
    var(Range) float NudgeValue;
    var(Range) bool bIntRange;

    structdefaultproperties
    {
        CurrentValue=0.0000000
        MinValue=0.0000000
        MaxValue=0.0000000
        NudgeValue=0.0000000
        bIntRange=false
    }
};

struct native TextureCoordinates
{
    var() float U;
    var() float V;
    var() float UL;
    var() float VL;

    structdefaultproperties
    {
        U=0.0000000
        V=0.0000000
        UL=0.0000000
        VL=0.0000000
    }
};

struct native InputKeyAction
{
    var() name InputKeyName;
    var() Object.EInputEvent InputKeyState;
    var array<SeqOpOutputInputLink> TriggeredOps;
    var deprecated array<deprecated SequenceOp> ActionsToExecute;

    structdefaultproperties
    {
        InputKeyName="None"
        InputKeyState=EInputEvent.IE_Released
        TriggeredOps=none
    }
};

struct native transient InputEventParameters
{
    var init const transient int PlayerIndex;
    var init const transient int ControllerId;
    var init const transient name InputKeyName;
    var init const transient Object.EInputEvent EventType;
    var init const transient float InputDelta;
    var init const transient float DeltaTime;
    var init const transient bool bAltPressed;
    var init const transient bool bCtrlPressed;
    var init const transient bool bShiftPressed;

    structdefaultproperties
    {
        PlayerIndex=0
        ControllerId=0
        InputKeyName="None"
        EventType=EInputEvent.IE_Pressed
        InputDelta=0.0000000
        DeltaTime=0.0000000
        bAltPressed=false
        bCtrlPressed=false
        bShiftPressed=false
    }
};

struct native transient SubscribedInputEventParameters extends InputEventParameters
{
    var init const transient name InputAliasName;
};

struct native UIAxisEmulationDefinition
{
    var name AxisInputKey;
    var name AdjacentAxisInputKey;
    var bool bEmulateButtonPress;
    var name InputKeyToEmulate[2];

    structdefaultproperties
    {
        AxisInputKey="None"
        AdjacentAxisInputKey="None"
        bEmulateButtonPress=false
        InputKeyToEmulate[0]="None"
        InputKeyToEmulate[1]="None"
    }
};

struct native export RawInputKeyEventData
{
    var name InputKeyName;
    var byte ModifierKeyFlags;

    structdefaultproperties
    {
        InputKeyName="None"
        ModifierKeyFlags=56
    }
};

var config array<config string> BadCapsLocContexts;

// Export UUIRoot::execGetInputPlatformType(FFrame&, void* const)
native static final function UIRoot.EInputPlatformType GetInputPlatformType(optional LocalPlayer OwningPlayer);

// Export UUIRoot::execGetCurrentUIController(FFrame&, void* const)
native static final function UIInteraction GetCurrentUIController();

// Export UUIRoot::execGetSceneClient(FFrame&, void* const)
native static final function GameUISceneClient GetSceneClient();

static final function UIDataStore StaticResolveDataStore(name DataStoreTag, optional LocalPlayer InPlayerOwner)
{
    local UIDataStore Result;
    local DataStoreClient DSClient;

    DSClient = Class'Engine.UIInteraction'.static.GetDataStoreClient();
    // End:0x74
    if(DSClient != none)
    {
        Result = DSClient.FindDataStore(DataStoreTag, InPlayerOwner);
    }
    return Result;
    //return ReturnValue;    
}

static final function OnlineGameInterface GetOnlineGameInterface()
{
    local OnlineSubsystem OnlineSub;
    local OnlineGameInterface Result;

    OnlineSub = Class'Engine.GameEngine'.static.GetOnlineSubsystem();
    // End:0x63
    if(OnlineSub != none)
    {
        Result = OnlineSub.GameInterface;        
    }
    return Result;
    //return ReturnValue;    
}

static final function OnlinePlayerInterface GetOnlinePlayerInterface()
{
    local OnlineSubsystem OnlineSub;
    local OnlinePlayerInterface Result;

    OnlineSub = Class'Engine.GameEngine'.static.GetOnlineSubsystem();
    // End:0x63
    if(OnlineSub != none)
    {
        Result = OnlineSub.PlayerInterface;        
    }
    return Result;
    //return ReturnValue;    
}

static final function OnlinePlayerInterfaceEx GetOnlinePlayerInterfaceEx()
{
    local OnlineSubsystem OnlineSub;
    local OnlinePlayerInterfaceEx PlayerIntEx;

    OnlineSub = Class'Engine.GameEngine'.static.GetOnlineSubsystem();
    // End:0x63
    if(OnlineSub != none)
    {
        PlayerIntEx = OnlineSub.PlayerInterfaceEx;        
    }
    return PlayerIntEx;
    //return ReturnValue;    
}

static final function string SafeCaps(string StringToCap)
{
    // End:0x2B
    if(default.BadCapsLocContexts.Find(GetLanguage()) != -1)
    {
        return StringToCap;
    }
    return Caps(StringToCap);
    //return ReturnValue;    
}
