class CameraModifier_CameraShake extends CameraModifier
    native(Camera);

struct native CameraShakeInstance
{
    var CameraShake SourceShake;
    var name SourceShakeName;
    var float OscillatorTimeRemaining;
    var bool bBlendingIn;
    var float CurrentBlendInTime;
    var bool bBlendingOut;
    var float CurrentBlendOutTime;
    var Vector LocSinOffset;
    var Vector RotSinOffset;
    var float FOVSinOffset;
    var Vector2D HUDSinOffset;
    var float Scale;
    var CameraAnimInst AnimInst;
    var Camera.ECameraAnimPlaySpace PlaySpace;
    var Matrix UserPlaySpaceMatrix;

    structdefaultproperties
    {
        SourceShake=none
        SourceShakeName="None"
        OscillatorTimeRemaining=0.0000000
        bBlendingIn=false
        CurrentBlendInTime=0.0000000
        bBlendingOut=false
        CurrentBlendOutTime=0.0000000
        LocSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        RotSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        FOVSinOffset=0.0000000
        HUDSinOffset=(X=0.0000000,Y=0.0000000)
        Scale=0.0000000
        AnimInst=none
        PlaySpace=ECameraAnimPlaySpace.CAPS_CameraLocal
        UserPlaySpaceMatrix=(XPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000),YPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000),ZPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000),WPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000))
    }
};

var array<CameraShakeInstance> ActiveShakes;
var() protected const float SplitScreenShakeScale;

protected static function float InitializeOffset(const out FOscillator Param)
{
    switch(Param.InitialOffset)
    {
        // End:0x3B
        case 0:
            return (FRand() * float(2)) * 3.1415930;
        // End:0x46
        case 1:
            return 0.0000000;
        // End:0xFFFF
        default:
            return 0.0000000;
            break;
    }
    //return ReturnValue;    
}

protected function ReinitShake(int ActiveShakeIdx, float Scale)
{
    local CameraShake SourceShake;
    local float Duration;
    local bool bRandomStart, bLoop;

    // End:0x36
    if(Class'Engine.Engine'.static.IsSplitScreen())
    {
        Scale *= SplitScreenShakeScale;
    }
    ActiveShakes[ActiveShakeIdx].Scale = Scale;
    SourceShake = ActiveShakes[ActiveShakeIdx].SourceShake;
    // End:0x279
    if(SourceShake.OscillationDuration != 0.0000000)
    {
        ActiveShakes[ActiveShakeIdx].OscillatorTimeRemaining = SourceShake.OscillationDuration;
        // End:0x279
        if(ActiveShakes[ActiveShakeIdx].bBlendingOut)
        {
            ActiveShakes[ActiveShakeIdx].bBlendingOut = false;
            ActiveShakes[ActiveShakeIdx].CurrentBlendOutTime = 0.0000000;
            ActiveShakes[ActiveShakeIdx].bBlendingIn = true;
            ActiveShakes[ActiveShakeIdx].CurrentBlendInTime = ActiveShakes[ActiveShakeIdx].SourceShake.OscillationBlendInTime * (1.0000000 - (ActiveShakes[ActiveShakeIdx].CurrentBlendOutTime / ActiveShakes[ActiveShakeIdx].SourceShake.OscillationBlendOutTime));
        }
    }
    // End:0x3E4
    if(SourceShake.Anim != none)
    {
        // End:0x2FF
        if(SourceShake.bRandomAnimSegment)
        {
            bLoop = true;
            bRandomStart = true;
            Duration = SourceShake.RandomAnimSegmentDuration;
        }
        ActiveShakes[ActiveShakeIdx].AnimInst = CameraOwner.PlayCameraAnim(SourceShake.Anim, SourceShake.AnimPlayRate, Scale, SourceShake.AnimBlendInTime, SourceShake.AnimBlendOutTime, bLoop, bRandomStart, Duration, true);
    }
    //return;    
}

