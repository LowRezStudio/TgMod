class TgDeploy_HealthNugget_TeamOnly extends TgDeploy_HealthNugget
    native(Deployable)
    notplaceable
    hidecategories(Navigation);

var int r_nTaskForceAlignment;
var float m_fNuggetSpawnTime;
var float m_fNuggetGracePeriod;

replication
{
    // Pos:0x000
    if(bNetInitial && int(Role) == int(ROLE_Authority))
        r_nTaskForceAlignment;
}

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgPawn OtherPawn;

    OtherPawn = TgPawn(Other);
    // End:0x11B
    if(OtherPawn != none)
    {
        // End:0xE5
        if((m_fNuggetSpawnTime > 0.0000000) && (m_fNuggetSpawnTime + m_fNuggetGracePeriod) < WorldInfo.TimeSeconds)
        {
            // End:0xD7
            if(int(OtherPawn.GetTaskForceNumber()) == r_nTaskForceAlignment)
            {
                super.Touch(Other, OtherComp, HitLocation, HitNormal);                
            }
            else
            {
                DestroyIt();
            }            
        }
        else
        {
            // End:0x11B
            if(m_PendingTouches.Find(Other) == -1)
            {
                m_PendingTouches.AddItem(Other);
            }
        }
    }
    //return;    
}

defaultproperties
{
    m_fNuggetSpawnTime=-0.5000000
    m_fNuggetGracePeriod=0.5000000
    m_bCountTowardsHealingStats=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_HealthNugget_TeamOnly.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_HealthNugget.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgDeploy_HealthNugget_TeamOnly.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgDeploy_HealthNugget.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    Components[1]=CollisionCylinder
    CollisionComponent=CollisionCylinder
}