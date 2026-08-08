class TgPawn_Fernando extends TgPawn_Character
    native(ChampFernando)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

const ACTIVE_SHIELD_MASK = 1;

const TOWERING_BARRIER_MASK = 2;

const GENERAL_DEFENSIVE_MASK = 4;

var repnotify int r_ShieldDisplayType;
var bool c_bShowingShield;

replication {
    if(bNetDirty) r_ShieldDisplayType;
}

native function bool SpecialAOEImmunity(Vector AOECenter, TgDeviceFire instigatingFiremode);  // Export UTgPawn_Fernando::execSpecialAOEImmunity(FFrame&, void* const)

event ShowShield() { }

event HideShield() { }

simulated event ReplicatedEvent(name VarName) { }

simulated function PlayShieldFX() { }

simulated function PlayLargeShieldFX() { }

simulated function StopShieldFX() { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

defaultproperties
{}
