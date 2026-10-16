class CameraShake extends Object
    native(Camera)
    editinlinenew;

enum EInitialOscillatorOffset
{
    EOO_OffsetRandom,               // 0
    EOO_OffsetZero,                 // 1
    EOO_MAX                         // 2
};

struct native FOscillator
{
    var() float Amplitude;
    var() float Frequency;
    var() CameraShake.EInitialOscillatorOffset InitialOffset;

    structdefaultproperties
    {
        Amplitude=0.0000000
        Frequency=0.0000000
        InitialOffset=EInitialOscillatorOffset.EOO_OffsetRandom
    }
};

struct native ROscillator
{
    var() FOscillator Pitch;
    var() FOscillator Yaw;
    var() FOscillator Roll;

    structdefaultproperties
    {
        Pitch=(Amplitude=0.0000000,Frequency=0.0000000,InitialOffset=EInitialOscillatorOffset.EOO_OffsetRandom)
        Yaw=(Amplitude=0.0000000,Frequency=0.0000000,InitialOffset=EInitialOscillatorOffset.EOO_OffsetRandom)
        Roll=(Amplitude=0.0000000,Frequency=0.0000000,InitialOffset=EInitialOscillatorOffset.EOO_OffsetRandom)
    }
};

struct native VOscillator
{
    var() FOscillator X;
    var() FOscillator Y;
    var() FOscillator Z;

    structdefaultproperties
    {
        X=(Amplitude=0.0000000,Frequency=0.0000000,InitialOffset=EInitialOscillatorOffset.EOO_OffsetRandom)
        Y=(Amplitude=0.0000000,Frequency=0.0000000,InitialOffset=EInitialOscillatorOffset.EOO_OffsetRandom)
        Z=(Amplitude=0.0000000,Frequency=0.0000000,InitialOffset=EInitialOscillatorOffset.EOO_OffsetRandom)
    }
};

struct native V2DOscillator
{
    var() FOscillator X;
    var() FOscillator Y;

    structdefaultproperties
    {
        X=(Amplitude=0.0000000,Frequency=0.0000000,InitialOffset=EInitialOscillatorOffset.EOO_OffsetRandom)
        Y=(Amplitude=0.0000000,Frequency=0.0000000,InitialOffset=EInitialOscillatorOffset.EOO_OffsetRandom)
    }
};

var() bool bSingleInstance;
var(AnimShake) bool bRandomAnimSegment;
var(HUD) bool bDoHUDShake;
var(Oscillation) float OscillationDuration;
var(Oscillation) float OscillationBlendInTime;
var(Oscillation) float OscillationBlendOutTime;
var(Oscillation) ROscillator RotOscillation;
var(Oscillation) VOscillator LocOscillation;
var(Oscillation) FOscillator FOVOscillation;
var(AnimShake) CameraAnim Anim;
var(AnimShake) float AnimPlayRate;
var(AnimShake) float AnimScale;
var(AnimShake) float AnimBlendInTime;
var(AnimShake) float AnimBlendOutTime;
var(AnimShake) float RandomAnimSegmentDuration;
var(HUD) V2DOscillator HUDOscillation;

simulated function float GetRotOscillationMagnitude()
{
    local Vector V;

    V.X = RotOscillation.Pitch.Amplitude;
    V.Y = RotOscillation.Yaw.Amplitude;
    V.Z = RotOscillation.Roll.Amplitude;
    return VSize(V);
    //return ReturnValue;    
}

simulated function float GetLocOscillationMagnitude()
{
    local Vector V;

    V.X = LocOscillation.X.Amplitude;
    V.Y = LocOscillation.Y.Amplitude;
    V.Z = LocOscillation.Z.Amplitude;
    return VSize(V);
    //return ReturnValue;    
}

simulated function float GetHUDOscillationMagnitude()
{
    local Vector V;

    V.X = HUDOscillation.X.Amplitude;
    V.Y = HUDOscillation.Y.Amplitude;
    V.Z = 0.0000000;
    return VSize(V);
    //return ReturnValue;    
}

defaultproperties
{
    OscillationBlendInTime=0.1000000
    OscillationBlendOutTime=0.2000000
    AnimPlayRate=1.0000000
    AnimScale=1.0000000
    AnimBlendInTime=0.2000000
    AnimBlendOutTime=0.2000000
}