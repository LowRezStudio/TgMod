class TgPawn_Owl extends TgPawn_Character
    native(ChampOwl)
    config(Game)
    hidecategories(Navigation);

var bool m_bUseSecondWeapon;
var bool m_bSwappingWeapons;
var bool c_bUseSecondDeathAnim;
var const int m_nAltInhandSlot;
var const int m_nAltAltfireSlot;
var float m_fOwlStealthJuice;
var float m_fMaxOwlStealthJuice;
var TgDevice_OwlStealth m_CachedOwlStealth;

// Export UTgPawn_Owl::execGetCurrentInhandDevice(FFrame&, void* const)
native function TgDevice GetCurrentInhandDevice();

// Export UTgPawn_Owl::execGetUISkillEqpSlotOverride(FFrame&, void* const)
native function int GetUISkillEqpSlotOverride(int nEquipSlot, optional bool bAltSlot = false);

// Export UTgPawn_Owl::execIsInScope(FFrame&, void* const)
native function bool IsInScope();

// Export UTgPawn_Owl::execOnPawnDied(FFrame&, void* const)
native function OnPawnDied();

simulated function PlayDying(Class<DamageType> dmgType, Vector HitLoc)
{
    c_bUseSecondDeathAnim = m_bUseSecondWeapon;
    super(TgPawn).PlayDying(dmgType, HitLoc);
    //return;    
}

simulated event name GetDeathAnimName()
{
    // End:0x17
    if(c_bUseSecondDeathAnim)
    {
        return 'Pistol_Death';
    }
    return 'Death';
    //return ReturnValue;    
}

simulated function SwapToSecondWeapon(bool bSecondWeaponActive)
{
    local WeaponMeshSwapStrategy SwapStrategy;

    m_bUseSecondWeapon = bSecondWeaponActive;
    SetTargetingDevice(m_EquippedDevices[((bSecondWeaponActive) ? m_nAltInhandSlot : 1)], SwapStrategy);
    ShowReticle(bSecondWeaponActive);
    m_bSwappingWeapons = true;
    //return;    
}

simulated function FinishedWeaponSwap()
{
    m_bSwappingWeapons = false;
    //return;    
}

simulated function ShowReticle(bool bShow)
{
    local TgPlayerController TgPC;

    TgPC = TgPlayerController(Controller);
    // End:0x55
    if(TgPC != none)
    {
        TgPC.SetReticleVisibility(bShow, true);
    }
    //return;    
}

simulated event SetTargetingDevice(TgDevice Dev, WeaponMeshSwapStrategy SwapStrategy)
{
    // End:0x66
    if(((Dev != none) && int(Dev.r_eEquippedAt) == int(1)) && m_bUseSecondWeapon)
    {
        Dev = m_EquippedDevices[m_nAltInhandSlot];
    }
    super(TgPawn).SetTargetingDevice(Dev, SwapStrategy);
    //return;    
}

simulated event InterruptInhandReload()
{
    super(TgPawn).InterruptInhandReload();
    // End:0x7A
    if((m_EquippedDevices[m_nAltInhandSlot] != none) && m_EquippedDevices[m_nAltInhandSlot].m_bCanReloadEarly)
    {
        m_EquippedDevices[m_nAltInhandSlot].InterruptReload();
    }
    //return;    
}

simulated event bool StartAction(TgDevice Dev, optional out TgObject.EDeviceFailType failType, optional bool bUpdateTimeStamp = true)
{
    // End:0x17
    if(Dev == none)
    {
        return false;
    }
    // End:0xC4
    if(m_bUseSecondWeapon && (int(Dev.r_eEquippedAt) == int(1)) || int(Dev.r_eEquippedAt) == int(16))
    {
        Dev = m_EquippedDevices[((Dev.m_bHandDevice) ? m_nAltInhandSlot : m_nAltAltfireSlot)];
    }
    return super(TgPawn).StartAction(Dev, failType, bUpdateTimeStamp);
    //return ReturnValue;    
}

event InterruptStealth(optional TgDevice OriginatingDevice)
{
    // End:0xC1
    if((OriginatingDevice == none) || !OriginatingDevice.IsA('TgDevice_WeaponSwap') && !OriginatingDevice.IsA('TgDevice_Scope'))
    {
        // End:0xA0
        if(int(r_eIsStealthed) != int(0))
        {
            // End:0xA0
            if(m_CachedOwlStealth != none)
            {
                m_CachedOwlStealth.InterruptFiring();
            }
        }
        ApplyStealthServer(0);
        super(TgPawn).InterruptStealth(OriginatingDevice);
    }
    //return;    
}

event ApplyStealthServer(TgPawn.STEALTH_TYPE eStealthed, optional float fRate = 9999.0000000, optional bool bForce = false)
{
    s_fDamageTakenDuringStealth = 0.0000000;
    super(TgPawn).ApplyStealthServer(eStealthed, fRate, bForce);
    //return;    
}

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    switch(MountType)
    {
        // End:0x4D
        case 1:
            return "pc_owl_skin00a.Anims.AS_PC_Owl_Skin00A_Mount_Horse";
        // End:0xFFFF
        default:
            return "";
            break;
    }
    //return ReturnValue;    
}

event ModifyStealthJuice(int nAmtModified, optional bool bSendToClient = false)
{
    local float fPrevStealthJuice;

    fPrevStealthJuice = m_fOwlStealthJuice;
    m_fOwlStealthJuice = FClamp(m_fOwlStealthJuice + float(nAmtModified), 0.0000000, m_fMaxOwlStealthJuice);
    UpdateOwlStealthFX(fPrevStealthJuice, m_fOwlStealthJuice);
    // End:0x95
    if(bSendToClient && !IsLocallyControlled())
    {
        ClientModifyStealthJuice(nAmtModified);
    }
    //return;    
}

reliable client simulated function ClientModifyStealthJuice(int nAmtModified)
{
    local float fPrevStealthJuice;

    fPrevStealthJuice = m_fOwlStealthJuice;
    m_fOwlStealthJuice = FClamp(m_fOwlStealthJuice + float(nAmtModified), 0.0000000, m_fMaxOwlStealthJuice);
    UpdateOwlStealthFX(fPrevStealthJuice, m_fOwlStealthJuice);
    //return;    
}

simulated function bool ShouldUseScopeSensitivity()
{
    return IsInScope();
    //return ReturnValue;    
}

// Export UTgPawn_Owl::execUpdateOwlStealthFX(FFrame&, void* const)
native function UpdateOwlStealthFX(float fPrevStealthJuice, float fCurrentStealthJuice);

defaultproperties
{
    m_nAltInhandSlot=18
    m_nAltAltfireSlot=12
    m_fOwlStealthJuice=100.0000000
    m_fMaxOwlStealthJuice=100.0000000
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Owl.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Owl.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_bUsesRecoil=true
    m_sGameplayPackage="Owl"
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Owl.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Owl.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Owl.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Owl.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Owl.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Owl.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Owl.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}