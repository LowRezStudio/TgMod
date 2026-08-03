class TgDeploy_GeometryBuck extends TgDeploy_Geometry
    notplaceable
    hidecategories(Navigation);

var bool m_bInteriorEffectApplied;

simulated function Tick(float DeltaSeconds)
{
    super(TgDeployable).Tick(DeltaSeconds);
    // End:0x10D
    if((int(Role) == int(ROLE_Authority)) && Instigator != none)
    {
        // End:0xC5
        if(VSizeSq(Location - Instigator.Location) < float(((30 * 30) * 16) * 16))
        {
            // End:0xC2
            if(!m_bInteriorEffectApplied)
            {
                m_FireMode.ApplyHitSpecial(Instigator,, 10693);
                m_bInteriorEffectApplied = true;
            }            
        }
        else
        {
            // End:0x10D
            if(m_bInteriorEffectApplied)
            {
                m_FireMode.RemoveHitSpecial(Instigator, true, 10693);
                m_bInteriorEffectApplied = false;
            }
        }
    }
    //return;    
}

simulated function Destroyed()
{
    // End:0x48
    if(m_bInteriorEffectApplied)
    {
        m_FireMode.RemoveHitSpecial(Instigator, true, 10693);
        m_bInteriorEffectApplied = false;
    }
    super(TgDeployable).Destroyed();
    //return;    
}

defaultproperties
{
    m_bFireOnDeploy=false
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_GeometryBuck.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_Geometry.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
}