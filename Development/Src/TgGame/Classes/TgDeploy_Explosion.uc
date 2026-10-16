class TgDeploy_Explosion extends TgDeploy_EffectAura
    native(Deployable)
    placeable
    hidecategories(Navigation)
    config(Engine);

simulated event DestroyIt(optional bool bSkipFx) { }

simulated event ScaleFX() { }

defaultproperties
{}
