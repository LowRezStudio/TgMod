class TgDeviceForm_ArcingBeam extends TgDeviceForm
    native(ChampGrohk)
    config(Engine);

struct ArcingFXInfo {
    var Actor Source;
    var Actor Target;
    var TgSpecialFx ArcingFX;
    var float fRemainingActiveTime;
    structdefaultproperties {}
};

var array<ArcingFXInfo> m_ArcingBeamList;
var Actor m_BeamSourceActor;
var float m_fBeamPersistTime;
var bool m_bRequireDeviceIsFiring;
var bool m_bIsFXContinuous;
var int m_nBeamEffectID;
var TgPawn_Grohk m_CachedGrohkPawn;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

event SetSourceArcingBeamEffect(Actor Source) { }

event SetTargetArcingBeamEffect(Actor Target) { }

native function UpdateBeamEndLocation(int Idx);  // Export UTgDeviceForm_ArcingBeam::execUpdateBeamEndLocation(FFrame&, void* const)

function StopArcingBeamEffects(optional Actor Target) { }

simulated function bool HasCachedGrohkPawn() { }

defaultproperties
{
    m_fBeamPersistTime=0.5000000
    m_bRequireDeviceIsFiring=true
    m_bIsFXContinuous=true
    m_nBeamEffectID=6980
    m_bUseImpactFXOverride=true
}
