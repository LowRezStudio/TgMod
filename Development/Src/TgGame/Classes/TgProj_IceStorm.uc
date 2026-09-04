class TgProj_IceStorm extends TgProj_Simulated
    hidecategories(Navigation)
    config(Engine);

var bool m_bStopped;
var bool m_bCheckLOSForHit;

simulated function CompleteInitialization() { }

function HandleTick() { }

simulated function Tick(float DeltaSeconds) { }

simulated event ExplodeOnTarget(Actor Target, Vector HitLocation, Vector HitNormal) { }

simulated function float GetRemainingTime() { }

defaultproperties
{}
