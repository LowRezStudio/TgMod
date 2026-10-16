class TgDevice_ShellSpin extends TgDevice_Charge
    native(ChampMakoa)
    hidecategories(Navigation)
    config(Engine);

var TgPawn r_PawnTarget;
var float m_fWalkableFloorZ;
var float m_fZoomDurationOverride;
var bool m_bCarryEnemies;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_PawnTarget;
}

native function TurnTargetToOwner();  // Export UTgDevice_ShellSpin::execTurnTargetToOwner(FFrame&, void* const)

native function bool PredictChargeInterrupt(Vector StartLocation, Vector endLocation);  // Export UTgDevice_ShellSpin::execPredictChargeInterrupt(FFrame&, void* const)

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function OutroLockoutTime() { }

state DeviceFiring {}

defaultproperties
{
    m_fWalkableFloorZ=0.7000000
    m_fZoomDurationOverride=0.1000000
    m_ChargeTimingType=CFT_PostFire
    m_vHitProxyRelativeLocation=(X=30.0000000,Y=0.0000000,Z=0.0000000)
    m_bUsesOutroLockout=true
    m_fOutroLockoutTime=0.3000000
}
