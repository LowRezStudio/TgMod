class TgProj_DemonTeleport extends TgProj_Simulated
    native(ChampDemon)
    hidecategories(Navigation);

var bool m_bStopped;
var bool m_bTriggerExplosion;

function bool ApplyHit(Actor Target, Vector HitLocation, Vector HitNormal, optional int HitItem)
{
    // End:0x3D
    if(m_bTriggerExplosion)
    {
        return super.ApplyHit(Target, HitLocation, HitNormal, HitItem);
    }
    return false;
    //return ReturnValue;    
}

simulated event HitWall(Vector HitNormal, Actor Wall, PrimitiveComponent WallComp)
{
    StopMoving(Location + (HitNormal * m_fProximityDistance));
    //return;    
}

simulated event ExplodeOnTarget(Actor Target, Vector HitLocation, Vector HitNormal)
{
    // End:0x0F
    if(bHurtEntry)
    {
        return;
    }
    // End:0x44
    if(m_bTriggerExplosion)
    {
        super.ExplodeOnTarget(Target, HitLocation, HitNormal);        
    }
    else
    {
        StopMoving(HitLocation + (HitNormal * m_fProximityDistance));
    }
    //return;    
}

function RangeReached()
{
    StopMoving(Location);
    //return;    
}

simulated function StopMoving(Vector NewLocation)
{
    // End:0x3E
    if(!m_bStopped)
    {
        m_bStopped = true;
        SetLocation(NewLocation);
        Velocity = vect(0.0000000, 0.0000000, 0.0000000);
    }
    //return;    
}

defaultproperties
{
    m_bTrackProjectileForTimelapse=true
    m_nDeployableOverlayDisplayMask=4097
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_DemonTeleport.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Simulated.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_CollisionSettings=(bExplodeOnShields=true,bExplodeOnBlockers=true,bHitAndPassThrough=true)
    // Reference: CylinderComponent'TgGame.Default__TgProj_DemonTeleport.CollisionCylinder'
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