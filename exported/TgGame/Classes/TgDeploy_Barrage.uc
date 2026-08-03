class TgDeploy_Barrage extends TgDeployable
    native(ChampViktor)
    notplaceable
    hidecategories(Navigation);

var TgCameraShake m_CameraShake;
var float m_fAllowableGroundTraceDist;
var bool m_bShouldAirBurst;

// Export UTgDeploy_Barrage::execAdjustMeshToGround(FFrame&, void* const)
native function AdjustMeshToGround();

simulated function TriggerHitFX()
{
    // End:0x3D
    if(m_bShouldAirBurst)
    {
        c_Mesh.FxActivateGroup('Generic2', 0);        
    }
    else
    {
        c_Mesh.FxActivateGroup('Generic1', 0);
    }
    //return;    
}

simulated event PlayFireFx()
{
    local TgPlayerController TgPC;

    super.PlayFireFx();
    TgPC = TgPlayerController(GetALocalPlayerController());
    // End:0x75
    if(TgPC != none)
    {
        TgPC.PlayTgCameraShake(m_CameraShake, self.Location, self);
    }
    //return;    
}

simulated state Deploy
{
    simulated function BeginState(name PreviousStateName)
    {
        super.BeginState(PreviousStateName);
        // End:0xA5
        if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && int(WorldInfo.NetMode) != int(NM_ListenServer))
        {
            // End:0x9B
            if(r_fTimeToDeploySecs > 0.2000000)
            {
                SetTimer(r_fTimeToDeploySecs - 0.2000000, false, 'TriggerHitFX');                
            }
            else
            {
                TriggerHitFX();
            }
        }
        // End:0x119
        if(r_DRI != none)
        {
            r_DRI.SetHUDOverlayDisplayMask(r_DRI.r_nDeployableOverlayDisplayMask | 73);
            r_DRI.c_fBarragePercent = 1.0000000;
        }
        //return;        
    }

    simulated function TickDeploy(float DeltaSeconds)
    {
        super.TickDeploy(DeltaSeconds);
        // End:0xA7
        if(r_DRI != none)
        {
            r_DRI.c_fBarragePercent = 1.0000000 - m_fCurrentDeployPercentage;
            // End:0xA7
            if(m_fCurrentDeployPercentage >= 0.9990000)
            {
                r_DRI.SetHUDOverlayDisplayMask(r_DRI.r_nDeployableOverlayDisplayMask & ~73);
            }
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_CameraShake=TgCameraShake'GP_Viktor.BarrageShake'
    m_fAllowableGroundTraceDist=80.0000000
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_Barrage.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeployable.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_GameplayCurves=TgGameplayCurves'GP_Viktor.DeviceBarrage'
    Components[0]=MyLightEnvironment
}