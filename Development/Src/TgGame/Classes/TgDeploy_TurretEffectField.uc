class TgDeploy_TurretEffectField extends TgDeploy_EffectField
    native(ChampBarik)
    placeable
    hidecategories(Navigation)
    config(Engine);

var array<Actor> m_DeployTimePendingTargets;
var TgPawn_Turret m_ParentTurret;

function TouchAllPendingTargets() { }

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal) { }

function OnProxyUnTouch(Actor Other) { }

simulated function Tick(float DeltaSeconds) { }

defaultproperties
{}
