class SVehicleSimTank extends SVehicleSimCar
    native(Physics);

var float LeftTrackVel;
var float RightTrackVel;
var float LeftTrackTorque;
var float RightTrackTorque;
var() float MaxEngineTorque;
var() float EngineDamping;
var() float InsideTrackTorqueFactor;
var() float SteeringLatStiffnessFactor;
var() float TurnInPlaceThrottle;
var() float TurnMaxGripReduction;
var() float TurnGripScaleRate;
var() bool bTurnInPlaceOnSteer;

defaultproperties
{
    MaxEngineTorque=500.0000000
    TurnMaxGripReduction=0.9700000
    TurnGripScaleRate=1.0000000
    bTurnInPlaceOnSteer=true
    bWheelSpeedOverride=true
}