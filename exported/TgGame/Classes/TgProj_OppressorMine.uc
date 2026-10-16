class TgProj_OppressorMine extends TgProj_FreeGrenade
    native(ChampKinessa)
    hidecategories(Navigation);

// Export UTgProj_OppressorMine::execSpawnDeployable(FFrame&, void* const)
native function TgDeployable SpawnDeployable(Vector vLocation, optional Actor TargetActor, optional Vector vNormal);

simulated function Actor CalculateHitActor(Actor Target, Vector HitLocation, Vector HitNormal, out TraceHitInfo HitInfo)
{
    return Target;
    //return ReturnValue;    
}

simulated function bool ShouldHitBounce(Actor Target, Vector HitNormal)
{
    // End:0x36
    if((Target != none) && Target.IsA('TgPawn_Juggernaut'))
    {
        return false;
    }
    // End:0xCE
    if((Target != none) && !CheckTeamPassThrough(Target))
    {
        // End:0xCE
        if((Target.IsA('TgPawn') || Target.IsA('TgDeployable')) || Target.IsA('DynamicBlockingVolume'))
        {
            return true;
        }
    }
    return super.ShouldHitBounce(Target, HitNormal);
    //return ReturnValue;    
}

defaultproperties
{
    m_bExplodeOnTouch=false
    m_bExplodeOnGeometry=true
    m_fBounceDamping=0.5000000
    m_nShadowFXID=7060
    m_fMaxDecalHeight=2000.0000000
    m_DeployableSpawnOrientation=SpawnDeployableOrientation.SDO_FaceRotation
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_OppressorMine.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_FreeGrenade.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_OppressorMine.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgProj_FreeGrenade.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=MyLightEnvironment
    CollisionComponent=CollisionCylinder
}