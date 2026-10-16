class TgProj_ImpalerArrow extends TgProj_Greatbow
    native(ChampLongbow)
    hidecategories(Navigation);

var float m_fCollisionScale;

function bool ApplyTheHit(TgDeviceFire FireMode, ImpactInfo Impact, Actor DamageInstigator)
{
    FireMode.ApplyHitSpecial(Impact.HitActor, Impact, 10693);
    return FireMode.ApplyHit(Impact, DamageInstigator);
    //return ReturnValue;    
}

defaultproperties
{
    m_fCollisionScale=2.0000000
    m_bCanSpawnOnClientFirst=false
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_ImpalerArrow.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Greatbow.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_ImpalerArrow.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgProj_Greatbow.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=MyLightEnvironment
    CollisionComponent=CollisionCylinder
}