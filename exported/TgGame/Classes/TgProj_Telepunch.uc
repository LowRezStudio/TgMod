class TgProj_Telepunch extends TgProj_Simulated
    native(ChampDemon)
    hidecategories(Navigation);

simulated event ExplodeOnTarget(Actor Target, Vector HitLocation, Vector HitNormal)
{
    local TgDevice_Telepunch telepunchDevice;

    // End:0x84
    if(!m_bHasExploded)
    {
        // End:0x84
        if((m_OwnerFireMode != none) && m_OwnerFireMode.m_Owner != none)
        {
            telepunchDevice = TgDevice_Telepunch(m_OwnerFireMode.m_Owner);
            // End:0x84
            if(telepunchDevice != none)
            {
            }
        }
    }
    super.ExplodeOnTarget(Target, HitLocation, HitNormal);
    //return;    
}

defaultproperties
{
    m_bTrackProjectileForTimelapse=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Telepunch.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Simulated.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_Telepunch.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgProj_Simulated.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=MyLightEnvironment
    CollisionComponent=CollisionCylinder
}