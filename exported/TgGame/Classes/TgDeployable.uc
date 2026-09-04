class TgDeployable extends Actor
    native(Deployable)
    nativereplication
    notplaceable
    hidecategories(Navigation)
    implements(TgSkinnableInterface,TgCombatActor,TgObserver_ViewTargetChanged,TgInteractiveAudio,TgGameplayCurveOwner);

enum AdvancedCollisionMode
{
    ACM_None,                       // 0
    ACM_Shield,                     // 1
    ACM_Geometry,                   // 2
    ACM_MAX                         // 3
};

struct native CollisionSettingsDeployable
{
    var const TgDeployable.AdvancedCollisionMode mCollisionMode;
    var const bool bUseMeshForCollision;
    var const bool bPawnsCanBaseOnMe;
    var bool bAutoRegisterObstacle;
    var bool bHasRegisteredObstacle;
    var bool bOnlyBlockShotsFromFront;
    var bool bBlockFriendlyFire;
    var float fProjectileAllowanceRadius;
    var float fExplosionAllowanceRadius;

    structdefaultproperties
    {
        mCollisionMode=AdvancedCollisionMode.ACM_None
        bUseMeshForCollision=false
        bPawnsCanBaseOnMe=false
        bAutoRegisterObstacle=false
        bHasRegisteredObstacle=false
        bOnlyBlockShotsFromFront=false
        bBlockFriendlyFire=false
        fProjectileAllowanceRadius=0.0000000
        fExplosionAllowanceRadius=0.0000000
    }
};

var private native const noexport Pointer VfTable_ITgSkinnableInterface;
var private native const noexport Pointer VfTable_ITgCombatActor;
var private native const noexport Pointer VfTable_ITgObserver_ViewTargetChanged;
var private native const noexport Pointer VfTable_ITgInteractiveAudio;
var private native const noexport Pointer VfTable_ITgGameplayCurveOwner;
var repnotify int r_nDeployableId;
var int r_nSkinId;
var int r_nWeaponSkinId;
var bool c_bInitialized;
var bool m_bConsumedOnFire;
var bool m_bFireOnDeploy;
var bool m_bHasAlreadyFiredOnce;
var bool m_bInstantFire;
var bool c_bMinimapOnlyOwnerSee;
var bool r_bTakeDamage;
var bool m_bInDestroyedState;
var bool s_bDestroyedThisTick;
var bool m_bIsDeployed;
var bool c_bEnemyMatLoaded;
var bool m_bDestroyOnOwnerDeathFlag;
var bool m_bDestroyAfterRoundEnds;
var bool m_bAdjustMeshToGround;
var const bool m_bIsVisionBlocker;
var const bool m_bIsAIVisionBlocker;
var const bool m_bMovableProjBlocker;
var const bool m_bDeviceUsedIsHandDevice;
var bool m_bUseSilhouettesOverride;
var(TagetComponent) bool m_bOverrideTargetComponentHeight;
var repnotify bool r_bInitialIsEnemy;
var protected transient bool c_bIsSpectateToggleActive;
var bool m_bUseRangeFalloffCurve;
var int m_nDeployableType;
var int r_nPhysicalType;
var repnotify int r_nHealth;
var TgEffectManager r_EffectManager;
var array<TgEffectGroup> m_EquipEffects;
var array<TgProperty> s_Properties;
var TgDeviceForm c_Form;
var TgSpecialFx c_FireFx;
var export editinline MeshComponent c_Mesh;
var repnotify Vector r_vFlashLocation;
var repnotify byte r_nFlashCount;
var repnotify byte r_nFlashFireCount;
var byte c_nPreviousFlashFireCount;
var const TgObject.DeployableOverlayIcon m_InitHUDOverlayIcon;
var const TgObject.DeployableOverlayState m_InitHUDOverlayState;
var TgDeviceFire m_FireMode;
var float m_fStateTime;
var int c_nVisibleToLocalPlayer[2];
var TgActorFactory s_DeployFactory;
var int m_TimeCreated;
var export editinline MeshComponent m_DestroyedMesh;
var float m_fLifeAfterDeathSecs;
var repnotify int r_nReplicateDestroyIt;
var TgInteractiveAudio m_AsInteractiveAudio;
var float s_fPersistTime;
var const export editinline DynamicLightEnvironmentComponent LightEnvironment;
var repnotify float r_fTimeToDeploySecs;
var repnotify float r_fInitDeployTime;
var float m_fCurrentDeployPercentage;
var float r_fCurrentDeployTime;
var float m_fDamagedDuringDeploy;
var TgDeviceFire s_SpawnerDeviceMode;
var TgDevice r_Owner;
var int r_nOwnerFireMode;
var float AlwaysRelevantDistanceSquared;
var float m_fMaxAimAssistStacks;
var CollisionSettingsDeployable m_CollisionSettings;
var array<TgPawn> m_PawnsBasedOnMe;
var TgSilhouetteManager m_SilhouetteManager;
var const int m_nInitHUDOverlayDisplayMask;
var const float m_InitHUDOverlayEnemyViewDist;
var() float m_fHUDOverlayZOffset;
var native const Pointer m_pAmSkin;
var native const Pointer m_pAmWeaponSkin;
var(TargetComponent) export editinline CylinderComponent m_TargetComponent;
var(TargetComponent) float m_TargetCollisionTraceDistance;
var(TagetComponent) float m_fOverriddenTargetComponentHeight;
var TgPawn m_LastDamager;
var int m_LastDamagerTimeStamp;
var repnotify TgRepInfo_Deployable r_DRI;
var TgPlayerController c_LocalPC;
var Class<Actor> m_DRIClass;
var float m_fDisableSpectatorFxTime;
var transient float m_fDisableSpectatorFxTimeRemaining;
var TgGameplayCurves m_GameplayCurves;
var TgAkActorUnoccluded m_AkActorUnoccluded;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_EffectManager, r_fInitDeployTime, 
        r_fTimeToDeploySecs, r_nFlashCount, 
        r_nFlashFireCount, r_nHealth, 
        r_vFlashLocation;

    // Pos:0x011
    if(int(Role) == int(ROLE_Authority))
        r_nReplicateDestroyIt;

    // Pos:0x022
    if((int(Role) == int(ROLE_Authority)) && bNetDirty)
        r_bTakeDamage;

    // Pos:0x042
    if((int(Role) == int(ROLE_Authority)) && bNetInitial)
        r_DRI, r_bInitialIsEnemy, 
        r_fCurrentDeployTime, r_nDeployableId, 
        r_nPhysicalType, r_nSkinId;

    // Pos:0x062
    if((int(Role) == int(ROLE_Authority)) && bNetOwner)
        r_Owner, r_nOwnerFireMode;
}

// Export UTgDeployable::execApplyDeployableSetup(FFrame&, void* const)
native function bool ApplyDeployableSetup();

// Export UTgDeployable::execInitializeDefaultProps(FFrame&, void* const)
native function InitializeDefaultProps();

