class TgPawn_Androxus extends TgPawn_Character
    native(ChampAndroxus)
    config(Game)
    hidecategories(Navigation);

const TGPAWN_ANDROXUS_SLOWFALL_FX_ID = 6824;

var bool m_bIsInSlowFall;
var bool m_bForceAccursedArmDevice;
var repnotify bool r_bAccursedArmFiring;
var bool m_bUltimateReadyDisplayGroupOn;
var float m_fAccursedArmSpeedModifier;
var TgDevice m_AccursedArmInHand;
var float m_fDefianceAirControl;
var float m_fAirHangGravityModifier;
var float m_fJumpHoldMaxFallSpeed;
var TgDevice_NetherStep m_NetherStepDevice;
var float r_fFeatherweightAirControl;
var float r_fLiftOffDrift;
var int m_nAccursedArmActiveFX;
var array<TgAnimNodeBlendBySlowFall> m_SlowFallAnimNodes;
var repnotify int r_nDesiredSlowFallAnimChild;
var TgSpecialFx m_SlowFallFX;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_fFeatherweightAirControl, r_fLiftOffDrift;

    // Pos:0x011
    if((int(Role) == int(ROLE_Authority)) && ((!bNetOwner || bDemoRecording) || bNetTimelapse) || bNetTimelapsePost)
        r_bAccursedArmFiring, r_nDesiredSlowFallAnimChild;
}

// Export UTgPawn_Androxus::execInitializeSlowFallFX(FFrame&, void* const)
native function bool InitializeSlowFallFX();

// Export UTgPawn_Androxus::execGetAirControl(FFrame&, void* const)
native function float GetAirControl();

// Export UTgPawn_Androxus::execGetGravityZ(FFrame&, void* const)
native function float GetGravityZ();

// Export UTgPawn_Androxus::execShouldForceHideOverlaysWeapon(FFrame&, void* const)
native function bool ShouldForceHideOverlaysWeapon();

