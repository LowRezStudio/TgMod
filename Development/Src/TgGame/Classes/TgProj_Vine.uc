class TgProj_Vine extends TgProj_Simulated
    hidecategories(Navigation)
    config(Engine);

var TgDeviceForm_Vine m_VineForm;

simulated event SpawnFlightEffects() { }

simulated event ExplodeOnTarget(Actor Target, Vector HitLocation, Vector HitNormal) { }

simulated event Fizzle() { }

simulated function StartPull(Actor Target, Vector HitLocation) { }

defaultproperties
{}
