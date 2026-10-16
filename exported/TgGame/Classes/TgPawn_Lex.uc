class TgPawn_Lex extends TgPawn_Character
    native(ChampLex)
    config(Game)
    hidecategories(Navigation);

const MAX_THE_LAW_TARGETS = 5;

enum ETheLawTargetState
{
    ETLTS_WontExecute,              // 0
    ETLTS_WillExecute,              // 1
    ETLTS_Firing,                   // 2
    ETLTS_MAX                       // 3
};

var TgDevice_Vengeance_Lex m_VengeanceDevice;
var TgDevice_CombatSlide m_CombatSlideDevice;
var TgDevice_InPursuit m_InPursuitDevice;
var TgWeaponMeshActor_LexInhand m_WeaponMeshActorLexInhand;
var init array<init TgPawn_Character> m_TargetList;
var TgPawn m_Target;
var float m_MaxSlideCameraAngle;
var int m_PrevCameraYaw;
var bool c_bUltFiring;
var bool c_bPursuitFiring;
var bool m_bFireLeftWeapon;
var repnotify TgPawn_Character r_Targets[5];
var repnotify TgPawn_Lex.ETheLawTargetState r_TargetStates[5];
var repnotify int r_nInhandAmmoRemaining;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && bNetDirty)
        r_TargetStates, r_Targets;

    // Pos:0x020
    if(int(Role) == int(ROLE_Authority))
        r_nInhandAmmoRemaining;
}

// Export UTgPawn_Lex::execIsFiringAtMarkShotMark(FFrame&, void* const)
native function bool IsFiringAtMarkShotMark();

// Export UTgPawn_Lex::execGlobalOnPlayerDied(FFrame&, void* const)
native function GlobalOnPlayerDied(TgPawn_Character Player);

// Export UTgPawn_Lex::execGetCachedVengeanceDevice(FFrame&, void* const)
native function TgDevice_Vengeance_Lex GetCachedVengeanceDevice();

// Export UTgPawn_Lex::execGetVengeanceLifesteal(FFrame&, void* const)
native function float GetVengeanceLifesteal(TgPawn Target);

// Export UTgPawn_Lex::execGetTargetActor(FFrame&, void* const)
native function Actor GetTargetActor();

// Export UTgPawn_Lex::execGetTurnRotatorOverride(FFrame&, void* const)
native function bool GetTurnRotatorOverride(out int nYawOffset);

simulated event ReplicatedEvent(name VarName)
{
    switch(VarName)
    {
        // End:0x2C
        case 'r_Targets':
            ManageBeams();
            // End:0x5B
            break;
        // End:0x45
        case 'r_nInhandAmmoRemaining':
            OnAmmoChange();
            // End:0x5B
            break;
        // End:0xFFFF
        default:
            super.ReplicatedEvent(VarName);
            break;
    }
    //return;    
}

event bool Died(Controller Killer, Class<DamageType> dmgType, Vector HitLocation)
{
    // End:0x55
    if(m_VengeanceDevice != none)
    {
        m_VengeanceDevice.SetMarkedPlayer(TgRepInfo_Player(Killer.PlayerReplicationInfo));
    }
    return super.Died(Killer, dmgType, HitLocation);
    //return ReturnValue;    
}

simulated event PostTimeLapse(bool bPlayOfTheGame)
{
    super(TgPawn).PostTimeLapse(bPlayOfTheGame);
    c_bUltFiring = false;
    c_bPursuitFiring = false;
    //return;    
}

simulated function OnRespawn()
{
    super.OnRespawn();
    c_bUltFiring = false;
    c_bPursuitFiring = false;
    //return;    
}