simulated event ReplicatedEvent(name VarName)
{
    switch(VarName)
    {
        // End:0x36
        case 'r_bAccursedArmFiring':
            PlayAccursedArmEffects(r_bAccursedArmFiring);
            // End:0x5B
            break;
        // End:0x58
        case 'r_nDesiredSlowFallAnimChild':
            SetSlowFallAnimationIndex(r_nDesiredSlowFallAnimChild);
            // End:0x5B
            break;
        // End:0xFFFF
        default:
            break;
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

simulated event bool PostPawnSetup()
{
    local bool Success;

    Success = super.PostPawnSetup();
    // End:0x2C
    if(Success)
    {
        InitializeSlowFallFX();
    }
    return Success;
    //return ReturnValue;    
}

simulated function CacheMultiMeshAnimNodeReferences(TgSkeletalMeshComponent smcomp)
{
    local array<AnimNode> AnimNodesBlendBySlowFall;
    local AnimNode AnimNodeSearchIterator;

    super(TgPawn).CacheMultiMeshAnimNodeReferences(smcomp);
    // End:0xA0
    if(smcomp != none)
    {
        smcomp.Animations.GetNodesByClassWrapper(AnimNodesBlendBySlowFall, Class'TgGame.TgAnimNodeBlendBySlowFall');
        // End:0x9F
        foreach AnimNodesBlendBySlowFall(AnimNodeSearchIterator)
        {
            m_SlowFallAnimNodes.AddItem(TgAnimNodeBlendBySlowFall(AnimNodeSearchIterator));            
        }        
    }
    //return;    
}

simulated event SetSlowFallAnimationIndex(int nIndex)
{
    local TgAnimNodeBlendBySlowFall AnimNodeSearchIterator;

    // End:0x40
    foreach m_SlowFallAnimNodes(AnimNodeSearchIterator)
    {
        AnimNodeSearchIterator.SetActiveAnimationIndex(nIndex);        
    }    
    r_nDesiredSlowFallAnimChild = nIndex;
    // End:0x70
    if(nIndex == 0)
    {
        StopSlowFallFx();        
    }
    else
    {
        PlaySlowFallFx();
    }
    bNetDirty = true;
    //return;    
}

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    switch(MountType)
    {
        // End:0x4A
        case 1:
            return "PC_Androxus.Anims.AS_PC_Androxus_3p_Mount_Horse";
        // End:0xFFFF
        default:
            return "";
            break;
    }
    //return ReturnValue;    
}

simulated function ApplyLiftOff()
{
    local TgPlayerController TgPC;

    TgPC = TgPlayerController(Controller);
    // End:0x104
    if((TgPC != none) && (int(TgPC.m_JumpHeld) > int(0)) || int(TgPC.m_JumpHeldAlt) > int(0))
    {
        // End:0x9A
        if(int(Physics) != int(2))
        {
            SetPhysics(2);
        }
        Velocity.X = 0.0000000;
        Velocity.Y = 0.0000000;
        Velocity.Z = r_fLiftOffDrift;
    }
    //return;    
}

function ToggleAccursedArm(bool bEnabled, optional float SpeedModifier = 1.0000000)
{
    local TgDevice newFiringDevice;
    local WeaponMeshSwapStrategy SwapStrategy;

    // End:0x24
    if(m_bForceAccursedArmDevice == bEnabled)
    {
        return;
    }
    m_bForceAccursedArmDevice = bEnabled;
    m_fAccursedArmSpeedModifier = ((bEnabled) ? SpeedModifier : 1.0000000);
    // End:0xDC
    if(bEnabled)
    {
        newFiringDevice = m_AccursedArmInHand;
        // End:0xD9
        if(newFiringDevice != none)
        {
            newFiringDevice.SetAmmo(newFiringDevice.r_nMaxAmmoClipCount);
            ForceUpdateAmmoAnim();
        }        
    }
    else
    {
        newFiringDevice = GetDeviceByEqPoint(1);
    }
    // End:0x145
    if(((newFiringDevice != none) && IsLocallyControlled()) && PlayerController(Controller) != none)
    {
        SetTargetingDevice(newFiringDevice, SwapStrategy);
    }
    PlayAccursedArmEffects(bEnabled);
    //return;    
}

protected simulated function PlayAccursedArmEffects(bool bEnabled)
{
    local TgDeviceForm_AccursedArm accursedArmForm;

    // End:0x29
    if(int(Role) == int(ROLE_Authority))
    {
        r_bAccursedArmFiring = bEnabled;
    }
    // End:0x54
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    accursedArmForm = TgDeviceForm_AccursedArm(c_EquipForm[2]);
    // End:0xAC
    if(accursedArmForm != none)
    {
        accursedArmForm.m_bShouldBeActive = bEnabled;
    }
    //return;    
}

simulated event SetTargetingDevice(TgDevice Dev, WeaponMeshSwapStrategy SwapStrategy)
{
    // End:0x5D
    if((((Dev != none) && Dev == (GetDeviceByEqPoint(1))) && m_bForceAccursedArmDevice) && m_AccursedArmInHand != none)
    {
        Dev = m_AccursedArmInHand;
    }
    super(TgPawn).SetTargetingDevice(Dev, SwapStrategy);
    //return;    
}

simulated event PlaySlowFallFx()
{
    // End:0x7E
    if(m_SlowFallFX != none)
    {
        StopSlowFallFx();
        // End:0x7E
        if(!m_SlowFallFX.c_bActive)
        {
            m_SlowFallFX.AttachToOwner(self);
            m_SlowFallFX.Activate();
        }
    }
    //return;    
}

simulated event StopSlowFallFx()
{
    // End:0x92
    if(m_SlowFallFX != none)
    {
        // End:0x51
        if(m_SlowFallFX.c_bActive)
        {
            m_SlowFallFX.Deactivate(true);
        }
        // End:0x92
        if(m_SlowFallFX.c_bAttached)
        {
            m_SlowFallFX.Detach();
        }
    }
    //return;    
}

event bool Died(Controller Killer, Class<DamageType> dmgType, Vector HitLocation)
{
    StopSlowFallFx();
    return super.Died(Killer, dmgType, HitLocation);
    //return ReturnValue;    
}

simulated function OnRespawn()
{
    super.OnRespawn();
    StopSlowFallFx();
    //return;    
}

simulated event Stun(bool bStunController, optional Controller.EStunType eType)
{
    local TgDevice netherStepDevice;
    local TgDeviceFire netherStepFire;

    super(TgPawn).Stun(bStunController, eType);
    // End:0xB5
    if(int(r_eCurrentStunType) != int(0))
    {
        netherStepDevice = GetDeviceById(12658);
        // End:0xB5
        if(netherStepDevice != none)
        {
            netherStepFire = netherStepDevice.GetCurrentFire();
            // End:0xB5
            if(netherStepFire != none)
            {
                netherStepFire.RemoveHitSpecial(self, true);
            }
        }
    }
    //return;    
}

defaultproperties
{
    m_fAccursedArmSpeedModifier=1.0000000
    m_fDefianceAirControl=0.1200000
    m_fAirHangGravityModifier=0.2000000
    m_fJumpHoldMaxFallSpeed=185.0000000
    m_nAccursedArmActiveFX=7135
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Androxus.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Androxus.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_bCanChargeInAir=true
    m_bAirAccuracyPenalty=false
    m_sGameplayPackage="Androxus"
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Androxus.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    c_fFxScaleSize=1.2000000
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Androxus.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Androxus.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Androxus.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Androxus.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Androxus.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Androxus.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}