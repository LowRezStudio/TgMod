class DamageType extends Object
    abstract
    native;

var() bool bArmorStops;
var bool bCausedByWorld;
var bool bExtraMomentumZ;
var() bool bCausesFracture;
var(RigidBody) bool bRadialDamageVelChange;
var(RigidBody) float KDamageImpulse;
var(RigidBody) float KDeathVel;
var(RigidBody) float KDeathUpKick;
var(RigidBody) float RadialDamageImpulse;
var float VehicleDamageScaling;
var float VehicleMomentumScaling;
var ForceFeedbackWaveform DamagedFFWaveform;
var ForceFeedbackWaveform KilledFFWaveform;
var float FracturedMeshDamage;

static function float VehicleDamageScalingFor(Vehicle V)
{
    return default.VehicleDamageScaling;
    //return ReturnValue;    
}

defaultproperties
{
    bArmorStops=true
    bExtraMomentumZ=true
    KDamageImpulse=800.0000000
    VehicleDamageScaling=1.0000000
    VehicleMomentumScaling=1.0000000
    FracturedMeshDamage=1.0000000
}