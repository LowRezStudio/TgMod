class TgProj_Drag extends TgProj_Simulated
    native(ChampMakoa)
    hidecategories(Navigation)
    config(Engine);

var TgDeviceForm_Drag m_DragForm;
var float m_fCollisionHeightScale;

simulated event SpawnFlightEffects() { }

function RangeReached() { }

simulated event Fizzle() { }

simulated event ExplodeOnTarget(Actor Target, Vector HitLocation, Vector HitNormal) { }

simulated function bool StartDrag(Actor Target, Vector HitLocation) { }

defaultproperties
{}
