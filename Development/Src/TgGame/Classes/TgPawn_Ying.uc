class TgPawn_Ying extends TgPawn_Character
    native(ChampYing)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

var Actor r_InhandTarget;
var Vector r_InhandHitOffset;
var TgPawn_Character m_TeleportTarget;
var bool m_bRetrievedIllusionListThisTick;
var bool m_bHasShatterableIllusionsThisTick;
var bool r_bHasCompensate;
var bool m_bPulledTargetFromList;
var array<TgInterface_YingIllusion> m_ActiveIllusions;
var () float m_fFrictionMultiplier;
var () float m_fGravityMultiplier;
var () float m_fMaxFallSpeed;

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetDirty) r_InhandHitOffset, r_InhandTarget, r_bHasCompensate;
}

native function float GetGravityZ();  // Export UTgPawn_Ying::execGetGravityZ(FFrame&, void* const)

native function bool PopulateActiveDecoyList(optional out byte bHasShatterableIllusions);  // Export UTgPawn_Ying::execPopulateActiveDecoyList(FFrame&, void* const)

simulated event KillAllOwnedPets() { }

event bool Died(Controller Killer, class<DamageType> DamageType, vector HitLocation) { }

function ClearDimensionalLink() { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

defaultproperties
{}
