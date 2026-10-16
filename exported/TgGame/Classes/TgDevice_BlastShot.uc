class TgDevice_BlastShot extends TgDevice
    native(ChampCassie)
    hidecategories(Navigation);

event ScaleAbilityRadius()
{
    local TgPawn_Cassie cassieOwner;
    local TgDeviceFire FireMode;
    local TgProperty EffectRadiusProperty, EffectiveRadiusProperty;
    local float EffectRadius, EffectiveRadius, radiusScale;

    radiusScale = 1.0000000;
    FireMode = GetCurrentFire();
    // End:0x215
    if((FireMode != none) && radiusScale > 0.0000000)
    {
        EffectRadiusProperty = FireMode.GetProperty(6);
        EffectiveRadiusProperty = FireMode.GetProperty(343);
        // End:0x193
        if(EffectRadiusProperty != none)
        {
            EffectRadius = EffectRadiusProperty.m_fBase * radiusScale;
            // End:0x193
            if(EffectRadius > 0.0000000)
            {
                FireMode.SetProperty(6, EffectRadius);
                cassieOwner = TgPawn_Cassie(Owner);
                // End:0x193
                if(cassieOwner != none)
                {
                    cassieOwner.r_fRadiusForBlastShotFX = EffectRadius;
                    cassieOwner.bNetDirty = true;
                }
            }
        }
        // End:0x215
        if(EffectiveRadiusProperty != none)
        {
            EffectiveRadius = EffectiveRadiusProperty.m_fBase * radiusScale;
            // End:0x215
            if(EffectiveRadius > 0.0000000)
            {
                FireMode.SetProperty(343, EffectiveRadius);
            }
        }
    }
    //return;    
}

defaultproperties
{
    m_bAimThroughReticule=true
    m_vProjectileSpawnOffset=(X=15.0000000,Y=7.0000000,Z=-13.0000000)
    m_GameplayCurvesDeprecated=TgGameplayCurves'GP_Cassie.DeviceBlastShot'
}