class TgDeploy_Epicenter extends TgDeploy_TurretEffectField
    placeable
    hidecategories(Navigation);

function OnProxyUnTouch(Actor Other)
{
    local ImpactInfo Impact;

    // End:0xF1
    if(m_TouchingPawns.Find(Other) != -1)
    {
        // End:0xF1
        if((m_FireMode != none) && m_ParentTurret != none)
        {
            Impact.bDirectHit = true;
            Impact.DeviceModeReference = m_FireMode;
            Impact.HitActor = Other;
            m_FireMode.ApplyHit(Impact, m_ParentTurret.r_Owner);
        }
    }
    super.OnProxyUnTouch(Other);
    //return;    
}

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_Epicenter.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_TurretEffectField.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
}