class TgDeploy_Expose extends TgDeploy_TurretEffectField
    placeable
    hidecategories(Navigation);

function FireAmmunitionDeployable()
{
    // End:0x4F
    if((m_ParentTurret != none) && int(m_ParentTurret.r_eCurrentStunType) == int(0))
    {
        super(TgDeployable).FireAmmunitionDeployable();
        r_nFlashFireCount++;
    }
    //return;    
}

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_Expose.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_TurretEffectField.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
}