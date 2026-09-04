class SVehicleSimBase extends ActorComponent
    native(Physics);

var() float WheelSuspensionStiffness;
var() float WheelSuspensionDamping;
var() float WheelSuspensionBias;
var() float WheelLongExtremumSlip;
var() float WheelLongExtremumValue;
var() float WheelLongAsymptoteSlip;
var() float WheelLongAsymptoteValue;
var() float WheelLatExtremumSlip;
var() float WheelLatExtremumValue;
var() float WheelLatAsymptoteSlip;
var() float WheelLatAsymptoteValue;
var() float WheelInertia;
var() bool bWheelSpeedOverride;
var() bool bClampedFrictionModel;
var() bool bAutoDrive;
var() float AutoDriveSteer;

defaultproperties
{
    WheelLongExtremumSlip=0.1000000
    WheelLongExtremumValue=1.0000000
    WheelLongAsymptoteSlip=2.0000000
    WheelLongAsymptoteValue=0.6000000
    WheelLatExtremumSlip=0.3500000
    WheelLatExtremumValue=0.8500000
    WheelLatAsymptoteSlip=1.4000000
    WheelLatAsymptoteValue=0.7000000
    WheelInertia=1.0000000
}