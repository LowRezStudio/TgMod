class TgPawn_Ruckus extends TgPawn_Character
    native(ChampRuckus)
    config(Game)
    hidecategories(Navigation);

var float m_fDamageAccumulator;
var repnotify bool r_bHexaFireFiring;
var const bool bEnableHoverWallClimb;
var bool bHoverWallClimb;
var bool m_bForceHover;
var bool m_bInstancedGemArmMaterials;
var bool m_bInstancedGemBodyMaterials;
var bool m_bRegisteredAudioCallbacks;
var bool m_bHasBoltGemFX;
var float r_fBarrelSpinRate;
var float r_fBarrelSpinFactor;
var TgDevice_RuckusInhand m_cachedRuckusInhand;
var TgDevice_HexaFireGuns m_CachedHexaFireGuns;
var TgDevice_Emitter m_CachedEmitter;
var TgDevice_RepulsorField m_CachedRepulsorField;
var float m_fDesiredHeight;
var float m_fKx;
var float m_fKv;
var float m_fHoverAccelMultiplier;
var array<MaterialInstanceConstant> m_ReplacementArmMICs;
var array<MaterialInstanceConstant> m_ReplacementBodyMICs;
var dword m_dwGemFXBusID;
var float m_fVGSMatBlue;
var TgSpecialFx m_IdleFX;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_bHexaFireFiring;

    // Pos:0x011
    if(bNetDirty)
        r_fBarrelSpinFactor, r_fBarrelSpinRate;
}

// Export UTgPawn_Ruckus::execPawnOnDamaged(FFrame&, void* const)
native function PawnOnDamaged(out OnDamagedParams Params);

// Export UTgPawn_Ruckus::execIs1PBodyOverlay(FFrame&, void* const)
native function bool Is1PBodyOverlay(TgPawn.OverlayMICType Type);

// Export UTgPawn_Ruckus::execIs1PWeaponOverlay(FFrame&, void* const)
native function bool Is1PWeaponOverlay(TgPawn.OverlayMICType Type);

// Export UTgPawn_Ruckus::execUpdateSkinBlueChannel(FFrame&, void* const)
native function UpdateSkinBlueChannel();

// Export UTgPawn_Ruckus::execIsNearAnyObjective(FFrame&, void* const)
native function bool IsNearAnyObjective();

// Export UTgPawn_Ruckus::execInstanceBodyMaterials(FFrame&, void* const)
native function bool InstanceBodyMaterials();

// Export UTgPawn_Ruckus::execInstanceArmMaterials(FFrame&, void* const)
native function bool InstanceArmMaterials();

simulated function bool HasCachedRuckusInhand()
{
    // End:0x35
    if(m_cachedRuckusInhand == none)
    {
        m_cachedRuckusInhand = TgDevice_RuckusInhand(GetDeviceByClass(Class'TgGame.TgDevice_RuckusInhand'));
    }
    return m_cachedRuckusInhand != none;
    //return ReturnValue;    
}

simulated function bool HasCachedHexaFireGuns()
{
    // End:0x35
    if(m_CachedHexaFireGuns == none)
    {
        m_CachedHexaFireGuns = TgDevice_HexaFireGuns(GetDeviceByClass(Class'TgGame.TgDevice_HexaFireGuns'));
    }
    return m_CachedHexaFireGuns != none;
    //return ReturnValue;    
}

simulated function bool HasCachedEmitter()
{
    // End:0x35
    if(m_CachedEmitter == none)
    {
        m_CachedEmitter = TgDevice_Emitter(GetDeviceByClass(Class'TgGame.TgDevice_Emitter'));
    }
    return m_CachedEmitter != none;
    //return ReturnValue;    
}

simulated function bool HasCachedRepulsorField()
{
    // End:0x35
    if(m_CachedRepulsorField == none)
    {
        m_CachedRepulsorField = TgDevice_RepulsorField(GetDeviceByClass(Class'TgGame.TgDevice_RepulsorField'));
    }
    return m_CachedRepulsorField != none;
    //return ReturnValue;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x2E
    if(VarName == 'r_bHexaFireFiring')
    {
        PlayHexaFireEffects(r_bHexaFireFiring);        
    }
    else
    {
        super.ReplicatedEvent(VarName);
    }
    //return;    
}

simulated event bool StartAction(TgDevice Dev, optional out TgObject.EDeviceFailType failType, optional bool bUpdateTimeStamp = true)
{
    // End:0x42
    if((Dev != none) && int(Dev.r_eEquippedAt) == int(18))
    {
        return false;
    }
    return super(TgPawn).StartAction(Dev, failType, bUpdateTimeStamp);
    //return ReturnValue;    
}

simulated function PlayHexaFireEffects(bool bEnabled)
{
    local TgDevice newFiringDevice;
    local WeaponMeshSwapStrategy SwapStrategy;

    // End:0x29
    if(int(Role) == int(ROLE_Authority))
    {
        r_bHexaFireFiring = bEnabled;
    }
    newFiringDevice = GetDeviceById(13219);
    // End:0x98
    if(!bEnabled)
    {
        // End:0x7F
        if(newFiringDevice != none)
        {
            newFiringDevice.InterruptFiring();
        }
        newFiringDevice = GetDeviceById(14581);
    }
    // End:0xD2
    if((newFiringDevice != none) && IsLocallyControlled())
    {
        SetTargetingDevice(newFiringDevice, SwapStrategy);
    }
    //return;    
}

simulated event SetTargetingDevice(TgDevice Dev, WeaponMeshSwapStrategy SwapStrategy)
{
    local bool bIsInhand;

    bIsInhand = false;
    // End:0x38
    if(HasCachedRuckusInhand())
    {
        bIsInhand = Dev == m_cachedRuckusInhand;
    }
    // End:0x67
    if(((Dev != none) && bIsInhand) && r_bHexaFireFiring)
    {
        return;
    }
    super(TgPawn).SetTargetingDevice(Dev, SwapStrategy);
    //return;    
}

simulated function bool ShouldStopWeaponMeshFireEffectsOnDeviceFormStopFire(int nEquipSlot)
{
    return true;
    //return ReturnValue;    
}

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    switch(MountType)
    {
        // End:0x53
        case 1:
            return "PC_Ruckus_Skin00A.Anims.AS_PC_Ruckus_Skin00A_Mount_Horse";
        // End:0xFFFF
        default:
            return "";
            break;
    }
    //return ReturnValue;    
}

simulated event BecomeViewTarget(PlayerController PC)
{
    super(TgPawn).BecomeViewTarget(PC);
    m_bInstancedGemArmMaterials = false;
    m_bInstancedGemBodyMaterials = false;
    //return;    
}

defaultproperties
{
    m_bHasBoltGemFX=true
    m_fDesiredHeight=208.0000000
    m_fKx=15.0000000
    m_fKv=3.0000000
    m_fHoverAccelMultiplier=1.0000000
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Ruckus.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Ruckus.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_bCanChargeInAir=true
    m_bEndChargeInFalling=true
    m_bAirAccuracyPenalty=false
    m_sGameplayPackage="Ruckus"
    m_n1PHeadMeshId=6752
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Ruckus.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    c_fFxScaleSize=1.5000000
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Ruckus.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Ruckus.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Ruckus.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Ruckus.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    c_fNextTakeHitDisplayDelay=0.1000000
    HeadBoneNames[0]="Neck1"
    HeadBoneNames[1]="head"
    HeadBoneNames[2]="Head_S1"
    m_HeadShotComponentBoneName="Head_S1"
    BaseEyeHeight=55.0000000
    EyeHeight=55.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Ruckus.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Ruckus.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}