// Export UTgDeployable::execAddProperty(FFrame&, void* const)
native function AddProperty(int nPropId, float fBase, float fRaw, float FMin, float FMax);

// Export UTgDeployable::execGetProperty(FFrame&, void* const)
native function TgProperty GetProperty(int nPropertyId);

// Export UTgDeployable::execSetProperty(FFrame&, void* const)
native function SetProperty(int nPropertyId, float fNewValue);

// Export UTgDeployable::execResetProperties(FFrame&, void* const)
native function ResetProperties();

// Export UTgDeployable::execSwapMeshToDestroyed(FFrame&, void* const)
native function SwapMeshToDestroyed();

// Export UTgDeployable::execDeployableDestroyed(FFrame&, void* const)
native function DeployableDestroyed();

// Export UTgDeployable::execGetMaxDeployHealth(FFrame&, void* const)
native function int GetMaxDeployHealth();

// Export UTgDeployable::execNotifyGroupChanged(FFrame&, void* const)
native function NotifyGroupChanged();

// Export UTgDeployable::execForceRecalculateMaterial(FFrame&, void* const)
native function ForceRecalculateMaterial();

// Export UTgDeployable::execRecalculateMaterial(FFrame&, void* const)
native function RecalculateMaterial(bool bIsFriendlyWithLocalPawn, optional bool bForce);

// Export UTgDeployable::execAdjustMeshToGround(FFrame&, void* const)
native function AdjustMeshToGround();

// Export UTgDeployable::execCalcMeshOffset(FFrame&, void* const)
native function float CalcMeshOffset();

// Export UTgDeployable::execUpdateTargetCylinder(FFrame&, void* const)
native function UpdateTargetCylinder();

// Export UTgDeployable::execUpdateDamagers(FFrame&, void* const)
native function UpdateDamagers(TgPawn Damager);

// Export UTgDeployable::execSetInitialHealthPercent(FFrame&, void* const)
native function SetInitialHealthPercent(float fPercent);

// Export UTgDeployable::execGetTaskForce(FFrame&, void* const)
native final function TgRepInfo_TaskForce GetTaskForce();

// Export UTgDeployable::execGetTaskForceNumber(FFrame&, void* const)
native final function int GetTaskForceNumber();

// Export UTgDeployable::execSetTaskForceNumber(FFrame&, void* const)
native function SetTaskForceNumber(int nTaskForceId);

// Export UTgDeployable::execGetSpawnerDeviceInstanceId(FFrame&, void* const)
native function int GetSpawnerDeviceInstanceId();

// Export UTgDeployable::execGetSpawnerDeviceId(FFrame&, void* const)
native function int GetSpawnerDeviceId();

// Export UTgDeployable::execIsFriendlyWithLocalPawn(FFrame&, void* const)
native function bool IsFriendlyWithLocalPawn();

// Export UTgDeployable::execUpdateHealth(FFrame&, void* const)
native function UpdateHealth();

// Export UTgDeployable::execIsInvisibleToAI(FFrame&, void* const)
native function bool IsInvisibleToAI(optional Actor TestActor);

// Export UTgDeployable::execIsHittable(FFrame&, void* const)
native function bool IsHittable();

// Export UTgDeployable::execGetHudOverlayLocation(FFrame&, void* const)
native function Vector GetHudOverlayLocation(optional bool bCentered = false);

// Export UTgDeployable::execAdjustHeal(FFrame&, void* const)
native function AdjustHeal(const out ImpactInfo Impact, out float fHeal, int nPropertyId);

// Export UTgDeployable::execPostAkEvent(FFrame&, void* const)
native function PostAkEvent(AkEvent InAkEvent);

// Export UTgDeployable::execRegisterObstacle(FFrame&, void* const)
native function RegisterObstacle();

// Export UTgDeployable::execUnRegisterObstacle(FFrame&, void* const)
native function UnRegisterObstacle();

// Export UTgDeployable::execGetHealth(FFrame&, void* const)
native function float GetHealth();

// Export UTgDeployable::execGetMaxHealth(FFrame&, void* const)
native function float GetMaxHealth();

// Export UTgDeployable::execGetHealthPercent(FFrame&, void* const)
native function float GetHealthPercent();

// Export UTgDeployable::execGetMana(FFrame&, void* const)
native function float GetMana();

// Export UTgDeployable::execGetMaxMana(FFrame&, void* const)
native function float GetMaxMana();

// Export UTgDeployable::execGetShieldHealth(FFrame&, void* const)
native function float GetShieldHealth();

// Export UTgDeployable::execGetMaxShield(FFrame&, void* const)
native function float GetMaxShield();

// Export UTgDeployable::execCanTakeHealthDamage(FFrame&, void* const)
native function bool CanTakeHealthDamage();

// Export UTgDeployable::execCanDealHeadShots(FFrame&, void* const)
native function bool CanDealHeadShots();

// Export UTgDeployable::execCanTakeHeadShots(FFrame&, void* const)
native function bool CanTakeHeadShots();

// Export UTgDeployable::execOnlyTakeHeadShots(FFrame&, void* const)
native function bool OnlyTakeHeadShots();

// Export UTgDeployable::execIsImmuneToDamage(FFrame&, void* const)
native function bool IsImmuneToDamage();

// Export UTgDeployable::execCanBeExecuted(FFrame&, void* const)
native function bool CanBeExecuted();

// Export UTgDeployable::execIsImmuneToHealing(FFrame&, void* const)
native function bool IsImmuneToHealing();

// Export UTgDeployable::execBuffDamage(FFrame&, void* const)
native function BuffDamage(Actor Target, TgEffectDamage Effect, ImpactInfo Impact, float fBaseDamage, out float fProratedAmount, out ExtraDamageInfo ExtraInfo);

// Export UTgDeployable::execGetSpecialDamageDealtPercentAI(FFrame&, void* const)
native function float GetSpecialDamageDealtPercentAI();

// Export UTgDeployable::execGetSpecialDamageTakenPercentAI(FFrame&, void* const)
native function float GetSpecialDamageTakenPercentAI();

// Export UTgDeployable::execMitigateHealthDamage(FFrame&, void* const)
native function MitigateHealthDamage(TgPawn pInstigator, TgEffectDamage Effect, ImpactInfo Impact, out float NewValue, out float fPercReduction);

// Export UTgDeployable::execGetDamageReductionPerc(FFrame&, void* const)
native function float GetDamageReductionPerc(TgDevice damageDev, TgEffectGroup eg);

// Export UTgDeployable::execTakeHealthDamage(FFrame&, void* const)
native function TakeHealthDamage(float fDamage, Controller InstigatedBy, Class<DamageType> DamageType, ImpactInfo Impact, ExtraDamageInfo ExtraInfo, optional Actor DamageCauser);

// Export UTgDeployable::execCanBeLifestealInstigator(FFrame&, void* const)
native function bool CanBeLifestealInstigator();

