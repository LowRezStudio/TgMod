class TgPawn_Cassie extends TgPawn_Character
    native(ChampCassie)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

var float r_fRadiusForBlastShotFX;
var repnotify bool r_bRollBonusActive;
var TgDevice_Scout m_CachedScoutDevice;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bRollBonusActive, r_fRadiusForBlastShotFX;
}

simulated event ReplicatedEvent(name VarName) { }

simulated event UpdateBonusVisualization() { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

defaultproperties
{}
