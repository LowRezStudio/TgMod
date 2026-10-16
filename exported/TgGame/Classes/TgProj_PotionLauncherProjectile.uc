class TgProj_PotionLauncherProjectile extends TgProj_FreeGrenade
    hidecategories(Navigation);

simulated function PlayAdditionalHitFX(bool bSuccessfulHit, Vector FXLocation, Vector HitNormal, Vector ProjDir, out array<ParticleSysParam> ExplosionParams)
{
    local int I;
    local TgPawn TgP;
    local TgDeviceForm devForm;

    TgP = TgPawn(Instigator);
    // End:0x3E
    if((TgP == none) || c_Mesh == none)
    {
        return;
    }
    I = 0;
    J0x49:

    // End:0x20A [Loop If]
    if(I < 33)
    {
        devForm = TgP.c_EquipForm[I];
        // End:0x1FC
        if((devForm != none) && devForm.FormState != 'DeviceCoolDown')
        {
            switch(devForm.c_EquipDeviceInfo.nDeviceId)
            {
                // End:0x155
                case 12840:
                    c_Mesh.FxActivateIndependant('PipLauncherMalady', 0, FXLocation, ProjDir,,,, ExplosionParams);
                    // End:0x1FC
                    break;
                // End:0x1A7
                case 12846:
                    c_Mesh.FxActivateIndependant('PipLauncherAmbush', 0, FXLocation, ProjDir,,,, ExplosionParams);
                    // End:0x1FC
                    break;
                // End:0x1F9
                case 12842:
                    c_Mesh.FxActivateIndependant('PipLauncherBlight', 0, FXLocation, ProjDir,,,, ExplosionParams);
                    // End:0x1FC
                    break;
                // End:0xFFFF
                default:
                    break;
            }
        }
        else
        {
            I++;
            // [Loop Continue]
            goto J0x49;
        }/* !MISMATCHING REMOVE, tried Loop got Type:Else Position:0x1FC! */
        //return;        
    }/* !MISMATCHING REMOVE, tried Else got Type:Loop Position:0x049! */
}

defaultproperties
{
    m_bExplodeOnGeometry=true
    m_bUseGravityZOverride=true
    m_fGravityZOverride=-650.0000000
    m_bExplodeAtMaxRange=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_PotionLauncherProjectile.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_FreeGrenade.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_PotionLauncherProjectile.CollisionCylinder'
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