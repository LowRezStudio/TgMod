class TgProj_HealingPotion extends TgProj_FreeGrenade
    native(ChampPip)
    hidecategories(Navigation);

// Export UTgProj_HealingPotion::execGetExplosionFXParams(FFrame&, void* const)
native function GetExplosionFXParams(out array<ParticleSysParam> Params);

simulated function PlayAdditionalHitFX(bool bSuccessfulHit, Vector FXLocation, Vector HitNormal, Vector ProjDir, out array<ParticleSysParam> ExplosionParams)
{
    local TgPawn_Pip pipOwner;

    super(TgProjectile).PlayAdditionalHitFX(bSuccessfulHit, FXLocation, HitNormal, ProjDir, ExplosionParams);
    pipOwner = TgPawn_Pip(r_Owner);
    // End:0xDF
    if(((c_Mesh != none) && pipOwner != none) && pipOwner.r_bHasMegaPotion)
    {
        c_Mesh.FxActivateIndependant('Generic1', 0, FXLocation, ProjDir,,,, ExplosionParams);
    }
    //return;    
}

defaultproperties
{
    m_bExplodeOnGeometry=true
    m_bUseGravityZOverride=true
    m_fGravityZOverride=-650.0000000
    m_bExplodeAtMaxRange=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_HealingPotion.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_FreeGrenade.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_CollisionSettings=(bPassThroughFriends=false,bPassThroughEnemies=true)
    // Reference: CylinderComponent'TgGame.Default__TgProj_HealingPotion.CollisionCylinder'
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