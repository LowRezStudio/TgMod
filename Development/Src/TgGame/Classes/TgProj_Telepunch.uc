class TgProj_Telepunch extends TgProj_Simulated
    native(ChampDemon)
    hidecategories(Navigation)
    config(Engine);

simulated event ExplodeOnTarget(Actor Target, Vector HitLocation, Vector HitNormal) { }

defaultproperties
{}
