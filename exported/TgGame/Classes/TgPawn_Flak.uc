class TgPawn_Flak extends TgPawn_Character
    native(ChampFlak)
    config(Game)
    hidecategories(Navigation);

var TgDevice_KineticBurst m_CachedKineticBurstDevice;
var TgDevice_SiegeUnit m_CachedSiegeUnitDevice;
var TgDevice_AssertDominance m_CachedUltimateDevice;
var TgDevice_ShoulderBash m_CachedShoulderBashDevice;
var TgSpecialFx m_WepIdleSound;
var float m_PreviousZHeight;
var float m_GravityMultiplier;
var bool m_bUseShoulderBashRetrieve;
var bool m_bUseShoulderBashZoom;

// Export UTgPawn_Flak::execStartZTracking(FFrame&, void* const)
native function StartZTracking();

// Export UTgPawn_Flak::execMaxOutGravity(FFrame&, void* const)
native function MaxOutGravity();

// Export UTgPawn_Flak::execGetGravityZ(FFrame&, void* const)
native function float GetGravityZ();

// Export UTgPawn_Flak::execSpawnFlagDeployable(FFrame&, void* const)
native function SpawnFlagDeployable();

// Export UTgPawn_Flak::execResetGravTimers(FFrame&, void* const)
native function ResetGravTimers();

// Export UTgPawn_Flak::execDeployableOnDestroyed(FFrame&, void* const)
native function DeployableOnDestroyed(TgDeployable dep);

// Export UTgPawn_Flak::execHasCachedKineticBurstDevice(FFrame&, void* const)
native function bool HasCachedKineticBurstDevice();

function RampUpTimer()
{
    //return;    
}

function RampDownTimer()
{
    //return;    
}

simulated function OnRespawn()
{
    super.OnRespawn();
    ResetInhandFiremode();
    //return;    
}

simulated function OnLiveRespawn()
{
    super(TgPawn).OnLiveRespawn();
    ResetInhandFiremode();
    //return;    
}

simulated function ResetInhandFiremode()
{
    local TgDevice_FlakInhand pFlakInhand;
    local TgDeviceForm_KineticBurst pDeviceForm;

    pFlakInhand = TgDevice_FlakInhand(GetCurrentInhandDevice());
    // End:0x4D
    if(pFlakInhand != none)
    {
        pFlakInhand.SetFireMode(0, true);
    }
    // End:0x104
    if((HasCachedKineticBurstDevice()) == true)
    {
        pDeviceForm = TgDeviceForm_KineticBurst(m_CachedKineticBurstDevice.c_DeviceForm);
        // End:0x104
        if(pDeviceForm != none)
        {
            // End:0x104
            if(pDeviceForm.HasCachedMIC() == true)
            {
                pDeviceForm.GlowMIC.SetScalarParameterValue('FX_GlowRamp', 0.1000000);
            }
        }
    }
    //return;    
}

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    switch(MountType)
    {
        // End:0x4F
        case 1:
            return "PC_Flak_Skin00A.Anims.AS_PC_Flak_Skin00A_Mount_Horse";
        // End:0xFFFF
        default:
            return "";
            break;
    }
    //return ReturnValue;    
}

simulated function GetCameraZoomOverride(out float fZoom, out float fZoomDuration)
{
    super.GetCameraZoomOverride(fZoom, fZoomDuration);
    // End:0x38
    if(m_bUseShoulderBashZoom)
    {
        fZoomDuration = 0.0500000;
    }
    //return;    
}

defaultproperties
{
    m_GravityMultiplier=1.0000000
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Flak.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Flak.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_sGameplayPackage="Flak"
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Flak.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Flak.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Flak.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Flak.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Flak.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Flak.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=none
    Components[2]=MyLightEnvironment
    Components[3]=CollisionCylinder
    Components[4]=TakeHitAC
    Components[5]=PainAC
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Flak.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}