class TgPawn_Princess extends TgPawn_Character
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

var TgDevice_Enlightenment m_CachedEnlightenment;
var TgDevice_EnlightenmentGun m_CachedEnlightenmentGun;
var TgCombatActor r_GraceTargets[15];

simulated event ReplicatedEvent(name VarName) { }

simulated event ManageGraceTracers() { }

function bool HasCachedEnlightenment() { }

function bool HasCachedEnlightenmentGun() { }

function ToggleEnlightenmentGun(bool bEnabled) { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

defaultproperties
{}