// Export UTgDeployable::execCanBeLifestealTarget(FFrame&, void* const)
native function bool CanBeLifestealTarget();

// Export UTgDeployable::execCanTakeManaDamage(FFrame&, void* const)
native function bool CanTakeManaDamage();

// Export UTgDeployable::execTakeManaDamage(FFrame&, void* const)
native function TakeManaDamage(float fDamage, Controller InstigatedBy, Class<DamageType> DamageType, ImpactInfo Impact, ExtraDamageInfo ExtraInfo, optional Actor DamageCauser);

// Export UTgDeployable::execCanTakeShieldDamage(FFrame&, void* const)
native function bool CanTakeShieldDamage();

// Export UTgDeployable::execCanUsePersonalShield(FFrame&, void* const)
native function bool CanUsePersonalShield();

// Export UTgDeployable::execTakePersonalShieldDamage(FFrame&, void* const)
native function int TakePersonalShieldDamage(float fDamage, Controller InstigatedBy, Class<DamageType> DamageType, ImpactInfo Impact, ExtraDamageInfo ExtraInfo, optional Actor DamageCauser);

// Export UTgDeployable::execShieldDamageAppliesToHealth(FFrame&, void* const)
native function bool ShieldDamageAppliesToHealth();

// Export UTgDeployable::execTakeStealthDamage(FFrame&, void* const)
native function TakeStealthDamage(float fDamage);

// Export UTgDeployable::execGetDamageToLeaveStealth(FFrame&, void* const)
native function float GetDamageToLeaveStealth();

// Export UTgDeployable::execHandleNotificationsForAI(FFrame&, void* const)
native function HandleNotificationsForAI(float fStatChange, TgPawn InstigatorPawn);

// Export UTgDeployable::execLocalPlayerHasLOS(FFrame&, void* const)
native function bool LocalPlayerHasLOS();

// Export UTgDeployable::execGetLocation(FFrame&, void* const)
native function Vector GetLocation();

// Export UTgDeployable::execGetPropCurrentValue(FFrame&, void* const)
native function float GetPropCurrentValue(int nPropIndex);

// Export UTgDeployable::execGetPropIndex(FFrame&, void* const)
native function int GetPropIndex(int nPropId);

// Export UTgDeployable::execGetMarkedPercent(FFrame&, void* const)
native function float GetMarkedPercent(Actor InstigatorPawn);

// Export UTgDeployable::execGetMarkedPercentInhand(FFrame&, void* const)
native function float GetMarkedPercentInhand(Actor InstigatorPawn);

// Export UTgDeployable::execOnViewTargetChanged(FFrame&, void* const)
native function OnViewTargetChanged(optional Actor aNewViewTarget);

// Export UTgDeployable::execGetEffectManager(FFrame&, void* const)
native function TgEffectManager GetEffectManager();

// Export UTgDeployable::execGetDesignType(FFrame&, void* const)
native function TgCombatActor.GameplayDesignType GetDesignType();

// Export UTgDeployable::execIsPet(FFrame&, void* const)
native function bool IsPet();

// Export UTgDeployable::execGetPetOwner(FFrame&, void* const)
native function Actor GetPetOwner();

// Export UTgDeployable::execGetCurrentGameplayCurveSet(FFrame&, void* const)
native function TgGameplayCurvesSet GetCurrentGameplayCurveSet(TgGameplayCurvesSet.ECurveSetTypes Type);

// Export UTgDeployable::execUseRangeFalloffCurve(FFrame&, void* const)
native function bool UseRangeFalloffCurve();

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    m_TimeCreated = int(WorldInfo.TimeSeconds);
    // End:0x5E
    if(int(Role) == int(ROLE_Authority))
    {
        m_LastDamager = none;
        m_LastDamagerTimeStamp = 0;
    }
    // End:0xBA
    if(int(Role) == int(ROLE_Authority))
    {
        r_nFlashFireCount++;
        InitializeDefaultProps();
        // End:0xBA
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            FlashFireCountUpdated();
        }
    }
    // End:0xED
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        NotifyGroupChanged();
    }
    //return;    
}

simulated function NotifyLocalPlayerTeamReceived()
{
    NotifyGroupChanged();
    //return;    
}

simulated event int GetDeployableUniqueId()
{
    // End:0x31
    if(r_DRI != none)
    {
        return r_DRI.r_nUniqueDeployableId;        
    }
    else
    {
        return 0;
    }
    //return ReturnValue;    
}

simulated function Actor GetActorFromCombatActor()
{
    return self;
    //return ReturnValue;    
}

simulated function GetAimAssistBounds(const out Vector ObserverLocation, out float Width, out float Height, out Vector Center)
{
    GetAimFrictionExtent(Width, Height, Center);
    //return;    
}

event ApplyEquipEffects()
{
    local int I;

    // End:0x11
    if(r_EffectManager == none)
    {
        return;
    }
    // End:0x87
    if(m_EquipEffects.Length > 0)
    {
        I = 0;
        J0x2C:

        // End:0x87 [Loop If]
        if(I < m_EquipEffects.Length)
        {
            r_EffectManager.ProcessEffect(m_EquipEffects[I], self);
            I++;
            // [Loop Continue]
            goto J0x2C;
        }
    }
    //return;    
}

simulated function OnGetTaskForceNumber(TgSeqAct_GetTaskForceNumber Action)
{
    SeqVar_Int(Action.VariableLinks[1].LinkedVariables[0]).IntValue = GetTaskForceNumber();
    //return;    
}

simulated event StartFire()
{
    // End:0x11
    if(m_FireMode == none)
    {
        return;
    }
    // End:0x31
    if(m_bInDestroyedState && !s_bDestroyedThisTick)
    {
        return;
    }
    // End:0x40
    if(IsFiring())
    {
        return;
    }
    r_nFlashFireCount++;
    GotoState('DeviceBuildup');
    // End:0x8C
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        FlashFireCountUpdated();
    }
    //return;    
}

simulated event StopFire()
{
    // End:0x1B
    if(IsFiring())
    {
        GotoState('Active');
    }
    //return;    
}

simulated function DeviceFired()
{
    // End:0x2B
    if(m_bConsumedOnFire && s_fPersistTime == float(0))
    {
        DestroyIt();
    }
    //return;    
}

simulated function ImpactInfo CalcDeviceFire(Vector StartTrace, Vector EndTrace, optional out array<ImpactInfo> ImpactList)
{
    local ImpactInfo CurrentImpact;
    local AimData Aim;

    Aim.StartTrace = StartTrace;
    Aim.EndTrace = EndTrace;
    Aim.AimVector = Vector(Rotation);
    // End:0xCE
    if(m_FireMode != none)
    {
        return m_FireMode.CalcWeaponModeFire(self, Aim, ImpactList).Impact;
    }
    return CurrentImpact;
    //return ReturnValue;    
}