protected function CameraShakeInstance InitializeShake(CameraShake NewShake, float Scale, Camera.ECameraAnimPlaySpace PlaySpace, optional Rotator UserPlaySpaceRot)
{
    local CameraShakeInstance Inst;
    local float Duration;
    local bool bRandomStart, bLoop;

    Inst.SourceShakeName = NewShake.Name;
    Inst.SourceShake = new (self) NewShake.Class;
    Inst.SourceShake.OscillationDuration = NewShake.OscillationDuration;
    Inst.SourceShake.OscillationBlendInTime = NewShake.OscillationBlendInTime;
    Inst.SourceShake.OscillationBlendOutTime = NewShake.OscillationBlendOutTime;
    Inst.SourceShake.RotOscillation = NewShake.RotOscillation;
    Inst.SourceShake.LocOscillation = NewShake.LocOscillation;
    Inst.SourceShake.FOVOscillation = NewShake.FOVOscillation;
    Inst.SourceShake.Anim = NewShake.Anim;
    Inst.SourceShake.AnimPlayRate = NewShake.AnimPlayRate;
    Inst.SourceShake.AnimBlendInTime = NewShake.AnimBlendInTime;
    Inst.SourceShake.AnimBlendOutTime = NewShake.AnimBlendOutTime;
    Inst.SourceShake.bRandomAnimSegment = NewShake.bRandomAnimSegment;
    Inst.SourceShake.RandomAnimSegmentDuration = NewShake.RandomAnimSegmentDuration;
    Inst.SourceShake.bDoHUDShake = NewShake.bDoHUDShake;
    Inst.SourceShake.HUDOscillation = NewShake.HUDOscillation;
    Inst.Scale = Scale;
    // End:0x53C
    if(Class'Engine.Engine'.static.IsSplitScreen())
    {
        Scale *= SplitScreenShakeScale;
    }
    // End:0x9A5
    if(NewShake.OscillationDuration != 0.0000000)
    {
        Inst.RotSinOffset.X = InitializeOffset(NewShake.RotOscillation.Pitch);
        Inst.RotSinOffset.Y = InitializeOffset(NewShake.RotOscillation.Yaw);
        Inst.RotSinOffset.Z = InitializeOffset(NewShake.RotOscillation.Roll);
        Inst.LocSinOffset.X = InitializeOffset(NewShake.LocOscillation.X);
        Inst.LocSinOffset.Y = InitializeOffset(NewShake.LocOscillation.Y);
        Inst.LocSinOffset.Z = InitializeOffset(NewShake.LocOscillation.Z);
        Inst.HUDSinOffset.X = InitializeOffset(NewShake.HUDOscillation.X);
        Inst.HUDSinOffset.Y = InitializeOffset(NewShake.HUDOscillation.Y);
        Inst.FOVSinOffset = InitializeOffset(NewShake.FOVOscillation);
        Inst.OscillatorTimeRemaining = NewShake.OscillationDuration;
        // End:0x9A5
        if(NewShake.OscillationBlendInTime > 0.0000000)
        {
            Inst.bBlendingIn = true;
            Inst.CurrentBlendInTime = 0.0000000;
        }
    }
    // End:0xBB3
    if(NewShake.Anim != none)
    {
        // End:0xA2B
        if(NewShake.bRandomAnimSegment)
        {
            bLoop = true;
            bRandomStart = true;
            Duration = NewShake.RandomAnimSegmentDuration;
        }
        // End:0xBB3
        if(Scale > 0.0000000)
        {
            Inst.AnimInst = CameraOwner.PlayCameraAnim(NewShake.Anim, NewShake.AnimPlayRate, Scale, NewShake.AnimBlendInTime, NewShake.AnimBlendOutTime, bLoop, bRandomStart, Duration, NewShake.bSingleInstance);
            // End:0xBB3
            if((int(PlaySpace) != int(0)) && Inst.AnimInst != none)
            {
                Inst.AnimInst.SetPlaySpace(PlaySpace, UserPlaySpaceRot);
            }
        }
    }
    Inst.PlaySpace = PlaySpace;
    // End:0xC30
    if(int(Inst.PlaySpace) == int(2))
    {
        Inst.UserPlaySpaceMatrix = MakeRotationMatrix(UserPlaySpaceRot);
    }
    return Inst;
    //return ReturnValue;    
}

function AddCameraShake(CameraShake NewShake, float Scale, optional Camera.ECameraAnimPlaySpace PlaySpace = 0, optional Rotator UserPlaySpaceRot)
{
    local int ShakeIdx, NumShakes;

    // End:0xFD
    if(NewShake != none)
    {
        // End:0xA7
        if(NewShake.bSingleInstance)
        {
            ShakeIdx = ActiveShakes.Find('SourceShakeName', NewShake.Name);
            // End:0xA7
            if(ShakeIdx != -1)
            {
                ReinitShake(ShakeIdx, Scale);
                return;
            }
        }
        NumShakes = ActiveShakes.Length;
        ActiveShakes[NumShakes] = InitializeShake(NewShake, Scale, PlaySpace, UserPlaySpaceRot);
    }
    //return;    
}

function RemoveCameraShake(CameraShake Shake)
{
    local int Idx;
    local CameraAnimInst AnimInst;

    Idx = ActiveShakes.Find('SourceShakeName', Shake.Name);
    // End:0x11F
    if(Idx != -1)
    {
        AnimInst = ActiveShakes[Idx].AnimInst;
        // End:0x10A
        if((AnimInst != none) && !AnimInst.bFinished)
        {
            CameraOwner.StopCameraAnim(AnimInst, ((Shake.AnimBlendOutTime > 0.0000000) ? false : true));
        }
        ActiveShakes.Remove(Idx, 1);
    }
    //return;    
}

function RemoveAllCameraShakes()
{
    local int Idx;
    local CameraAnimInst AnimInst;

    Idx = 0;
    J0x0B:

    // End:0xBF [Loop If]
    if(Idx < ActiveShakes.Length)
    {
        AnimInst = ActiveShakes[Idx].AnimInst;
        // End:0xB1
        if((AnimInst != none) && !AnimInst.bFinished)
        {
            CameraOwner.StopCameraAnim(AnimInst, true);
        }
        ++Idx;
        // [Loop Continue]
        goto J0x0B;
    }
    ActiveShakes.Length = 0;
    //return;    
}

// Export UCameraModifier_CameraShake::execUpdateCameraShake(FFrame&, void* const)
native function UpdateCameraShake(float DeltaTime, out CameraShakeInstance Shake, out TPOV OutPOV);

// Export UCameraModifier_CameraShake::execModifyCamera(FFrame&, void* const)
native function bool ModifyCamera(Camera Camera, float DeltaTime, out TPOV OutPOV);

defaultproperties
{
    SplitScreenShakeScale=0.5000000
}