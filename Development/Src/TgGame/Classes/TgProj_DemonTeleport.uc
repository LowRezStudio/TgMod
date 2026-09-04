class TgProj_DemonTeleport extends TgProj_Simulated
    native(ChampDemon)
    hidecategories(Navigation)
    config(Engine);

var bool m_bStopped;
var bool m_bTriggerExplosion;

function bool ApplyHit(Actor Target, Vector HitLocation, Vector HitNormal, optional int HitItem) { }

simulated event HitWall(vector HitNormal, actor Wall, PrimitiveComponent WallComp) { }

simulated event ExplodeOnTarget(Actor Target, Vector HitLocation, Vector HitNormal) { }

function RangeReached() { }

simulated function StopMoving(Vector NewLocation) { }

defaultproperties
{}
