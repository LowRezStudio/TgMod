class TgProj_LanepusherCannon extends TgProj_Simulated
    hidecategories(Navigation);

simulated event Vector GetSeekLocation()
{
    local float fDist, fSpeed;
    local Vector TargetLocation;
    local TgPawn_SiegeWall WallPawn;

    // End:0x39
    if(m_TrackingSettings.mTarget == none)
    {
        return Location + Vector(Rotation);
    }
    TargetLocation = m_TrackingSettings.mTarget.Location;
    WallPawn = TgPawn_SiegeWall(m_TrackingSettings.mTarget);
    // End:0xD5
    if(WallPawn != none)
    {
        TargetLocation.Z += 100.0000000;
    }
    fDist = VSize(TargetLocation - Location);
    fSpeed = VSize(Velocity);
    // End:0x1AA
    if((fSpeed > float(0)) && VSizeSq(m_TrackingSettings.mTarget.Velocity) > float(0))
    {
        TargetLocation += (m_TrackingSettings.mTarget.Velocity * (fDist / fSpeed));
    }
    return TargetLocation;
    //return ReturnValue;    
}

simulated function Tick(float fDeltaTime)
{
    super.Tick(fDeltaTime);
    // End:0x96
    if(((VSizeSq(Velocity) < 0.1000000) && VSizeSq(Location - (GetSeekLocation())) < 25.0000000) && !m_bHasExploded)
    {
        ExplodeOnTarget(m_TrackingSettings.mTarget, Location, Vector(Rotation));
    }
    //return;    
}

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_LanepusherCannon.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Simulated.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_TrackingSettings=(bUsesTracking=true,bIgnoreWorldIfSeeking=true)
    // Reference: CylinderComponent'TgGame.Default__TgProj_LanepusherCannon.CollisionCylinder'
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