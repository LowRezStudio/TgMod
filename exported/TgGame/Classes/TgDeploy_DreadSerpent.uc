class TgDeploy_DreadSerpent extends TgDeploy_EffectField
    placeable
    hidecategories(Navigation);

var array<Actor> s_HitActors;

function ProxyTouchHit(Actor Other)
{
    local ImpactInfo Impact;

    // End:0x26E
    if(((m_FireMode != none) && m_FireMode.IsValidTarget(Other)) && m_FireMode.IsBlockedByBlocker(self, Other, self.Location + vect(0.0000000, 0.0000000, 5.0000000), Other.Location) == none)
    {
        Impact.bDirectHit = true;
        Impact.DeviceModeReference = m_FireMode;
        Impact.HitActor = Other;
        Impact.HitLocation = Other.Location;
        Impact.HitNormal = Normal(self.Location - Other.Location);
        Impact.StartTrace = self.Location + vect(0.0000000, 0.0000000, 5.0000000);
        Impact.RayDir = Normal(Other.Location - self.Location);
        m_FireMode.ApplyHit(Impact, self);
    }
    //return;    
}

defaultproperties
{
    m_fEffectFieldHeight=500.0000000
    m_bOnlyHitOnce=true
    m_bAdjustMeshToGround=false
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_DreadSerpent.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_EffectField.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
}