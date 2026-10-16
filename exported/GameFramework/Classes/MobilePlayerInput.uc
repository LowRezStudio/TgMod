class MobilePlayerInput extends PlayerInput within GamePlayerController
    transient
    native
    config(Game)
    hidecategories(Object,UIRoot);

const NumTouchDataEntries = 5;

enum EUIOrientation
{
    UI_Unknown,                     // 0
    UI_Portait,                     // 1
    UI_PortaitUpsideDown,           // 2
    UI_LandscapeRight,              // 3
    UI_LandscapeLeft,               // 4
    UI_MAX                          // 5
};

struct native TouchDataEvent
{
    var Interaction.ETouchType EventType;
    var byte TouchpadIndex;
    var Vector2D Location;
    var Double DeviceTime;

    structdefaultproperties
    {
        EventType=ETouchType.Touch_Began
        TouchpadIndex=0
        Location=(X=0.0000000,Y=0.0000000)
        DeviceTime=()
    }
};

struct native TouchData
{
    var int Handle;
    var byte TouchpadIndex;
    var Vector2D Location;
    var float TotalMoveDistance;
    var Double InitialDeviceTime;
    var float TouchDuration;
    var Double MoveEventDeviceTime;
    var float MoveDeltaTime;
    var bool bInUse;
    var MobileInputZone Zone;
    var Interaction.ETouchType State;
    var array<TouchDataEvent> Events;
    var float LastActiveTime;

    structdefaultproperties
    {
        Handle=0
        TouchpadIndex=0
        Location=(X=0.0000000,Y=0.0000000)
        TotalMoveDistance=0.0000000
        InitialDeviceTime=()
        TouchDuration=0.0000000
        MoveEventDeviceTime=()
        MoveDeltaTime=0.0000000
        bInUse=false
        Zone=none
        State=ETouchType.Touch_Began
        Events=none
        LastActiveTime=0.0000000
    }
};

struct native MobileInputGroup
{
    var string GroupName;
    var editinline array<editinline MobileInputZone> AssociatedZones;

    structdefaultproperties
    {
        GroupName=""
        AssociatedZones=none
    }
};

struct native MobileInputZoneClassMap
{
    var string Name;
    var Class<MobileInputZone> ClassType;

    structdefaultproperties
    {
        Name=""
        ClassType=none
    }
};

var(Input) TouchData Touches[5];
var MobileMenuObject InteractiveObject;
var Double InteractiveObjectLastTime;
var(Input) editinline array<editinline MobileInputGroup> MobileInputGroups;
var(Input) int CurrentMobileGroup;
var(Input) editinline array<editinline MobileInputZone> MobileInputZones;
var array<MobileInputZoneClassMap> MobileInputZoneClasses;
var(Input) float MobilePitch;
var(Input) float MobilePitchCenter;
var(Input) float MobilePitchMultiplier;
var(Input) float MobileYaw;
var(Input) float MobileYawCenter;
var(Input) float MobileYawMultiplier;
var(Input) config float MobilePitchDeadzoneSize;
var(Input) config float MobileYawDeadzoneSize;
var(Input) config float MobileDoubleTapTime;
var(Input) config float MobileMinHoldForTap;
var(Input) config float MobileTapRepeatTime;
var(Input) bool bAllowTouchesInCinematic;
var(Input) bool bDisableTouchInput;
var(Input) config bool bAbsoluteTouchLocations;
var(Input) config bool bCollapseTouchInput;
var(Debug) bool bFakeMobileTouches;
var(Debug) bool bDisableSceneRender;
var(Input) config float ZoneTimeout;
var(menus) array<MobileMenuScene> MobileMenuStack;
var(Debug) string NativeDebugString;
var(Current) float MobileInactiveTime;
var(Current) array<SeqEvent_MobileBase> MobileSeqEventHandlers;
var(Current) array<SeqEvent_MobileRawInput> MobileRawInputSeqEventHandlers;
var Vector2D MobileViewportOffset;
var Vector2D MobileViewportSize;
//var delegate<OnTouchNotHandledInMenu> __OnTouchNotHandledInMenu__Delegate;
//var delegate<OnPreviewTouch> __OnPreviewTouch__Delegate;
//var delegate<OnInputTouch> __OnInputTouch__Delegate;

// Export UMobilePlayerInput::execProcessMobileInput(FFrame&, void* const)
native function ProcessMobileInput(float DeltaTime);

// Export UMobilePlayerInput::execCancelMobileInput(FFrame&, void* const)
native function CancelMobileInput();

