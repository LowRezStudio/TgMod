class TgPawn_Demon extends TgPawn_Character
    native(ChampDemon)
    config(Game)
    hidecategories(Navigation);

var() WeaponDOF m_CurrentDOFSettings;
var bool r_bIsUltActive;
var bool r_bIsUltTargeting;
var bool m_bUseTelepunchZoom;
var bool m_bTelepunchTargetLocked;
var TgPawn_Character m_TelepunchTarget;

replication
{
    // Pos:0x000
    if(bNetDirty)
        r_bIsUltActive, r_bIsUltTargeting;
}

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    return "";
    //return ReturnValue;    
}

// Export UTgPawn_Demon::execDeviceOnStartFire(FFrame&, void* const)
native function DeviceOnStartFire(TgDevice Dev);

simulated function GetCameraZoomOverride(out float fZoom, out float fZoomDuration)
{
    super.GetCameraZoomOverride(fZoom, fZoomDuration);
    // End:0x38
    if(m_bUseTelepunchZoom)
    {
        fZoomDuration = 0.0500000;
    }
    //return;    
}

reliable server event ServerNotifyTelepunchTarget(TgPawn_Character pTarget)
{
    m_TelepunchTarget = pTarget;
    //return;    
}

function OnUltStarted()
{
    r_bIsUltActive = true;
    bNetDirty = true;
    PauseDeviceTimers(true);
    //return;    
}

reliable client simulated function ClientOnUltStarted()
{
    PauseDeviceTimers(true);
    //return;    
}

function OnUltFinished()
{
    r_bIsUltActive = false;
    bNetDirty = true;
    PauseDeviceTimers(false);
    //return;    
}

reliable client simulated function ClientOnUltFinished()
{
    PauseDeviceTimers(false);
    //return;    
}

simulated function PauseDeviceTimers(bool bPaused)
{
    local TgDevice Device;

    Device = GetDeviceByEqPoint(3);
    // End:0x86
    if((Device != none) && Device.IsTimerActive('FirePostHitDelay'))
    {
        Device.PauseTimer(bPaused, 'FirePostHitDelay');
    }
    Device = GetDeviceByEqPoint(4);
    // End:0x10C
    if((Device != none) && Device.IsTimerActive('FirePostHitDelay'))
    {
        Device.PauseTimer(bPaused, 'FirePostHitDelay');
    }
    //return;    
}

defaultproperties
{
    m_CurrentDOFSettings=(IsActive=false,DOFType=EDOFType.DOFType_SimpleDOF,Falloff=1.0000000,BlurKernelSize=3.0000000,FocusType=EFocusType.FOCUS_Distance,FocusInnerRadius=15.0000000,FocusDistance=60.0000000,MaxNearBlurAmount=1.0000000,MinBlurAmount=1.0000000,MaxFarBlurAmount=0.3300000)
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Demon.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Demon.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_bCanChargeInAir=true
    m_bUsesRecoil=true
    m_sGameplayPackage="Demon"
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Demon.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    c_fFxScaleSize=0.9500000
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Demon.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Demon.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Demon.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Demon.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    BaseEyeHeight=50.0000000
    EyeHeight=50.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Demon.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Demon.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}