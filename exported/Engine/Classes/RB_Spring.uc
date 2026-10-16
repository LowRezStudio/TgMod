class RB_Spring extends ActorComponent
    native(Physics);

var const export editinline PrimitiveComponent Component1;
var const name BoneName1;
var const export editinline PrimitiveComponent Component2;
var const name BoneName2;
var native const int SceneIndex;
var native const bool bInHardware;
var() bool bEnableForceMassRatio;
var native const Pointer SpringData;
var native const float TimeSinceActivation;
var const float MinBodyMass;
var() float SpringSaturateDist;
var() float SpringMaxForce;
var() float MaxForceMassRatio;
var() InterpCurveFloat SpringMaxForceTimeScale;
var() float DampSaturateVel;
var() float DampMaxForce;

// Export URB_Spring::execSetComponents(FFrame&, void* const)
native function SetComponents(PrimitiveComponent InComponent1, name InBoneName1, Vector Position1, PrimitiveComponent InComponent2, name InBoneName2, Vector Position2);

// Export URB_Spring::execClear(FFrame&, void* const)
native function Clear();

defaultproperties
{
    SpringMaxForceTimeScale=(Points=((InVal=0.0000000,OutVal=1.0000000,ArriveTangent=0.0000000,LeaveTangent=0.0000000,InterpMode=EInterpCurveMode.CIM_Linear)),InterpMethod=EInterpMethodType.IMT_UseFixedTangentEvalAndNewAutoTangents)
    TickGroup=ETickingGroup.TG_PreAsyncWork
}