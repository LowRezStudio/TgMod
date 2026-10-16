class TgProj_DrogozRocket extends TgProj_Simulated
    native(ChampDrogoz)
    hidecategories(Navigation);

var bool m_bWasFromSalvo;

function bool ApplyTheHit(TgDeviceFire FireMode, ImpactInfo Impact, Actor DamageInstigator)
{
    local TgProj_Loogie loogieTarget;

    // End:0x108
    if((Impact.HitActor != none) && Impact.HitActor.Owner != none)
    {
        loogieTarget = TgProj_Loogie(Impact.HitActor.Owner);
        // End:0x108
        if(loogieTarget != none)
        {
            loogieTarget.DetonateFromRocket(self, Impact.HitLocation, Impact.HitNormal);
            return false;
        }
    }
    return super(TgProjectile).ApplyTheHit(FireMode, Impact, DamageInstigator);
    //return ReturnValue;    
}

defaultproperties
{
    m_bExplodeAtMaxRange=true
    m_bCountDirectHitForAOE=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_DrogozRocket.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Simulated.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_DrogozRocket.CollisionCylinder'
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