event PlayerInput(float DeltaTime)
{
    ProcessMobileInput(DeltaTime);
    super.PlayerInput(DeltaTime);
    //return;    
}

delegate OnTouchNotHandledInMenu()
{
    //return;    
}

delegate bool OnPreviewTouch(float X, float Y, int TouchpadIndex)
{
    //return ReturnValue;    
}

delegate OnInputTouch(int Handle, Interaction.ETouchType Type, Vector2D TouchLocation, float DeviceTimestamp, int TouchpadIndex)
{
    //return;    
}

// Export UMobilePlayerInput::execNativeInitializeInputSystem(FFrame&, void* const)
native function NativeInitializeInputSystem();

// Export UMobilePlayerInput::execNativeInitializeInputZones(FFrame&, void* const)
native function NativeInitializeInputZones(bool bIsFirstInitialize);

// Export UMobilePlayerInput::execConditionalUpdateInputZones(FFrame&, void* const)
native function ConditionalUpdateInputZones(int NewViewportX, int NewViewportY, int NewViewportSizeX, int NewViewportSizeY);

// Export UMobilePlayerInput::execSendInputKey(FFrame&, void* const)
native function SendInputKey(name Key, Object.EInputEvent Event, float AmountDepressed);

// Export UMobilePlayerInput::execSendInputAxis(FFrame&, void* const)
native function SendInputAxis(name Key, float Delta, float DeltaTime);

// Export UMobilePlayerInput::execProcessWorldTouch(FFrame&, void* const)
native function bool ProcessWorldTouch(MobileInputZone Zone, Interaction.ETouchType EventType, Vector2D TouchLocation);

function InitInputSystem()
{
    super.InitInputSystem();
    InitTouchSystem();
    //return;    
}

function ClientInitInputSystem()
{
    super.ClientInitInputSystem();
    InitTouchSystem();
    //return;    
}

function InitTouchSystem()
{
    NativeInitializeInputSystem();
    // End:0x5C
    if(bFakeMobileTouches || Outer.WorldInfo.IsConsoleBuild(3))
    {
        InitializeInputZones();
    }
    //return;    
}

function InitializeInputZones()
{
    local int I, J;
    local MobileInputZone Zone;
    local Class<FrameworkGame> FrameworkGameClass;

    // End:0x12
    if(MobileInputGroups.Length > 0)
    {
        return;
    }
    FrameworkGameClass = Class<FrameworkGame>(Outer.WorldInfo.GRI.GameClass);
    // End:0x2AD
    if(FrameworkGameClass != none)
    {
        MobileInputGroups.Length = FrameworkGameClass.default.RequiredMobileInputConfigs.Length;
        I = 0;
        J0xB1:

        // End:0x23D [Loop If]
        if(I < FrameworkGameClass.default.RequiredMobileInputConfigs.Length)
        {
            MobileInputGroups[I].GroupName = FrameworkGameClass.default.RequiredMobileInputConfigs[I].GroupName;
            J = 0;
            J0x14B:

            // End:0x22F [Loop If]
            if(J < FrameworkGameClass.default.RequiredMobileInputConfigs[I].RequireZoneNames.Length)
            {
                Zone = FindorAddZone(FrameworkGameClass.default.RequiredMobileInputConfigs[I].RequireZoneNames[J]);
                MobileInputGroups[I].AssociatedZones.AddItem(Zone);
                J++;
                // [Loop Continue]
                goto J0x14B;
            }
            I++;
            // [Loop Continue]
            goto J0xB1;
        }
        LocalPlayer(Outer.Player).ViewportClient.GetViewportSize(MobileViewportSize);
        NativeInitializeInputZones(true);
        RefreshKismetLinks();
    }
    //return;    
}

