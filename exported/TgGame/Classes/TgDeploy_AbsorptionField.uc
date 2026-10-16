class TgDeploy_AbsorptionField extends TgDeploy_Shield
    native(ChampLazarus)
    notplaceable
    hidecategories(Navigation);

// Export UTgDeploy_AbsorptionField::execMitigateHealthDamage(FFrame&, void* const)
native function MitigateHealthDamage(TgPawn pInstigator, TgEffectDamage Effect, ImpactInfo Impact, out float NewValue, out float fPercReduction);

event TakeDamage(int Damage, Controller EventInstigator, Vector HitLocation, Vector Momentum, Class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    return;
    //return;    
}

defaultproperties
{
    m_bMovableProjBlocker=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_AbsorptionField.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_Shield.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_CollisionSettings=(bOnlyBlockShotsFromFront=true)
    m_nInitHUDOverlayDisplayMask=0
    Components[0]=MyLightEnvironment
}