class TgPawn_Makoa extends TgPawn_Character
    native(ChampMakoa)
    config(Game)
    hidecategories(Navigation);

var float m_fSmashSpeedModifier;
var float m_fShellSpinZoomOverride;
var bool r_bShellShieldIsActive;
var repnotify bool r_bAncientRageActive;
var bool r_bAbility1CanEmote;
var float m_fShellShieldSpeedModifier;
var float m_fShellShieldZoomOverride;
var TgSpecialFx m_ShellShieldMovementFX;
var TgDevice m_AncientRageInHand;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_bAbility1CanEmote, r_bAncientRageActive, 
        r_bShellShieldIsActive;
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x2E
    if(VarName == 'r_bAncientRageActive')
    {
        PlayAncientRageEffects(r_bAncientRageActive);        
    }
    else
    {
        super.ReplicatedEvent(VarName);
    }
    //return;    
}

simulated function PlayAncientRageEffects(bool bEnabled)
{
    local TgDevice newFiringDevice;
    local WeaponMeshSwapStrategy SwapStrategy;

    // End:0x29
    if(int(Role) == int(ROLE_Authority))
    {
        r_bAncientRageActive = bEnabled;
    }
    // End:0x4C
    if(bEnabled)
    {
        newFiringDevice = m_AncientRageInHand;        
    }
    else
    {
        newFiringDevice = GetDeviceByEqPoint(1);
    }
    // End:0xB5
    if(((newFiringDevice != none) && IsLocallyControlled()) && PlayerController(Controller) != none)
    {
        SetTargetingDevice(newFiringDevice, SwapStrategy);
    }
    //return;    
}

simulated event SetTargetingDevice(TgDevice Dev, WeaponMeshSwapStrategy SwapStrategy)
{
    // End:0x5D
    if((((Dev != none) && Dev == (GetDeviceByEqPoint(1))) && r_bAncientRageActive) && m_AncientRageInHand != none)
    {
        Dev = m_AncientRageInHand;
    }
    super(TgPawn).SetTargetingDevice(Dev, SwapStrategy);
    //return;    
}

simulated function GetCameraZoomOverride(out float fZoom, out float fZoomDuration)
{
    super.GetCameraZoomOverride(fZoom, fZoomDuration);
    // End:0x62
    if((m_fShellSpinZoomOverride > 0.0000000) || m_fShellShieldZoomOverride > 0.0000000)
    {
        fZoom = FMax(m_fShellSpinZoomOverride, m_fShellShieldZoomOverride);
    }
    //return;    
}

simulated event float GetAbilityEmoteChance(TgPawn.EEmote Emote)
{
    local float fAbilityEmoteChance;

    fAbilityEmoteChance = super(TgPawn).GetAbilityEmoteChance(Emote);
    // End:0x51
    if(int(Emote) == int(13))
    {
        // End:0x4B
        if(r_bAbility1CanEmote)
        {
            return fAbilityEmoteChance;            
        }
        else
        {
            return -1.0000000;
        }
    }
    return fAbilityEmoteChance;
    //return ReturnValue;    
}

simulated function name GetFootStepOverride()
{
    // End:0x17
    if(r_bAncientRageActive)
    {
        return 'FootstepSpecial1';
    }
    return super(TgPawn).GetFootStepOverride();
    //return ReturnValue;    
}

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    switch(MountType)
    {
        // End:0x44
        case 1:
            return "PC_Makoa.Anims.AS_PC_Makoa_3p_Mount_Horse";
        // End:0xFFFF
        default:
            return "";
            break;
    }
    //return ReturnValue;    
}

simulated function OnDeviceFormHit(int nEquipSlot, Actor Target, float DamageAmount, Vector HitLocation, Vector HitNormal, const out ExtraDamageInfo ExtraInfo)
{
    local TgDeviceForm DeviceForm;

    DeviceForm = c_EquipForm[nEquipSlot];
    // End:0xB2
    if(((DeviceForm != none) && Target != none) && DamageAmount > 0.0000000)
    {
        // End:0xB2
        if(nEquipSlot == 18)
        {
            DeviceForm.DeactivateFxGroup('MakoaSmashHit');
            DeviceForm.ActivateFxGroup('MakoaSmashHit');
        }
    }
    //return;    
}

defaultproperties
{
    m_fSmashSpeedModifier=1.0000000
    m_fShellShieldSpeedModifier=1.0000000
    m_fMountZoomOverride=1.5000000
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Makoa.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Makoa.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_sGameplayPackage="Makoa"
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Makoa.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Makoa.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Makoa.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Makoa.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Makoa.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Makoa.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Makoa.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}