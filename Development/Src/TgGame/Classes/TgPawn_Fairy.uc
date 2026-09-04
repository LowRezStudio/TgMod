class TgPawn_Fairy extends TgPawn_Character
    native(ChampFairy)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

var float m_fFairyFlySpeedModifier;
var (Fairy) float m_fFlightAccelerationPerSecond;
var (Fairy) float m_fFlightDecelerationPerSecond;
var (Fairy) float m_fFlightMaxRiseSpeed;
var (Fairy) float m_fAscentDecelerationPerSecond;
var (Fairy) float m_fFaeFlightFriction;
var float m_fPreviousAscentVelocity;
var TgDevice_Flutter m_CachedFlutterDevice;
var TgDevice_FaeFlight m_CachedFaeFlightDevice;

native function bool HasFlutterDevice();  // Export UTgPawn_Fairy::execHasFlutterDevice(FFrame&, void* const)

native function bool HasFaeFlightDevice();  // Export UTgPawn_Fairy::execHasFaeFlightDevice(FFrame&, void* const)

native function Vector GetChargeDirection();  // Export UTgPawn_Fairy::execGetChargeDirection(FFrame&, void* const)

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

defaultproperties
{}