function InstantFireDeployable()
{
    local array<ImpactInfo> ImpactList;
    local ImpactInfo RealImpact;
    local Vector EndTrace, StartLoc, AimDir;

    StartLoc = GetPhysicalFireStartLoc();
    SetFlashLocation(StartLoc);
    AimDir = GetPhysicalFireAimDirection(StartLoc, Location);
    EndTrace = StartLoc + (m_FireMode.GetRange() * AimDir);
    RealImpact = CalcDeviceFire(StartLoc, EndTrace, ImpactList);
    SetFlashLocation(RealImpact.HitLocation);
    ApplyHit(ImpactList);
    //return;    
}

simulated function ApplyHit(out array<ImpactInfo> ImpactList)
{
    local int Idx;

    Idx = 0;
    J0x0B:

    // End:0x90 [Loop If]
    if(Idx < ImpactList.Length)
    {
        // End:0x82
        if(ImpactList[Idx].HitActor != none)
        {
            m_FireMode.ApplyHit(ImpactList[Idx], self);
        }
        Idx++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

function Projectile ProjectileFireDeployable()
{
    local Vector StartLoc, AimDir;
    local Projectile Proj;
    local Class<Projectile> projClass;

    // End:0x3CB
    if((int(Role) == int(ROLE_Authority)) && m_FireMode != none)
    {
        StartLoc = GetPhysicalFireStartLoc();
        SetFlashLocation(StartLoc);
        AimDir = GetPhysicalFireAimDirection(StartLoc, Location);
        projClass = m_FireMode.GetProjectileClass();
        // End:0xAC
        if(projClass == none)
        {
            return none;
        }
        // End:0x20E
        if(ClassIsChildOf(projClass, Class'TgGame.TgProj_Simulated'))
        {
            Proj = TgRepInfo_Game(WorldInfo.GRI).SpawnSimulatedProjectile(TgGame(WorldInfo.Game).GetNextProjectileInstanceId(), m_FireMode.m_nId, Instigator, StartLoc, AimDir);
            // End:0x194
            if(Proj == none)
            {
                return none;
            }
            TgProjectile(Proj).m_OwnerFireMode = m_FireMode;
            TgProjectile(Proj).r_vSpawnLocation = Proj.Location;            
        }
        else
        {
            Proj = Spawn(projClass, none,, StartLoc, Rotator(AimDir));
            // End:0x399
            if((Proj != none) && !Proj.bDeleteMe)
            {
                TgProjectile(Proj).r_Owner = self;
                TgProjectile(Proj).r_nOwnerFireModeId = m_FireMode.m_nId;
                TgProjectile(Proj).m_OwnerFireMode = m_FireMode;
                TgProjectile(Proj).r_vSpawnLocation = StartLoc;
                m_FireMode.InitializeProjectile(Proj);
                Proj.Init(AimDir);
            }
        }
        TgProjectile(Proj).CompleteInitialization();
        return Proj;
    }
    return none;
    //return ReturnValue;    
}

simulated function Vector GetPhysicalFireStartLoc()
{
    return Location;
    //return ReturnValue;    
}

simulated function Vector GetPhysicalFireAimDirection(Vector fireLoc, Vector TargetLocation)
{
    return Normal(TargetLocation - fireLoc);
    //return ReturnValue;    
}

function FireAmmunitionDeployable()
{
    local int nNumShots, I;

    // End:0x0F
    if(bTearOff)
    {
        return;
    }
    nNumShots = m_FireMode.m_nShotsPerFire;
    I = 0;
    J0x42:

    // End:0x8B [Loop If]
    if(I < nNumShots)
    {
        // End:0x73
        if(m_bInstantFire)
        {
            InstantFireDeployable();            
        }
        else
        {
            ProjectileFireDeployable();
        }
        I++;
        // [Loop Continue]
        goto J0x42;
    }
    m_FireMode.ApplyEffectType(self, 10030);
    // End:0xED
    if(s_DeployFactory != none)
    {
        s_DeployFactory.TriggerEventClass(Class'TgGame.TgSeqEvent_DeployableFired', self, 0, false);
    }
    r_nFlashFireCount++;
    //return;    
}

simulated function IncrementFlashCount()
{
    bForceNetUpdate = true;
    r_nFlashCount++;
    // End:0x38
    if(int(r_nFlashCount) == int(0))
    {
        r_nFlashCount += 2;
    }
    // End:0x56
    if(int(Role) == int(ROLE_Authority))
    {
        FlashCountUpdated();
    }
    //return;    
}

simulated function ClearFlashCount()
{
    // End:0x4A
    if(int(r_nFlashCount) != int(0))
    {
        bForceNetUpdate = true;
        r_nFlashCount = 0;
        // End:0x4A
        if(int(Role) == int(ROLE_Authority))
        {
            FlashCountUpdated();
        }
    }
    //return;    
}

function SetFlashLocation(Vector NewLoc)
{
    // End:0x2F
    if(NewLoc == r_vFlashLocation)
    {
        NewLoc += vect(0.0000000, 0.0000000, 1.0000000);
    }
    // End:0x61
    if(NewLoc == vect(0.0000000, 0.0000000, 0.0000000))
    {
        NewLoc = vect(0.0000000, 0.0000000, 1.0000000);
    }
    bForceNetUpdate = true;
    r_vFlashLocation = NewLoc;
    // End:0xB3
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        FlashLocationUpdated();
    }
    //return;    
}

function ClearFlashLocation()
{
    // End:0x67
    if(!IsZero(r_vFlashLocation))
    {
        bForceNetUpdate = true;
        r_vFlashLocation = vect(0.0000000, 0.0000000, 0.0000000);
        // End:0x67
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            FlashLocationUpdated();
        }
    }
    //return;    
}

simulated event PlayFireFx()
{
    // End:0x6C
    if(c_FireFx != none)
    {
        c_FireFx.SpawnEmitter(Location, Vector(Rotation));
        c_FireFx.SpawnSound(Location);
    }
    //return;    
}

simulated function FlashCountUpdated()
{
    // End:0xA0
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        // End:0x72
        if(int(r_nFlashCount) > int(0))
        {
            // End:0x6F
            if(c_Form != none)
            {
                c_Form.BuildUp(0);
            }            
        }
        else
        {
            // End:0xA0
            if(c_Form != none)
            {
                c_Form.BeginActive();
            }
        }
    }
    //return;    
}

simulated function FlashLocationUpdated()
{
    // End:0x91
    if(!IsZero(r_vFlashLocation))
    {
        // End:0x8E
        if(c_Form != none)
        {
            // End:0x5D
            if(m_bInstantFire)
            {
                c_Form.Fire(r_vFlashLocation, 0, 0);                
            }
            else
            {
                c_Form.Fire(vect(0.0000000, 0.0000000, 0.0000000), 0, 0);
            }
        }        
    }
    else
    {
        // End:0xC3
        if(c_Form != none)
        {
            c_Form.BuildUp(0);
        }
    }
    //return;    
}