function SwapZoneOwners()
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x5B [Loop If]
    if(I < MobileInputZones.Length)
    {
        MobileInputZones[I].InputOwner = self;
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

event RefreshKismetLinks()
{
    local array<SequenceObject> MobileInputSeqEvents;
    local Sequence GameSeq;
    local int I;

    GameSeq = Outer.WorldInfo.GetGameSequence();
    // End:0x183
    if(GameSeq != none)
    {
        GameSeq.FindSeqObjectsByClass(Class'GameFramework.SeqEvent_MobileBase', true, MobileInputSeqEvents);
        I = 0;
        J0x8A:

        // End:0xE2 [Loop If]
        if(I < MobileInputSeqEvents.Length)
        {
            SeqEvent_MobileBase(MobileInputSeqEvents[I]).RegisterEvent();
            I++;
            // [Loop Continue]
            goto J0x8A;
        }
        MobileInputSeqEvents.Length = 0;
        GameSeq.FindSeqObjectsByClass(Class'GameFramework.SeqEvent_MobileRawInput', true, MobileInputSeqEvents);
        I = 0;
        J0x12B:

        // End:0x183 [Loop If]
        if(I < MobileInputSeqEvents.Length)
        {
            SeqEvent_MobileRawInput(MobileInputSeqEvents[I]).RegisterEvent();
            I++;
            // [Loop Continue]
            goto J0x12B;
        }
    }
    //return;    
}

function AddKismetEventHandler(SeqEvent_MobileBase NewHandler)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x54 [Loop If]
    if(I < MobileSeqEventHandlers.Length)
    {
        // End:0x46
        if(MobileSeqEventHandlers[I] == NewHandler)
        {
            return;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    I = 0;
    J0x5F:

    // End:0xBD [Loop If]
    if(I < MobileSeqEventHandlers.Length)
    {
        // End:0xAF
        if(MobileSeqEventHandlers[I] == none)
        {
            MobileSeqEventHandlers[I] = NewHandler;
            return;
        }
        I++;
        // [Loop Continue]
        goto J0x5F;
    }
    MobileSeqEventHandlers.AddItem(NewHandler);
    //return;    
}

function AddKismetRawInputEventHandler(SeqEvent_MobileRawInput NewHandler)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x54 [Loop If]
    if(I < MobileRawInputSeqEventHandlers.Length)
    {
        // End:0x46
        if(MobileRawInputSeqEventHandlers[I] == NewHandler)
        {
            return;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    I = 0;
    J0x5F:

    // End:0xBD [Loop If]
    if(I < MobileRawInputSeqEventHandlers.Length)
    {
        // End:0xAF
        if(MobileRawInputSeqEventHandlers[I] == none)
        {
            MobileRawInputSeqEventHandlers[I] = NewHandler;
            return;
        }
        I++;
        // [Loop Continue]
        goto J0x5F;
    }
    MobileRawInputSeqEventHandlers.AddItem(NewHandler);
    //return;    
}

function MobileInputZone FindZone(string ZoneName)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x7D [Loop If]
    if(I < MobileInputZones.Length)
    {
        // End:0x6F
        if(MobileInputZones[I].Name == name(ZoneName))
        {
            return MobileInputZones[I];
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    return none;
    //return ReturnValue;    
}

function MobileInputZone FindorAddZone(string ZoneName)
{
    local MobileInputZone Zone;
    local Class<MobileInputZone> ClassType;
    local int ClassIndex;

    Zone = FindZone(ZoneName);
    // End:0x12D
    if(Zone == none)
    {
        ClassType = Class'GameFramework.MobileInputZone';
        ClassIndex = 0;
        J0x4A:

        // End:0xD7 [Loop If]
        if(ClassIndex < MobileInputZoneClasses.Length)
        {
            // End:0xC9
            if(ZoneName == MobileInputZoneClasses[ClassIndex].Name)
            {
                ClassType = MobileInputZoneClasses[ClassIndex].ClassType;
                // [Explicit Break]
                goto J0xD7;
            }
            ClassIndex++;
            // [Loop Continue]
            goto J0x4A;
        }
        J0xD7:

        Zone = new (none, ZoneName) ClassType;
        Zone.InputOwner = self;
        MobileInputZones.AddItem(Zone);
    }
    return Zone;
    //return ReturnValue;    
}

function bool HasZones()
{
    return (MobileInputGroups.Length > 0) && CurrentMobileGroup < MobileInputGroups.Length;
    //return ReturnValue;    
}

function array<MobileInputZone> GetCurrentZones()
{
    return MobileInputGroups[CurrentMobileGroup].AssociatedZones;
    //return ReturnValue;    
}

exec function ActivateInputGroup(string GroupName)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x7A [Loop If]
    if(I < MobileInputGroups.Length)
    {
        // End:0x6C
        if(MobileInputGroups[I].GroupName == GroupName)
        {
            CurrentMobileGroup = I;
            return;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

exec function SetMobileInputConfig(string GroupName)
{
    local int NewConfig;

    NewConfig = 0;
    J0x0B:

    // End:0x68 [Loop If]
    if(NewConfig < MobileInputGroups.Length)
    {
        // End:0x5A
        if(MobileInputGroups[NewConfig].GroupName ~= GroupName)
        {
            // [Explicit Break]
            goto J0x68;
        }
        NewConfig++;
        // [Loop Continue]
        goto J0x0B;
    }
    J0x68:

    // End:0x96
    if(NewConfig < MobileInputGroups.Length)
    {
        CurrentMobileGroup = NewConfig;        
    }
    //return;    
}

event MobileMenuScene OpenMenuScene(Class<MobileMenuScene> SceneClass, optional string Mode)
{
    local MobileMenuScene Scene;
    local Vector2D ViewportSize;

    // End:0x162
    if(SceneClass != none)
    {
        Scene = new (Outer) SceneClass;
        // End:0x162
        if(Scene != none)
        {
            LocalPlayer(Outer.Player).ViewportClient.GetViewportSize(ViewportSize);
            Scene.InitMenuScene(self, int(ViewportSize.X), int(ViewportSize.Y), true);
            MobileMenuStack.InsertItem(0, Scene);
            Scene.Opened(Mode);
            Scene.MadeTopMenu();
            return Scene;            
        }
    }
    return none;
    //return ReturnValue;    
}

event CloseMenuScene(MobileMenuScene SceneToClose)
{
    local int I, Idx;
    local bool bClosedTopMenu;

    // End:0x131
    if(SceneToClose.Closing())
    {
        Idx = -1;
        I = 0;
        J0x3C:

        // End:0x99 [Loop If]
        if(I < MobileMenuStack.Length)
        {
            // End:0x8B
            if(MobileMenuStack[I] == SceneToClose)
            {
                Idx = I;
                // [Explicit Break]
                goto J0x99;
            }
            I++;
            // [Loop Continue]
            goto J0x3C;
        }
        J0x99:

        // End:0x131
        if(Idx >= 0)
        {
            bClosedTopMenu = Idx == 0;
            MobileMenuStack.Remove(Idx, 1);
            SceneToClose.Closed();
            // End:0x131
            if(bClosedTopMenu)
            {
                // End:0x131
                if(MobileMenuStack.Length > 0)
                {
                    MobileMenuStack[0].MadeTopMenu();
                }
            }
        }
    }
    //return;    
}

event CloseAllMenus()
{
    J0x00:
    // End:0x34 [Loop If]
    if(MobileMenuStack.Length > 0)
    {
        CloseMenuScene(MobileMenuStack[MobileMenuStack.Length - 1]);
        // [Loop Continue]
        goto J0x00;
    }
    //return;    
}

event RenderMenus(Canvas Canvas, float RenderDelta)
{
    local int I;

    Canvas.Reset();
    // End:0x2F
    if(bDisableSceneRender)
    {
        return;
    }
    I = MobileMenuStack.Length - 1;
    J0x46:

    // End:0x9E [Loop If]
    if(I >= 0)
    {
        MobileMenuStack[I].RenderScene(Canvas, RenderDelta);
        I--;
        // [Loop Continue]
        goto J0x46;
    }
    //return;    
}

function PreClientTravel(string PendingURL, Actor.ETravelType TravelType, bool bIsSeamlessTravel)
{
    local int I;

    super.PreClientTravel(PendingURL, TravelType, bIsSeamlessTravel);
    I = MobileMenuStack.Length - 1;
    J0x3D:

    // End:0x83 [Loop If]
    if(I >= 0)
    {
        MobileMenuStack[I].Closed();
        I--;
        // [Loop Continue]
        goto J0x3D;
    }
    //return;    
}

exec function SceneRenderToggle()
{
    bDisableSceneRender = !bDisableSceneRender;
    //return;    
}

exec function MobileMenuCommand(string MenuCommand)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x68 [Loop If]
    if(I < MobileMenuStack.Length)
    {
        // End:0x5A
        if(MobileMenuStack[I].MobileMenuCommand(MenuCommand))
        {
            return;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

exec function MobileMenuScene OpenMobileMenu(string MenuClassName)
{
    local Class<MobileMenuScene> MenuClass;

    MenuClass = Class<MobileMenuScene>(DynamicLoadObject(MenuClassName, Class'Core.Class'));
    // End:0x54
    if(MenuClass != none)
    {
        return OpenMenuScene(MenuClass);
    }
    return none;
    //return ReturnValue;    
}

exec function MobileMenuScene OpenMobileMenuMode(string MenuClassName, string Mode)
{
    local Class<MobileMenuScene> MenuClass;

    MenuClass = Class<MobileMenuScene>(DynamicLoadObject(MenuClassName, Class'Core.Class'));
    // End:0x5C
    if(MenuClass != none)
    {
        return OpenMenuScene(MenuClass, Mode);
    }
    return none;
    //return ReturnValue;    
}