simulated function InterceptInputDeltaRotation(out Rotator rDeltaRotation)
{
    local int nNormalizedRot, nNormalizedChargeMin, nNormalizedChargeMax;

    // End:0x8A
    if(m_CombatSlideDevice == none)
    {
        m_CombatSlideDevice = TgDevice_CombatSlide(GetDeviceByClass(Class'TgGame.TgDevice_CombatSlide'));
        // End:0x8A
        if(m_CombatSlideDevice != none)
        {
            m_MaxSlideCameraAngle = m_CombatSlideDevice.GetCurrentFire().GetConeAttackAngle() * 182.0444000;
        }
    }
    // End:0x2DA
    if((m_CombatSlideDevice != none) && m_CombatSlideDevice.IsFiring())
    {
        nNormalizedRot = NormalizeRotAxis(Rotation.Yaw + rDeltaRotation.Yaw);
        nNormalizedChargeMin = NormalizeRotAxis(int(r_fChargeInitialYaw - m_MaxSlideCameraAngle));
        nNormalizedChargeMax = NormalizeRotAxis(int(r_fChargeInitialYaw + m_MaxSlideCameraAngle));
        // End:0x20E
        if(nNormalizedChargeMin < nNormalizedChargeMax)
        {
            // End:0x1C2
            if(nNormalizedRot < nNormalizedChargeMin)
            {
                rDeltaRotation.Yaw += (nNormalizedChargeMin - nNormalizedRot);                
            }
            else
            {
                // End:0x20B
                if(nNormalizedRot > nNormalizedChargeMax)
                {
                    rDeltaRotation.Yaw += (nNormalizedChargeMax - nNormalizedRot);
                }
            }            
        }
        else
        {
            // End:0x2DA
            if((nNormalizedRot < nNormalizedChargeMin) && nNormalizedRot > nNormalizedChargeMax)
            {
                // End:0x2A8
                if(Abs(float(nNormalizedChargeMin - nNormalizedRot)) < Abs(float(nNormalizedChargeMax - nNormalizedRot)))
                {
                    rDeltaRotation.Yaw += (nNormalizedChargeMin - nNormalizedRot);                    
                }
                else
                {
                    rDeltaRotation.Yaw += (nNormalizedChargeMax - nNormalizedRot);
                }
            }
        }
    }
    //return;    
}

simulated function OnAmmoChange()
{
    local TgDevice inhand;
    local TgDeviceForm_LexInhand LexInhandDeviceForm;

    inhand = GetDeviceByEqPoint(1);
    // End:0x83
    if(inhand != none)
    {
        LexInhandDeviceForm = TgDeviceForm_LexInhand(inhand.c_DeviceForm);
        // End:0x83
        if(LexInhandDeviceForm != none)
        {
            LexInhandDeviceForm.OnAmmoChange();
        }
    }
    //return;    
}

simulated function SetDualFireParity(bool bLeftFire)
{
    local TgDevice inhand;
    local TgDeviceForm_LexInhand LexInhandDeviceForm;

    inhand = GetDeviceByEqPoint(1);
    // End:0x8D
    if(inhand != none)
    {
        LexInhandDeviceForm = TgDeviceForm_LexInhand(inhand.c_DeviceForm);
        // End:0x8D
        if(LexInhandDeviceForm != none)
        {
            LexInhandDeviceForm.SetDualFireParity(bLeftFire);
        }
    }
    //return;    
}

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    switch(MountType)
    {
        // End:0x53
        case 1:
            return "PC_Lawman_Skin00A.Anims.AS_PC_Lawman_Skin00A_Mount_Horse";
        // End:0xFFFF
        default:
            return "";
            break;
    }
    //return ReturnValue;    
}

simulated event ManageBeams()
{
    local TgWeaponMeshActor_LexInhand InhandWeaponMesh;

    InhandWeaponMesh = TgWeaponMeshActor_LexInhand(m_WeaponMesh);
    // End:0x4A
    if(InhandWeaponMesh != none)
    {
        InhandWeaponMesh.ManageBeams();
    }
    //return;    
}

defaultproperties
{
    m_fMountZoomOverride=1.1000000
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Lex.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Lex.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_bUsesRecoil=true
    m_sGameplayPackage="Lex"
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Lex.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Lex.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Lex.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Lex.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Lex.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    BaseEyeHeight=45.0000000
    EyeHeight=45.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Lex.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Lex.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}