simulated function FlashFireCountUpdated()
{
    // End:0x1E
    if(int(c_nPreviousFlashFireCount) != int(0))
    {
        PlayFireFx();
    }
    c_nPreviousFlashFireCount = r_nFlashFireCount;
    // End:0x98
    if(c_Mesh != none)
    {
        c_Mesh.FxDeactivateGroup('Fire', 0);
        c_Mesh.FxActivateGroup('Fire', 0);
    }
    //return;    
}

simulated function bool IsFiring()
{
    return false;
    //return ReturnValue;    
}

simulated function TimeDeviceFiring()
{
    // End:0x46
    if(!IsTimerActive('RefireCheckTimer'))
    {
        SetTimer(m_FireMode.GetRefireTime(), true, 'RefireCheckTimer');
    }
    //return;    
}

simulated event StartDeploy()
{
    local editinline SkeletalMeshComponent SkelComp;

    // End:0xA2
    if(!m_bIsDeployed)
    {
        GotoState('Deploy');
        SkelComp = SkeletalMeshComponent(c_Mesh);
        // End:0xA2
        if((SkelComp != none) && SkelComp.Animations != none)
        {
            SkelComp.Animations.ReplayAnim();
        }
    }
    //return;    
}

simulated function RefireCheckTimer()
{
    //return;    
}

simulated function OnSetTaskforce(TgSeqAct_SetTaskforce Action)
{
    SetTaskForceNumber(Action.TaskForceNumber);
    //return;    
}

simulated function CalcDeployPercentage()
{
    local TgRepInfo_Game Game;

    Game = TgRepInfo_Game(WorldInfo.GRI);
    // End:0xEC
    if((Game != none) && IsInState('Deploy'))
    {
        // End:0xB1
        if((m_fCurrentDeployPercentage < float(1)) && r_fTimeToDeploySecs > float(0))
        {
            m_fCurrentDeployPercentage = r_fCurrentDeployTime / r_fTimeToDeploySecs;
            m_fCurrentDeployPercentage = FMin(m_fCurrentDeployPercentage, 1.0000000);            
        }
        else
        {
            // End:0xD1
            if(m_fCurrentDeployPercentage != float(1))
            {
                m_fCurrentDeployPercentage = 1.0000000;
            }
        }
        // End:0xEC
        if(m_fCurrentDeployPercentage == float(1))
        {
            DeployComplete();
        }
    }
    //return;    
}

function OnPersistTimerExpire()
{
    // End:0x3C
    if(c_Mesh != none)
    {
        c_Mesh.FxActivateGroup('DeployableFizzle', 0);
    }
    DestroyIt();
    //return;    
}

event ResetPersistTime()
{
    // End:0x73
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x73
        if(s_fPersistTime != float(0))
        {
            SetTimer(s_fPersistTime, false, 'OnPersistTimerExpire');
            // End:0x73
            if(r_DRI != none)
            {
                r_DRI.StartLifespanTimer(s_fPersistTime);
            }
        }
    }
    //return;    
}

simulated function DeployComplete()
{
    // End:0x1E
    if(m_bIsDeployed || m_bInDestroyedState)
    {
        return;
    }
    m_bIsDeployed = true;
    GotoState('Active');
    // End:0xCC
    if(int(Role) == int(ROLE_Authority))
    {
        UpdateHealth();
        // End:0x6D
        if(m_bFireOnDeploy)
        {
            StartFire();
        }
        // End:0xCC
        if(s_fPersistTime != float(0))
        {
            SetTimer(s_fPersistTime, false, 'OnPersistTimerExpire');
            // End:0xCC
            if(r_DRI != none)
            {
                r_DRI.StartLifespanTimer(s_fPersistTime);
            }
        }
    }
    ActivateOnWhenDeployedFx(true);
    // End:0xF5
    if(int(Role) == int(ROLE_Authority))
    {
        NotifyDeployed();
    }
    // End:0x149
    if(WorldInfo.IsPlayingDemo() && CollisionComponent != none)
    {
        CollisionComponent.SetTraceBlocking(true, true);
    }
    // End:0x19C
    if((int(m_CollisionSettings.mCollisionMode) == int(2)) && m_CollisionSettings.bAutoRegisterObstacle)
    {
        RegisterObstacle();
    }
    //return;    
}

function NotifyDeployed()
{
    local TgPawn TgP;

    TgP = TgPawn(Instigator);
    // End:0x4B
    if(TgP != none)
    {
        TgP.DeployableOnDeployed(self);
    }
    //return;    
}

function UpdateTimeToDeploySecs(float fValue)
{
    // End:0x38
    if(IsInState('Deploy'))
    {
        r_fTimeToDeploySecs = r_fTimeToDeploySecs - fValue;
        CalcDeployPercentage();
    }
    //return;    
}

simulated function TickDeploy(float DeltaSeconds)
{
    //return;    
}

simulated event name GetWhileAliveDisplayGroup()
{
    return 'WhileAlive';
    //return ReturnValue;    
}

simulated event name GetDestroyedDisplayGroup()
{
    return 'Destroyed';
    //return ReturnValue;    
}

simulated event ActivateWhileAliveFx(bool bOn)
{
    local editinline TgSkeletalMeshComponent MeshAsSkeletalMeshComponent;
    local editinline TgStaticMeshComponent MeshAsStaticMeshComponent;
    local name nmWhileAliveDisplayGroup;

    MeshAsSkeletalMeshComponent = TgSkeletalMeshComponent(c_Mesh);
    MeshAsStaticMeshComponent = TgStaticMeshComponent(c_Mesh);
    nmWhileAliveDisplayGroup = GetWhileAliveDisplayGroup();
    // End:0xD3
    if(bOn)
    {
        // End:0x94
        if(MeshAsSkeletalMeshComponent != none)
        {
            MeshAsSkeletalMeshComponent.ActivateWhileAliveFx(true, nmWhileAliveDisplayGroup);            
        }
        else
        {
            // End:0xD0
            if(MeshAsStaticMeshComponent != none)
            {
                MeshAsStaticMeshComponent.FxActivateGroup(nmWhileAliveDisplayGroup, 0, 0, 0, true);
            }
        }        
    }
    else
    {
        // End:0x10E
        if(MeshAsSkeletalMeshComponent != none)
        {
            MeshAsSkeletalMeshComponent.ActivateWhileAliveFx(false, nmWhileAliveDisplayGroup);            
        }
        else
        {
            // End:0x148
            if(MeshAsStaticMeshComponent != none)
            {
                MeshAsStaticMeshComponent.FxDeactivateGroup(nmWhileAliveDisplayGroup, 0, 0, 0);
            }
        }
    }
    //return;    
}

