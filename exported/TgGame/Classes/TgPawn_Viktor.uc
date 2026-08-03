class TgPawn_Viktor extends TgPawn_Character
    native(ChampViktor)
    config(Game)
    hidecategories(Navigation);

var float r_fFragGrenadeExplodeTime;
var bool r_bFragGrenadeExplodeOnTouch;
var(Grenade) float m_fBounceDampingVertMin;
var(Grenade) float m_fBounceDampingVertMax;
var(Grenade) float m_fBounceDampingHorizMin;
var(Grenade) float m_fBounceDampingHorizMax;
var repnotify byte r_nGrenadeRefreshSound;
var repnotify byte r_nAmmoRefreshSound;
var() WeaponDOF m_CurrentDOFSettings;
var TgDevice_Hustle m_CachedHustleDevice;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && bNetDirty)
        r_bFragGrenadeExplodeOnTouch, r_fFragGrenadeExplodeTime;

    // Pos:0x020
    if(((int(Role) == int(ROLE_Authority)) && bNetDirty) && bDemoRecording || !(bNetInitial || bNetTimelapseInit) || bNetTimelapsePost)
        r_nAmmoRefreshSound, r_nGrenadeRefreshSound;
}

simulated event bool StartAction(TgDevice Dev, optional out TgObject.EDeviceFailType failType, optional bool bUpdateTimeStamp = true)
{
    local WeaponMeshSwapStrategy SwapStrategy;

    // End:0x70
    if(super(TgPawn).StartAction(Dev, failType, bUpdateTimeStamp))
    {
        // End:0x6E
        if(Dev.IsA('TgDevice_Barrage'))
        {
            SetTargetingDevice(Dev, SwapStrategy);
        }
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated event SetTargetingDevice(TgDevice Dev, WeaponMeshSwapStrategy SwapStrategy)
{
    // End:0x83
    if((((c_CurrentTargetingDevice != none) && c_CurrentTargetingDevice.IsA('TgDevice_Barrage')) && c_CurrentTargetingDevice.IsFiring()) && int(SwapStrategy.RetrieveStrategy) != int(2))
    {
        return;
    }
    super(TgPawn).SetTargetingDevice(Dev, SwapStrategy);
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x2F
    if(VarName == 'r_nGrenadeRefreshSound')
    {
        PlayLocalPawnFX('ViktorRefreshGrenade');
        return;        
    }
    else
    {
        // End:0x5B
        if(VarName == 'r_nAmmoRefreshSound')
        {
            PlayLocalPawnFX('ViktorRefreshAmmo');
            return;
        }
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

simulated event PlayLocalPawnFX(name nmDisplayGroup)
{
    local TgPlayerController TgPC;

    // End:0x11
    if(Mesh == none)
    {
        return;
    }
    TgPC = TgPlayerController(GetALocalPlayerController());
    // End:0x7C
    if((TgPC != none) && TgPC.GetTgPawn() == self)
    {
        FxReactivateGroupSelf(nmDisplayGroup, 0);
    }
    //return;    
}

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    switch(MountType)
    {
        // End:0x46
        case 1:
            return "PC_Viktor.Anims.AS_PC_Viktor_3p_Mount_Horse";
        // End:0xFFFF
        default:
            return "";
            break;
    }
    //return ReturnValue;    
}

// Export UTgPawn_Viktor::execGetPerCharacterAltEquipPoint(FFrame&, void* const)
native simulated function TgObject.TG_EQUIP_POINT GetPerCharacterAltEquipPoint();

defaultproperties
{
    m_fBounceDampingVertMin=0.1000000
    m_fBounceDampingVertMax=1.0000000
    m_fBounceDampingHorizMin=0.0900000
    m_fBounceDampingHorizMax=0.7500000
    m_CurrentDOFSettings=(IsActive=false,DOFType=EDOFType.DOFType_SimpleDOF,Falloff=1.0000000,BlurKernelSize=3.0000000,FocusType=EFocusType.FOCUS_Distance,FocusInnerRadius=15.0000000,FocusDistance=60.0000000,MaxNearBlurAmount=1.0000000,MinBlurAmount=1.0000000,MaxFarBlurAmount=0.3300000)
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Viktor.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Viktor.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_bUsesRecoil=true
    m_sGameplayPackage="Viktor"
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Viktor.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    c_fFxScaleSize=0.9500000
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Viktor.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Viktor.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Viktor.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Viktor.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    BaseEyeHeight=50.0000000
    EyeHeight=50.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Viktor.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Viktor.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}