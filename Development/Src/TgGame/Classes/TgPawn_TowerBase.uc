class TgPawn_TowerBase extends TgPawn_Structure
    native(Pawns)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

struct NavMeshBorderEdges {
    var Vector P1;
    var Vector P2;
    structdefaultproperties {}
};

var init array<init NavMeshBorderEdges> BorderEdges;
var transient TgSpecialFx c_BeamFX;
var export editinline TgMarkComponent s_DamageScaler;
var int m_nNumGuardianLevels;
var bool r_bLocked;
var protected transient bool m_bShouldBeFaded;
var float m_fTransparentFadeSpeed;
var float m_fMaxFadeTransparency;
var float m_fFadeDistance2D;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bLocked;
}

native function SetTargetActor(Actor Target);  // Export UTgPawn_TowerBase::execSetTargetActor(FFrame&, void* const)

native function SendTargetedAlert(TgPawn Target);  // Export UTgPawn_TowerBase::execSendTargetedAlert(FFrame&, void* const)

native function DeviceOnDamaged(out OnDamagedParams Params);  // Export UTgPawn_TowerBase::execDeviceOnDamaged(FFrame&, void* const)

native function DeviceAdjustDamage(out AdjustDamageParams Params, out float fDamage);  // Export UTgPawn_TowerBase::execDeviceAdjustDamage(FFrame&, void* const)

native function PawnOnDamageMitigation(TgPawn attacker, TgEffectGroup eg, out float fDamage, int nPropertyId);  // Export UTgPawn_TowerBase::execPawnOnDamageMitigation(FFrame&, void* const)

native function CalcDistanceFadeValue(float fDeltaTime);  // Export UTgPawn_TowerBase::execCalcDistanceFadeValue(FFrame&, void* const)

native function SetTransparencyFaded(bool bShouldBeFaded);  // Export UTgPawn_TowerBase::execSetTransparencyFaded(FFrame&, void* const)

native function QueryBorderEdges(Vector BoundsExtent, optional bool bUseObb=false);  // Export UTgPawn_TowerBase::execQueryBorderEdges(FFrame&, void* const)

native function Vector GetPositionOnBorderEdge(const Vector FromPosition);  // Export UTgPawn_TowerBase::execGetPositionOnBorderEdge(FFrame&, void* const)

event bool Died(Controller Killer, class<DamageType> DamageType, vector HitLocation) { }

defaultproperties
{}
