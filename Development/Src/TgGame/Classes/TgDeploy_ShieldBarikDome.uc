class TgDeploy_ShieldBarikDome extends TgDeploy_Shield
    native(ChampBarik)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

simulated event DestroyIt(optional bool bSkipFx) { }

defaultproperties
{}
