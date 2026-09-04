class GameThirdPersonCameraMode_Default extends GameThirdPersonCameraMode
    native(Camera)
    config(Camera);

var() protected const float WorstLocAimingZOffset;
var protected transient bool bTemporaryOriginRotInterp;
var() protected const float TemporaryOriginRotInterpSpeed;

defaultproperties
{
    WorstLocAimingZOffset=-10.0000000
    TemporaryOriginRotInterpSpeed=12.0000000
    BlendTime=0.2500000
    bValidateWorstLoc=false
    StrafeLeftAdjustment=(X=0.0000000,Y=-15.0000000,Z=0.0000000)
    StrafeRightAdjustment=(X=0.0000000,Y=15.0000000,Z=0.0000000)
    StrafeOffsetScalingThreshold=200.0000000
    RunFwdAdjustment=(X=20.0000000,Y=0.0000000,Z=0.0000000)
    RunBackAdjustment=(X=-30.0000000,Y=0.0000000,Z=0.0000000)
    RunOffsetScalingThreshold=200.0000000
    WorstLocOffset=(X=-8.0000000,Y=1.0000000,Z=95.0000000)
    ViewOffset=(OffsetHigh=(X=-128.0000000,Y=56.0000000,Z=40.0000000),OffsetMid=(X=-160.0000000,Y=48.0000000,Z=16.0000000),OffsetLow=(X=-160.0000000,Y=48.0000000,Z=56.0000000))
    ViewOffset_ViewportAdjustments[1]=(OffsetHigh=(X=0.0000000,Y=-20.0000000,Z=0.0000000),OffsetMid=(X=0.0000000,Y=-20.0000000,Z=0.0000000),OffsetLow=(X=0.0000000,Y=-20.0000000,Z=0.0000000))
    ViewOffset_ViewportAdjustments[2]=(OffsetHigh=(X=0.0000000,Y=0.0000000,Z=-12.0000000),OffsetMid=(X=0.0000000,Y=0.0000000,Z=-12.0000000),OffsetLow=(X=0.0000000,Y=0.0000000,Z=-12.0000000))
    ViewOffset_ViewportAdjustments[3]=(OffsetHigh=(X=0.0000000,Y=0.0000000,Z=17.0000000),OffsetMid=(X=0.0000000,Y=0.0000000,Z=17.0000000),OffsetLow=(X=0.0000000,Y=0.0000000,Z=17.0000000))
    ViewOffset_ViewportAdjustments[4]=(OffsetHigh=(X=0.0000000,Y=0.0000000,Z=-15.0000000),OffsetMid=(X=0.0000000,Y=0.0000000,Z=-15.0000000),OffsetLow=(X=0.0000000,Y=0.0000000,Z=-15.0000000))
}