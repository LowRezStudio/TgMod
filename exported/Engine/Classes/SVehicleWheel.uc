class SVehicleWheel extends Component
    native(Physics);

enum EWheelSide
{
    SIDE_None,                      // 0
    SIDE_Left,                      // 1
    SIDE_Right,                     // 2
    SIDE_MAX                        // 3
};

var() float Steer;
var() float MotorTorque;
var() float BrakeTorque;
var() float ChassisTorque;
var() bool bPoweredWheel;
var() bool bHoverWheel;
var() bool bCollidesVehicles;
var() bool bCollidesPawns;
var bool bIsSquealing;
var bool bWheelOnGround;
var() float SteerFactor;
var() name SkelControlName;
var SkelControlWheel WheelControl;
var() name BoneName;
var() Vector BoneOffset;
var() float WheelRadius;
var() float SuspensionTravel;
var() float SuspensionSpeed;
var() ParticleSystem WheelParticleSystem;
var() SVehicleWheel.EWheelSide Side;
var() float LongSlipFactor;
var() float LatSlipFactor;
var() float HandbrakeLongSlipFactor;
var() float HandbrakeLatSlipFactor;
var() float ParkedSlipFactor;
var Vector WheelPosition;
var float SpinVel;
var float LongSlipRatio;
var float LatSlipAngle;
var Vector ContactNormal;
var Vector LongDirection;
var Vector LatDirection;
var float ContactForce;
var float LongImpulse;
var float LatImpulse;
var float DesiredSuspensionPosition;
var float SuspensionPosition;
var float CurrentRotation;
var const transient Pointer WheelShape;
var const transient int WheelMaterialIndex;
var Class<ParticleSystemComponent> WheelPSCClass;
var export editinline ParticleSystemComponent WheelParticleComp;
var name SlipParticleParamName;

defaultproperties
{
    bCollidesVehicles=true
    WheelRadius=35.0000000
    SuspensionTravel=30.0000000
    SuspensionSpeed=50.0000000
    LongSlipFactor=4000.0000000
    LatSlipFactor=20000.0000000
    HandbrakeLongSlipFactor=4000.0000000
    HandbrakeLatSlipFactor=20000.0000000
    ParkedSlipFactor=20000.0000000
    WheelPSCClass=Class'Engine.ParticleSystemComponent'
    SlipParticleParamName="WheelSlip"
}