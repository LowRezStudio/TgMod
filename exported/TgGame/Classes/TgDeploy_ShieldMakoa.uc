class TgDeploy_ShieldMakoa extends TgDeploy_Shield
    native(ChampMakoa)
    notplaceable
    hidecategories(Navigation);

var TgPawn m_CachedPawnOwner;
var repnotify int r_nCarapaceBonusHealth;
var bool r_bHasBarrierReef;
var int m_nBarrierReefDamage;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_bHasBarrierReef, r_nCarapaceBonusHealth;
}

// Export UTgDeploy_ShieldMakoa::execMitigateHealthDamage(FFrame&, void* const)
native function MitigateHealthDamage(TgPawn pInstigator, TgEffectDamage Effect, ImpactInfo Impact, out float NewValue, out float fPercReduction);

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_ShieldMakoa.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_Shield.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    AlwaysRelevantDistanceSquared=256000000.0000000
    Components[0]=MyLightEnvironment
}