simulated event ActivateOnWhenDeployedFx(bool bOn)
{
    local editinline TgSkeletalMeshComponent MeshAsSkeletalMeshComponent;
    local editinline TgStaticMeshComponent MeshAsStaticMeshComponent;

    MeshAsSkeletalMeshComponent = TgSkeletalMeshComponent(c_Mesh);
    MeshAsStaticMeshComponent = TgStaticMeshComponent(c_Mesh);
    // End:0xB6
    if(bOn)
    {
        // End:0x77
        if(MeshAsSkeletalMeshComponent != none)
        {
            MeshAsSkeletalMeshComponent.ActivateOnWhenDeployedFx(true);            
        }
        else
        {
            // End:0xB3
            if(MeshAsStaticMeshComponent != none)
            {
                MeshAsStaticMeshComponent.FxActivateGroup('OnWhenDeployed', 0, 0, 0, true);
            }
        }        
    }
    else
    {
        // End:0xE8
        if(MeshAsSkeletalMeshComponent != none)
        {
            MeshAsSkeletalMeshComponent.ActivateOnWhenDeployedFx(false);            
        }
        else
        {
            // End:0x122
            if(MeshAsStaticMeshComponent != none)
            {
                MeshAsStaticMeshComponent.FxDeactivateGroup('OnWhenDeployed', 0, 0, 0);
            }
        }
    }
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x23
    if(VarName == 'r_nDeployableId')
    {
        ApplyDeployableSetup();
        return;
    }
    // End:0x46
    if(VarName == 'r_nFlashCount')
    {
        FlashCountUpdated();
        return;
    }
    // End:0x69
    if(VarName == 'r_vFlashLocation')
    {
        FlashLocationUpdated();
        return;
    }
    // End:0x8C
    if(VarName == 'r_nFlashFireCount')
    {
        FlashFireCountUpdated();
        return;
    }
    // End:0xBF
    if(VarName == 'r_nHealth')
    {
        // End:0xBD
        if(r_nHealth <= 0)
        {
            DestroyIt();
        }
        return;
    }
    // End:0xFD
    if(VarName == 'r_nReplicateDestroyIt')
    {
        // End:0xFB
        if(r_nReplicateDestroyIt > 0)
        {
            DestroyIt(r_nReplicateDestroyIt > 1);
        }
        return;
    }
    // End:0x120
    if(VarName == 'r_bInitialIsEnemy')
    {
        NotifyGroupChanged();
        return;
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

event SpawningDeviceToggledOff()
{
    DestroyIt(false);
    //return;    
}

simulated event DestroyIt(optional bool bSkipFx)
{
    local Vector vRotation;

    // End:0x54
    if((int(m_CollisionSettings.mCollisionMode) == int(2)) && m_CollisionSettings.bAutoRegisterObstacle)
    {
        UnRegisterObstacle();
    }
    // End:0x63
    if(m_bInDestroyedState)
    {
        return;
    }
    StopFire();
    SetHUDOverlayState(2);
    // End:0x88
    if(bTearOff)
    {
        return;
    }
    // End:0xAD
    if(m_DestroyedMesh != none)
    {
        LifeSpan = m_fLifeAfterDeathSecs;        
    }
    else
    {
        LifeSpan = ((m_fLifeAfterDeathSecs > float(0)) ? m_fLifeAfterDeathSecs : 0.1000000);
        SetCollision(false, false, false);
    }
    // End:0x257
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        // End:0x254
        if(!bSkipFx && c_Mesh != none)
        {
            vRotation = Normal(Vector(Rotation));
            c_Mesh.FxActivateIndependant(GetDestroyedDisplayGroup(), 0, Location, vRotation);
            // End:0x1D4
            if((GetHealth()) <= 0.0000000)
            {
                c_Mesh.FxActivateIndependant('DestroyedByKill', 0, Location, vRotation);                
            }
            else
            {
                c_Mesh.FxActivateIndependant('DestroyedByTimeout', 0, Location, vRotation);
            }
            ActivateOnWhenDeployedFx(false);
            c_Mesh.FxDeactivateGroup('Deploying', 0);
            ActivateWhileAliveFx(false);
        }        
    }
    else
    {
        r_nReplicateDestroyIt = ((bSkipFx) ? 2 : 1);
    }
    // End:0x2A3
    if(m_SilhouetteManager != none)
    {
        m_SilhouetteManager.m_bSilhouettesEnabled = false;
    }
    ClearBasedPawnList();
    SwapMeshToDestroyed();
    m_bInDestroyedState = true;
    s_bDestroyedThisTick = true;
    DeployableDestroyed();
    // End:0x314
    if(s_DeployFactory != none)
    {
        s_DeployFactory.TriggerEventClass(Class'TgGame.TgSeqEvent_PlaceableDestroyed', self, 0, false);
    }
    // End:0x35A
    if((int(Role) == int(ROLE_Authority)) && r_DRI != none)
    {
        r_DRI.r_bInDestroyedState = true;
    }
    //return;    
}

event AddBasedPawn(TgPawn basedPawn)
{
    // End:0x33
    if((basedPawn == none) || m_PawnsBasedOnMe.Find(basedPawn) != -1)
    {
        return;
    }
    m_PawnsBasedOnMe.AddItem(basedPawn);
    //return;    
}

event RemoveBasedPawn(TgPawn basedPawn)
{
    local int Index;

    // End:0x11
    if(basedPawn == none)
    {
        return;
    }
    Index = m_PawnsBasedOnMe.Find(basedPawn);
    // End:0x59
    if(Index != -1)
    {
        m_PawnsBasedOnMe.Remove(Index, 1);
    }
    //return;    
}

simulated function ClearBasedPawnList()
{
    m_PawnsBasedOnMe.Length = 0;
    //return;    
}

simulated function Tick(float DeltaSeconds)
{
    super.Tick(DeltaSeconds);
    s_bDestroyedThisTick = false;
    //return;    
}

simulated function Destroyed()
{
    local TgPawn TgP;

    // End:0x53
    if((int(m_CollisionSettings.mCollisionMode) == int(2)) && m_CollisionSettings.bAutoRegisterObstacle)
    {
        UnRegisterObstacle();
    }
    // End:0x93
    if(TgDeployableFactory(s_DeployFactory) != none)
    {
        TgDeployableFactory(s_DeployFactory).DeployableDied();
    }
    // End:0xBA
    if(r_DRI != none)
    {
        r_DRI.Destroy();
    }
    // End:0xE1
    if(r_EffectManager != none)
    {
        r_EffectManager.Destroy();
    }
    // End:0x148
    if(m_SilhouetteManager != none)
    {
        m_SilhouetteManager.m_bSilhouettesEnabled = false;
        m_SilhouetteManager.ClearAllSilhouetteInfos();
        m_SilhouetteManager.Destroy();
    }
    ClearBasedPawnList();
    TgP = TgPawn(Instigator);
    // End:0x19D
    if(TgP != none)
    {
        TgP.DeployableOnDestroyed(self);
    }
    DeployableDestroyed();
    super.Destroyed();
    // End:0x1E4
    if(m_AkActorUnoccluded != none)
    {
        m_AkActorUnoccluded.LifeSpan = 2.0000000;
    }
    //return;    
}

event TakeDamage(int Damage, Controller EventInstigator, Vector HitLocation, Vector Momentum, Class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    // End:0xB3
    if(r_bTakeDamage)
    {
        super.TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
        r_nHealth = Max(0, r_nHealth - Damage);
        UpdateHealth();
        // End:0xB3
        if((r_nHealth <= 0) && int(Role) == int(ROLE_Authority))
        {
            DestroyIt();
        }
    }
    //return;    
}

// Export UTgDeployable::execGetDeployableNameById(FFrame&, void* const)
native function string GetDeployableNameById(int DeployableId);

simulated event bool CanApplyEffects()
{
    return !m_bInDestroyedState && r_bTakeDamage;
    //return ReturnValue;    
}

simulated event bool DamageShouldEnterCombat()
{
    return true;
    //return ReturnValue;    
}

event InitReplicationInfo()
{
    // End:0x3AF
    if(!bDeleteMe && int(Role) == int(ROLE_Authority))
    {
        r_DRI = TgRepInfo_Deployable(Spawn(m_DRIClass, self,, vect(0.0000000, 0.0000000, 0.0000000), rot(0, 0, 0)));
        // End:0x3AF
        if(r_DRI != none)
        {
            UpdateHealth();
            r_DRI.r_nHealthMaximum = r_nHealth;
            r_DRI.r_nDeployableId = r_nDeployableId;
            r_DRI.r_DeployableOwner = self;
            r_DRI.SetBotRankId(BotRankId);
            r_DRI.r_bMinimapOnlyOwnerSee = c_bMinimapOnlyOwnerSee;
            // End:0x23C
            if(s_DeployFactory != none)
            {
                r_DRI.r_bOwnedByTaskforce = true;
                r_DRI.SetTaskForce(TgRepInfo_Game(WorldInfo.GRI).GetTaskForce(int(s_DeployFactory.s_nTaskForce), true));
                // End:0x239
                if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
                {
                    r_DRI.CheckNotifyGroupChanged();
                }                
            }
            else
            {
                // End:0x348
                if(Instigator != none)
                {
                    // End:0x302
                    if(r_DRI.r_bOwnedByTaskforce)
                    {
                        r_DRI.SetTaskForce(TgRepInfo_Game(WorldInfo.GRI).GetTaskForce(int(TgPawn(Instigator).GetTaskForceNumber()), true));
                        Instigator = none;                        
                    }
                    else
                    {
                        TgRepInfo_Player(Instigator.PlayerReplicationInfo).AddMinion(r_DRI);
                    }
                }
            }
            r_DRI.UpdateDeployableLocation();
            // End:0x3AF
            if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
            {
                r_DRI.ReceivedDeployableOwner();
            }
        }
    }
    //return;    
}

simulated function bool IsBoxExtentInRange(Vector BoxCenter, Vector BoxExtent)
{
    // End:0x54
    if(m_FireMode != none)
    {
        return BoxCircleTest(Location, m_FireMode.GetDamageRadius(), BoxCenter, BoxExtent);
    }
    return false;
    //return ReturnValue;    
}

simulated function ToggleSpectateFx(optional bool bForceDisable)
{
    local TgSpecialFx SpecialFx;
    local int I;

    // End:0x38
    if(!WorldInfo.IsPlayingDemo() || c_Mesh == none)
    {
        return;
    }
    c_bIsSpectateToggleActive = ((bForceDisable) ? false : !c_bIsSpectateToggleActive);
    // End:0x1D6
    if(c_bIsSpectateToggleActive)
    {
        SpecialFx = TgSpecialFx(c_Mesh.FxActivateGroup('SpectatorToggle', 0));
        // End:0x195
        if(SpecialFx != none)
        {
            I = 0;
            J0xC6:

            // End:0x195 [Loop If]
            if(I < SpecialFx.c_PSCList.Length)
            {
                // End:0x187
                if(SpecialFx.c_PSCList[I].c_PSC != none)
                {
                    SpecialFx.c_PSCList[I].c_PSC.m_bRealTimeTicking = true;
                }
                I++;
                // [Loop Continue]
                goto J0xC6;
            }
        }
        c_Mesh.FxDeactivateGroup('SpectatorToggleFadeOut', 0);
        m_fDisableSpectatorFxTimeRemaining = m_fDisableSpectatorFxTime;        
    }
    else
    {
        m_fDisableSpectatorFxTimeRemaining = 0.0000000;
        c_Mesh.FxDeactivateGroup('SpectatorToggle', 0);
        SpecialFx = TgSpecialFx(c_Mesh.FxActivateGroup('SpectatorToggleFadeOut', 0));
        // End:0x339
        if(SpecialFx != none)
        {
            I = 0;
            J0x26A:

            // End:0x339 [Loop If]
            if(I < SpecialFx.c_PSCList.Length)
            {
                // End:0x32B
                if(SpecialFx.c_PSCList[I].c_PSC != none)
                {
                    SpecialFx.c_PSCList[I].c_PSC.m_bRealTimeTicking = true;
                }
                I++;
                // [Loop Continue]
                goto J0x26A;
            }
        }
    }
    //return;    
}

simulated event DeactivateSpectatorFxTimer()
{
    ToggleSpectateFx(true);
    //return;    
}

final simulated function PlayGenericTakeHit(Vector HitLocation, Vector HitNormal)
{
    // End:0xBA
    if(((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && c_Mesh != none) && r_bTakeDamage)
    {
        c_Mesh.FxSpawnEmitter('TakeHit', 0, HitLocation, HitNormal);
        c_Mesh.FxSpawnSound('TakeHit', 0, HitLocation);
    }
    //return;    
}

// Export UTgDeployable::execGetDefaultDecalDimensions(FFrame&, void* const)
native function bool GetDefaultDecalDimensions(int nDecalId, int nSpecialFxId, out float Height, out float Width);

simulated function UpdateDecalScale(TgSpecialFx Fx, float radiusScale)
{
    local int I;
    local editinline DecalComponent DecalComp;
    local float Height, Width;

    I = 0;
    J0x0B:

    // End:0x1A6 [Loop If]
    if(I < Fx.c_DecalList.Length)
    {
        DecalComp = Fx.c_DecalList[I].c_Decal;
        // End:0x198
        if((DecalComp != none) && GetDefaultDecalDimensions(Fx.c_DecalList[I].c_nId, Fx.c_nFxId, Height, Width))
        {
            DecalComp.Width = (Width * radiusScale) * float(16);
            DecalComp.Height = (Height * radiusScale) * float(16);
            DecalComp.ForceUpdate(false);
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

simulated event CollisionChanged()
{
    super.CollisionChanged();
    // End:0x67
    if((int(m_CollisionSettings.mCollisionMode) == int(2)) && m_CollisionSettings.bAutoRegisterObstacle)
    {
        UnRegisterObstacle();
        RegisterObstacle();
    }
    //return;    
}

simulated event SetHUDOverlayDisplayMask(int dodm)
{
    // End:0x37
    if(r_DRI != none)
    {
        r_DRI.SetHUDOverlayDisplayMask(dodm);
    }
    //return;    
}

simulated event AddHUDOverlayDisplayMask(int dodm)
{
    // End:0x57
    if(r_DRI != none)
    {
        r_DRI.SetHUDOverlayDisplayMask(r_DRI.r_nDeployableOverlayDisplayMask | dodm);
    }
    //return;    
}

simulated event SetHUDOverlayIcon(TgObject.DeployableOverlayIcon doi)
{
    // End:0x37
    if(r_DRI != none)
    {
        r_DRI.SetHUDOverlayIcon(doi);
    }
    //return;    
}

simulated event SetHUDOverlayState(TgObject.DeployableOverlayState dos)
{
    // End:0x37
    if(r_DRI != none)
    {
        r_DRI.SetHUDOverlayState(dos);
    }
    //return;    
}

simulated event SetHUDOverlayEnemyViewDist(float enemyViewDist)
{
    // End:0x37
    if(r_DRI != none)
    {
        r_DRI.SetHUDOverlayEnemyViewDist(enemyViewDist);
    }
    //return;    
}

simulated function float GetMaxAimAssistStacks()
{
    return m_fMaxAimAssistStacks;
    //return ReturnValue;    
}

auto state PreInit
{Begin:

    stop;                
}

simulated state Deploy
{
    ignores StartFire;

    simulated function BeginState(name PreviousStateName)
    {
        // End:0x73
        if(r_fTimeToDeploySecs > float(0))
        {
            // End:0x34
            if(int(Role) == int(ROLE_Authority))
            {
                m_fCurrentDeployPercentage = 0.0000000;
            }
            // End:0x70
            if(c_Mesh != none)
            {
                c_Mesh.FxActivateGroup('Deploying', 0);
            }            
        }
        else
        {
            TickDeploy(0.0000000);
        }
        // End:0xBE
        if(int(Role) == int(ROLE_Authority))
        {
            r_fInitDeployTime = WorldInfo.TimeSeconds;
        }
        ActivateWhileAliveFx(true);
        // End:0x129
        if(int(Role) == int(ROLE_Authority))
        {
            SetHUDOverlayIcon(m_InitHUDOverlayIcon);
            SetHUDOverlayDisplayMask(m_nInitHUDOverlayDisplayMask);
            SetHUDOverlayState(m_InitHUDOverlayState);
            SetHUDOverlayEnemyViewDist(m_InitHUDOverlayEnemyViewDist);
        }
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        TickDeploy(0.0000000);
        // End:0x49
        if(c_Mesh != none)
        {
            c_Mesh.FxDeactivateGroup('Deploying', 0);
        }
        //return;        
    }

    simulated function Tick(float DeltaSeconds)
    {
        global.Tick(DeltaSeconds);
        TickDeploy(DeltaSeconds);
        //return;        
    }

    simulated function TickDeploy(float DeltaSeconds)
    {
        r_fCurrentDeployTime += DeltaSeconds;
        CalcDeployPercentage();
        //return;        
    }

    function float GetSaveHealthPercent()
    {
        local int nMaxHealth, nMaxDeployHealth;

        nMaxDeployHealth = GetMaxDeployHealth();
        nMaxHealth = int(GetMaxHealth());
        // End:0x6E
        if((nMaxDeployHealth > 0) && nMaxHealth > 0)
        {
            return (float(nMaxDeployHealth) - m_fDamagedDuringDeploy) / float(nMaxHealth);
        }
        return 1.0000000;
        //return ReturnValue;        
    }
    stop;    
}

simulated state Active
{    stop;    
}

simulated state DeviceBuildup
{
    simulated function bool IsFiring()
    {
        return true;
        //return ReturnValue;        
    }

    simulated function DeployableTimer()
    {
        GotoState('DeviceFiring');
        //return;        
    }

    simulated function BeginState(name PreviousStateName)
    {
        // End:0x43
        if(int(Role) == int(ROLE_Authority))
        {
            m_FireMode.ApplyEffectType(Instigator, 262);
        }
        IncrementFlashCount();
        m_fStateTime = m_FireMode.GetBuildupTime();
        // End:0xA1
        if(m_fStateTime > float(0))
        {
            SetTimer(m_fStateTime, false, 'DeployableTimer');            
        }
        else
        {
            GotoState('DeviceFiring');
        }
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        // End:0x43
        if(int(Role) == int(ROLE_Authority))
        {
            m_FireMode.RemoveEffectType(Instigator, false, 262);
        }
        ClearTimer('DeployableTimer');
        //return;        
    }
    stop;    
}

simulated state DeviceFiring
{
    simulated function RefireCheckTimer()
    {
        FireAmmunitionDeployable();
        TimeDeviceFiring();
        //return;        
    }

    simulated function bool IsFiring()
    {
        return true;
        //return ReturnValue;        
    }

    simulated function BeginState(name PreviousStateName)
    {
        // End:0x3C
        if(c_Mesh != none)
        {
            c_Mesh.FxActivateGroup('WhileFiring', 0);
        }
        // End:0x77
        if(int(Role) == int(ROLE_Authority))
        {
            m_FireMode.ApplyEffectType(self, 263);
        }
        FireAmmunitionDeployable();
        m_bHasAlreadyFiredOnce = true;
        TimeDeviceFiring();
        DeviceFired();
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        // End:0x3A
        if(c_Mesh != none)
        {
            c_Mesh.FxDeactivateGroup('WhileFiring', 0);
        }
        // End:0x7D
        if(int(Role) == int(ROLE_Authority))
        {
            m_FireMode.RemoveEffectType(Instigator, false, 263);
        }
        ClearFlashCount();
        ClearFlashLocation();
        ClearTimer('RefireCheckTimer');
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bFireOnDeploy=true
    m_bDestroyAfterRoundEnds=true
    m_bAdjustMeshToGround=true
    m_bUseRangeFalloffCurve=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeployable.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    begin object name="MyLightEnvironment" class=Engine.DynamicLightEnvironmentComponent
        bDynamic=false
    end object
    LightEnvironment=MyLightEnvironment
    AlwaysRelevantDistanceSquared=2560000.0000000
    m_fMaxAimAssistStacks=0.1000000
    m_InitHUDOverlayEnemyViewDist=1600.0000000
    m_TargetCollisionTraceDistance=100.0000000
    m_DRIClass=Class'TgGame.TgRepInfo_Deployable'
    m_fDisableSpectatorFxTime=3.0000000
    Components[0]=MyLightEnvironment
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    bPushedByEncroachers=false
    bReplicateInstigator=true
    bIgnoreBaseRotation=true
    bCanBeDamaged=true
    bUpdateHavokPos=true
    NetPriority=1.4000000
}