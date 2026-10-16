class TgPawn_Astro extends TgPawn_Character
    native(ChampAstro)
    config(Game)
    hidecategories(Navigation);

const DEVICE_LIGHT_SPEED = 19186;
const DEVICE_GRAVITY_LIFT = 19187;
const DEVICE_ASTRAL_MARK = 17178;
const CARD_ASTRAL_CYCLE = 0;
const CARD_STAR_SEEKER = 1;

var TgDevice_Lightspeed m_LightSpeedDevice;
var TgDevice_AstroQ m_GravityLiftDevice;
var TgDevice_AstralMark m_AstralMarkDevice;
var TgDevice_AstralCycle m_AstralCycleCard;
var TgDevice_StarSeeker m_StarSeekerCard;
var TgPawn_Character m_AstralTarget;
var TgPawn_Character m_GravityLiftTarget;
var TgPawn_Character m_HitGravityLiftTarget;
var repnotify TgRepInfo_Player r_HitAstralTarget;
var repnotify TgRepInfo_Player r_RemoveAstralTarget;
var array<TgRepInfo_Player> m_AstralMarkTargets;
var float m_fDeadSpaceTimer;
var bool m_bDeadSpaceTimerActive;
var Rotator r_mUltimateAimRotation;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && bNetDirty)
        r_HitAstralTarget, r_RemoveAstralTarget, 
        r_mUltimateAimRotation;
}

simulated event ReplicatedEvent(name VarName)
{
    switch(VarName)
    {
        // End:0x2C
        case 'r_HitAstralTarget':
            AddAstralMarkTarget();
            // End:0x5B
            break;
        // End:0x45
        case 'r_RemoveAstralTarget':
            RemoveAstralMarkTarget();
            // End:0x5B
            break;
        // End:0xFFFF
        default:
            super.ReplicatedEvent(VarName);
            break;
    }
    //return;    
}

// Export UTgPawn_Astro::execHasDeviceCached(FFrame&, void* const)
native function bool HasDeviceCached(int DeviceID);

// Export UTgPawn_Astro::execAllowBoostedJump(FFrame&, void* const)
native function bool AllowBoostedJump();

// Export UTgPawn_Astro::execCanKnockbackAffectAC(FFrame&, void* const)
native function bool CanKnockbackAffectAC();

// Export UTgPawn_Astro::execGlobalOnPlayerDied(FFrame&, void* const)
native function GlobalOnPlayerDied(TgPawn_Character Player);

// Export UTgPawn_Astro::execOnPawnDied(FFrame&, void* const)
native function OnPawnDied();

// Export UTgPawn_Astro::execEffectGroupOnSetActive(FFrame&, void* const)
native function EffectGroupOnSetActive(bool bActive, bool bRemoving, TgEffectGroup EffectGroup);

// Export UTgPawn_Astro::execGetGravityZ(FFrame&, void* const)
native function float GetGravityZ();

// Export UTgPawn_Astro::execShouldBeFirstPersonThisTick(FFrame&, void* const)
native function bool ShouldBeFirstPersonThisTick();

// Export UTgPawn_Astro::execGetAirControl(FFrame&, void* const)
native function float GetAirControl();

// Export UTgPawn_Astro::execAddAstralMarkTarget(FFrame&, void* const)
native function AddAstralMarkTarget();

// Export UTgPawn_Astro::execRemoveAstralMarkTarget(FFrame&, void* const)
native function RemoveAstralMarkTarget();

simulated function float GetJumpSpeedMultiplier()
{
    local TgDeviceFire pFireMode;
    local TgDevice pSpaceJamCard;

    // End:0xB8
    if(HasDeviceCached(19186))
    {
        // End:0xB8
        if(m_LightSpeedDevice.IsFiring())
        {
            pSpaceJamCard = GetDeviceByClass(Class'TgGame.TgDevice_SpaceJam');
            // End:0xB8
            if(pSpaceJamCard != none)
            {
                pFireMode = pSpaceJamCard.GetCurrentFire();
                // End:0xB8
                if(pFireMode != none)
                {
                    return pFireMode.GetCustomValue1();
                }
            }
        }
    }
    return 1.0000000;
    //return ReturnValue;    
}

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    switch(MountType)
    {
        // End:0x51
        case 1:
            return "PC_Astro_Skin00A.Anims.AS_PC_Astro_Skin00A_Mount_Horse";
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
    // End:0x5F
    if(HasDeviceCached(19186))
    {
        // End:0x5F
        if(m_LightSpeedDevice.IsFiring())
        {
            fZoom = 1.5000000;
        }
    }
    //return;    
}

defaultproperties
{
    m_fMountZoomOverride=1.2500000
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Astro.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Astro.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_bUsesRecoil=true
    m_sGameplayPackage="Astro"
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Astro.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    c_fFxScaleSize=0.9500000
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Astro.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Astro.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Astro.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Astro.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    BaseEyeHeight=50.0000000
    EyeHeight=50.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Astro.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Astro.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}