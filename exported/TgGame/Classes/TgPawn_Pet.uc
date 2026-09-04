class TgPawn_Pet extends TgPawn
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

var float m_fOwnerPhysPowerItemPercent;
var float m_fOwnerMagicalPowerItemPercent;
var float m_fOwnerUltilityPowerItemPercent;
var TgObject.EPetPhase s_PetPhase;
var TgObject.EPetPosition s_PetPosition;
var Rotator s_LastPositionAdjustmentRotation;
var Vector s_InterpolatedPetPosition;
var Vector s_InterpolatedPetOwnerPosition;
var float s_fPetPositionDistanceMultiplier;
var float s_fOwnerVelocityTime;
var float s_fSmoothedMaxSpeed;
var transient TgSpecialFx c_BeamFX;
var repnotify Rotator r_InitialOrientation;
var export editinline ParticleSystemComponent c_AimVisibilityMesh;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_InitialOrientation;
}

// Export UTgPawn_Pet::execGetPhysicalPowerItem(FFrame&, void* const)
native function float GetPhysicalPowerItem();

// Export UTgPawn_Pet::execGetMagicalPowerItem(FFrame&, void* const)
native function float GetMagicalPowerItem();

// Export UTgPawn_Pet::execGetUtilityPowerItem(FFrame&, void* const)
native function float GetUtilityPowerItem();

// Export UTgPawn_Pet::execIsDamageOverTimeImmune(FFrame&, void* const)
native function bool IsDamageOverTimeImmune();

// Export UTgPawn_Pet::execGetGiantCollisionCylinderSize(FFrame&, void* const)
native function GetGiantCollisionCylinderSize(out float Radius, out float Height);

// Export UTgPawn_Pet::execGetSmallCollisionCylinderSize(FFrame&, void* const)
native function GetSmallCollisionCylinderSize(out float Radius, out float Height);

// Export UTgPawn_Pet::execCorrectLocationWhileChangingSize(FFrame&, void* const)
native function CorrectLocationWhileChangingSize(float HeightDelta);

// Export UTgPawn_Pet::execGetDefaultMeshScale(FFrame&, void* const)
native function float GetDefaultMeshScale();

// Export UTgPawn_Pet::execDirtyAttachmentTransforms(FFrame&, void* const)
native function DirtyAttachmentTransforms();

// Export UTgPawn_Pet::execCanSeeActor(FFrame&, void* const)
native function bool CanSeeActor(Actor Other);

// Export UTgPawn_Pet::execDeviceOnStopFire(FFrame&, void* const)
native function DeviceOnStopFire(TgDevice Dev, optional bool WasInterrupted);

// Export UTgPawn_Pet::execDeviceOnKilled(FFrame&, void* const)
native function DeviceOnKilled(TgDevice Dev, const out ImpactInfo Impact, float fDamage);

// Export UTgPawn_Pet::execDeviceAdjustDamage(FFrame&, void* const)
native function DeviceAdjustDamage(out AdjustDamageParams Params, out float fDamage);

// Export UTgPawn_Pet::execDeviceOnDamaged(FFrame&, void* const)
native function DeviceOnDamaged(out OnDamagedParams Params);

// Export UTgPawn_Pet::execDeviceOnHit(FFrame&, void* const)
native function DeviceOnHit(TgDevice Dev, const out ImpactInfo Impact);

function PossessedBy(Controller C, bool bVehicleTransition)
{
    local TgAIController aic;

    super.PossessedBy(C, bVehicleTransition);
    aic = TgAIController(C);
    // End:0x6C
    if(aic != none)
    {
        aic.SeePawnClearTime = 0.5000000;
    }
    //return;    
}

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    r_InitialOrientation = Rotation;
    // End:0x66
    if((int(Role) == int(ROLE_Authority)) && int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        SetAimVisibilityMesh();
    }
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    switch(VarName)
    {
        // End:0x2C
        case 'r_InitialOrientation':
            SetAimVisibilityMesh();
            // End:0x2F
            break;
        // End:0xFFFF
        default:
            break;
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

simulated function SetAimVisibilityMesh()
{
    local Vector translationOffset;
    local bool bIsFriendly;
    local ParticleChannelContainer PSysChannels;

    bIsFriendly = IsFriendlyWithLocalPawn();
    translationOffset = vect(0.0000000, 0.0000000, 0.0000000);
    translationOffset.Z -= (GetCollisionHeight());
    PSysChannels.Friendly = bIsFriendly;
    PSysChannels.Enemy = !PSysChannels.Friendly;
    // End:0x182
    if(c_AimVisibilityMesh != none)
    {
        c_AimVisibilityMesh.m_ParticleChannels = PSysChannels;
        c_AimVisibilityMesh.ActivateSystem();
        c_AimVisibilityMesh.SetAbsolute(false, true, false);
        c_AimVisibilityMesh.SetRotation(r_InitialOrientation);
        c_AimVisibilityMesh.SetTranslation(translationOffset);
    }
    //return;    
}

function bool ShouldScoreKill()
{
    return false;
    //return ReturnValue;    
}

simulated function PlayDyingEffects()
{
    super.PlayDyingEffects();
    // End:0x35
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    // End:0x63
    if(c_AimVisibilityMesh != none)
    {
        c_AimVisibilityMesh.DeactivateSystem();
    }
    //return;    
}

simulated function PlayDeathAnimation()
{
    super.PlayDeathAnimation();
    c_bMeshHiddenDueToDeath = true;
    //return;    
}

defaultproperties
{
    m_fOwnerPhysPowerItemPercent=1.0000000
    m_fOwnerMagicalPowerItemPercent=1.0000000
    m_fOwnerUltilityPowerItemPercent=1.0000000
    s_fPetPositionDistanceMultiplier=1.5000000
    c_bUpdatesWeaponMesh=true
    m_bCanBeKnockedBack=false
    m_bIgnoreTearOffMomentum=true
    m_bUseOutlines=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Pet.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Pet.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Pet.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Pet.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Pet.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    m_nSuccessfulHitSpecialFXId=4438
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Pet.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Pet.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    CollisionComponent=CollisionCylinder
    RotationRate=(Pitch=0,Yaw=40000,Roll=2048)
}