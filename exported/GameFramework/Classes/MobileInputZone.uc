class MobileInputZone extends Object
    native
    config(Game)
    perobjectconfig
    editinlinenew;

enum EZoneType
{
    ZoneType_Button,                // 0
    ZoneType_Joystick,              // 1
    ZoneType_Trackball,             // 2
    ZoneType_Slider,                // 3
    ZoneType_SubClassed,            // 4
    ZoneType_MAX                    // 5
};

enum EZoneState
{
    ZoneState_Inactive,             // 0
    ZoneState_Activating,           // 1
    ZoneState_Active,               // 2
    ZoneState_Deactivating,         // 3
    ZoneState_MAX                   // 4
};

enum EZoneSlideType
{
    ZoneSlide_UpDown,               // 0
    ZoneSlide_LeftRight,            // 1
    ZoneSlide_MAX                   // 2
};

struct native TextureUVs
{
    var() float U;
    var() float V;
    var() float UL;
    var() float VL;

    structdefaultproperties
    {
        U=0.0000000
        V=0.0000000
        UL=64.0000000
        VL=64.0000000
    }
};

var(Zone) config MobileInputZone.EZoneType Type;
var(Zone) byte TouchpadIndex;
var MobileInputZone.EZoneState State;
var(Options) config MobileInputZone.EZoneSlideType SlideType;
var(Zone) config string Caption;
var(Input) config name InputKey;
var(Input) config name HorizontalInputKey;
var(Input) config name TapInputKey;
var(Input) config name DoubleTapInputKey;
var(Input) config float VertMultiplier;
var(Input) config float HorizMultiplier;
var(Input) config float Acceleration;
var(Input) config float Smoothing;
var(Input) config float EscapeVelocityStrength;
var(Input) config bool bScalePawnMovement;
var(Bounds) config bool bRelativeX;
var(Bounds) config bool bRelativeY;
var(Bounds) config bool bRelativeSizeX;
var(Bounds) config bool bRelativeSizeY;
var(Bounds) config bool bActiveSizeYFromX;
var(Bounds) config bool bSizeYFromSizeX;
var(Bounds) config bool bApplyGlobalScaleToActiveSizes;
var(Bounds) config bool bCenterX;
var(Bounds) config bool bCenterY;
var(Options) config bool bIsInvisible;
var(Options) config bool bQuickDoubleTap;
var(Options) config bool bCenterOnEvent;
var(Options) config bool bSliderHasTrack;
var(Options) config bool bFloatingTiltZone;
var(Transitions) config bool bUseGentleTransitions;
var(Advanced) config bool bAllowFirstDeltaForTrackballZone;
var(Rendering) config bool bRenderGuides;
var bool bIsDoubleTapAndHold;
var(Bounds) config float X;
var(Bounds) config float Y;
var(Bounds) config float SizeX;
var(Bounds) config float SizeY;
var(Bounds) config float ActiveSizeX;
var(Bounds) config float ActiveSizeY;
var const float InitialX;
var const float InitialY;
var const float InitialSizeX;
var const float InitialSizeY;
var const float InitialActiveSizeX;
var const float InitialActiveSizeY;
var(Bounds) config float AuthoredGlobalScale;
var(Bounds) config float Border;
var(Options) config float ResetCenterAfterInactivityTime;
var(Options) config float TapDistanceConstraint;
var(Transitions) config float ActivateTime;
var(Transitions) config float DeactivateTime;
var(Rendering) config Color RenderColor;
var(Rendering) config float InactiveAlpha;
var(Rendering) config float CaptionXAdjustment;
var(Rendering) config float CaptionYAdjustment;
var(Rendering) Texture2D OverrideTexture1;
var config string OverrideTexture1Name;
var(Rendering) config TextureUVs OverrideUVs1;
var(Rendering) Texture2D OverrideTexture2;
var config string OverrideTexture2Name;
var(Rendering) config TextureUVs OverrideUVs2;
var Vector2D InitialLocation;
var Vector2D CurrentLocation;
var Vector2D CurrentCenter;
var Vector2D InitialCenter;
var Vector2D PreviousLocations[6];
var float PreviousMoveDeltaTimes[6];
var int PreviousLocationCount;
var float LastTouchTime;
var float TimeSinceLastTapRepeat;
var float AnimatingFadeOpacity;
var MobilePlayerInput InputOwner;
var float TransitionTime;
var Vector2D EscapeVelocity;
var array<SeqEvent_MobileZoneBase> MobileSeqEventHandlers;
var Vector2D LastAxisValues;
var float TotalActiveTime;
var float LastWentActiveTime;
//var delegate<OnProcessInputDelegate> __OnProcessInputDelegate__Delegate;
//var delegate<OnTapDelegate> __OnTapDelegate__Delegate;
//var delegate<OnDoubleTapDelegate> __OnDoubleTapDelegate__Delegate;
//var delegate<OnProcessSlide> __OnProcessSlide__Delegate;
//var delegate<OnPreDrawZone> __OnPreDrawZone__Delegate;
//var delegate<OnPostDrawZone> __OnPostDrawZone__Delegate;

// Export UMobileInputZone::execActivateZone(FFrame&, void* const)
native function ActivateZone();

// Export UMobileInputZone::execDeactivateZone(FFrame&, void* const)
native function DeactivateZone();

delegate bool OnProcessInputDelegate(MobileInputZone Zone, float DeltaTime, int Handle, Interaction.ETouchType EventType, Vector2D TouchLocation)
{
    //return ReturnValue;    
}

delegate bool OnTapDelegate(MobileInputZone Zone, Interaction.ETouchType EventType, Vector2D TouchLocation)
{
    //return ReturnValue;    
}

delegate bool OnDoubleTapDelegate(MobileInputZone Zone, Interaction.ETouchType EventType, Vector2D TouchLocation)
{
    //return ReturnValue;    
}

delegate bool OnProcessSlide(MobileInputZone Zone, Interaction.ETouchType EventType, int SlideValue, Vector2D ViewportSize)
{
    //return ReturnValue;    
}

delegate bool OnPreDrawZone(MobileInputZone Zone, Canvas Canvas)
{
    //return ReturnValue;    
}

delegate OnPostDrawZone(MobileInputZone Zone, Canvas Canvas)
{
    //return;    
}

function AddKismetEventHandler(SeqEvent_MobileZoneBase NewHandler)
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

defaultproperties
{
    VertMultiplier=1.0000000
    HorizMultiplier=1.0000000
    bApplyGlobalScaleToActiveSizes=true
    bUseGentleTransitions=true
    SizeX=100.0000000
    SizeY=100.0000000
    AuthoredGlobalScale=2.0000000
    ResetCenterAfterInactivityTime=3.0000000
    TapDistanceConstraint=5.0000000
    ActivateTime=0.6000000
    DeactivateTime=0.2000000
    RenderColor=(R=255,G=255,B=255,A=255)
    InactiveAlpha=0.5000000
    OverrideUVs1=(U=0.0000000,V=0.0000000,UL=64.0000000,VL=64.0000000)
    OverrideUVs2=(U=0.0000000,V=0.0000000,UL=64.0000000,VL=64.0000000)
}