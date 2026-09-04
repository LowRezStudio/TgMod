class TgDeviceFire extends Object
    native(Devices);

const TGTT_ATTACK_NA = 83;
const TGTT_ATTACK_INSTANT_RANGED = 85;
const TGTT_ATTACK_PROJECTILE_RANGED = 177;
const TGTT_ATTACK_TELEPORT_TO_SPAWN = 1442;
const TGTT_ATTACK_GROUND_TARGET = 10032;
const TGTT_ATTACK_GROUND_TARGET_DEPLOYABLE = 10011;
const TGTT_ATTACK_GROUND_TARGET_BOT = 10382;
const TGTT_ATTACK_INSTANT_LINE = 10015;
const TGTT_ATTACK_GROUND_TARGET_PROJECTILE = 10251;
const TGTT_ATTACK_GROUND_TARGET_TELEPORT = 10636;
const TGTT_ATTACK_MAP_TELEPORT = 10657;
const TGTT_ATTACK_ATTACHED_DEPLOYABLE = 10670;
const TGTT_ATTACK_FORWARD_TELEPORT = 15034;
const TGTT_TARGET_SELF = 214;
const TGTT_TARGET_FRIEND = 10184;
const TGTT_TARGET_ENEMY = 212;
const TGTT_TARGET_ALL = 703;
const TGTT_TARGET_OWNPET = 15006;
const TGTT_TARGET_ENEMY_AND_SELF = 10805;
const TGTT_TARGET_FRIEND_ONLY = 884;
const TGTT_TARGET_FRIEND_AND_ENEMY = 10029;
const TGTT_TARGET_NOT_SELF = 10587;
const TGTT_TARGET_PET_OWNER = 15030;
const TGMT_MOVEMENT = 10583;
const TGDT_None = 112;
const TGDT_Physical = 113;
const TGDT_Magical = 10057;
const TGDT_AoE = 15207;
const TGDT_Direct = 15206;
const TGAUF_ALLOW_NONE = 0;
const TGAUF_ALLOW_STUN = 1;
const TGAUF_ALLOW_SILENCE = 2;
const TGAUF_ALLOW_GRAB = 4;
const TGAUF_ALLOW_CRIPPLE = 8;
const TGAUF_ALLOW_ALL = 15;

enum DeviceTargeterType
{
    TGDTT_None,                     // 0
    TGDTT_Self,                     // 1
    TGDTT_Friend,                   // 2
    TGDTT_Enemy,                    // 3
    TGDTT_OwnPet,                   // 4
    TGDTT_Enemy_And_Self,           // 5
    TGDTT_Friend_Only,              // 6
    TGDTT_Pet_Owner,                // 7
    TGDTT_Not_Self,                 // 8
    TGDTT_All,                      // 9
    TGDTT_MAX                       // 10
};

enum HeadShotResult
{
    HEADSHOT_SuccessfulMeshTrace,   // 0
    HEADSHOT_FailedMeshTrace,       // 1
    HEADSHOT_CannotMeshTrace,       // 2
    HEADSHOT_Failure,               // 3
    HEADSHOT_MAX                    // 4
};

enum TargetSelectionType
{
    TGTST_Default,                  // 0
    TGTST_Random,                   // 1
    TGTST_Closest,                  // 2
    TGTST_ClosestAimCenter,         // 3
    TGTST_LowestHealthPercent,      // 4
    TGTST_MAX                       // 5
};

struct native WeaponFireResults
{
    var bool bDidServerValidation;
    var ImpactInfo Impact;

    structdefaultproperties
    {
        bDidServerValidation=false
        Impact=(HitActor=none,HitLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000),HitNormal=(X=0.0000000,Y=0.0000000,Z=0.0000000),RayDir=(X=0.0000000,Y=0.0000000,Z=0.0000000),StartTrace=(X=0.0000000,Y=0.0000000,Z=0.0000000),HitInfo=(Material=none,PhysMaterial=none,Item=0,LevelIndex=0,BoneName="None",HitComponent=none),PercAbsorbedDamage=0.0000000,DeviceModeReference=none,Projectile=none,bDirectHit=false,nFiringInstance=0,nShotsHit=0)
    }
};

struct native AoeActorInRangeData
{
    var Actor Actor;
    var Vector Location;

    structdefaultproperties
    {
        Actor=none
        Location=(X=0.0000000,Y=0.0000000,Z=0.0000000)
    }
};

var Actor m_Owner;
var TgDevice.EWeaponFireType m_nFireType;
var TgObject.DeviceTargetMode m_eTargetingMode;
var TgDeviceFire.DeviceTargeterType m_eTargeterType;
var TgDeviceFire.TargetSelectionType m_eTargetSelectionTypeOverride;
var bool m_bIsAOE;
var bool m_bIsCone;
var bool m_bIsLinear;
var bool m_bContinuousFire;
var bool m_bRequireLOS;
var bool m_bVerifyTargetPlacement;
var bool m_bAllowMultiplePets;
var const bool m_bUseAccurateEncroachment;
var const bool m_bUseTargetingEncroachmentActor;
var const bool m_bScaleEncroachmentWithRangeMod;
var const bool m_bPassThroughShield;
var const bool m_bPassThroughDeployWalls;
var const bool m_bIgnoreDeployablesForBlocking;
var bool m_bAdjustDeployHeightToExtent;
var bool m_bDeployOnOwnerLocation;
var bool m_bSpawnPetOnOwnerLocation;
var bool m_bCanTriggerCounter;
var bool m_bEnchroachmentFireLOSCheck;
var bool m_bTreatAmmoAsCharges;
var bool m_bMaintainBurstTarget;
var bool m_bCanTargetStealthedTargets;
var array<TgEffectGroup> s_EffectGroupList;
var array<TgProperty> m_Properties;
var native Pointer m_pAmSetup;
var native Pointer m_pFireModeSetup;
var int m_nId;
var int m_nAttackType;
var int m_nMovementType;
var name m_nmOffhandAnimationType;
var int m_nTargetAffectsType;
var int m_nAllowUseWhileFlags;
var int m_nDamageType;
var int m_nArcingJumps;
var native Map_Mirror m_PropertyIndexMap;
var float m_fHealthCost;
var float m_fManaCost;
var float m_fEnergyCost;
var float m_fFireTime;
var float m_fBuildupTime;
var float m_fFirePreHitDelay;
var float m_fFirePostHitDelay;
var int m_nShotsPerFire;
var name m_nmDamageTypeClass;
var Class<TgDamageType> m_DamageTypeClass;
var int m_nMaxTargetCount;
var float m_fFireLockTime;
var int m_nAmmoClipSize;
var float m_fAmmoClipPreReloadTime;
var float m_fAmmoClipPostReloadTime;
var int m_nAmmoCostPerShot;
var const float m_fEncroachmentRayCastVerticalOffset;
var const int m_nTargetingEncroachmentActorOverride;
var transient Actor m_TargetingEncroachmentActor;
var const Vector m_vActorEncroachmentBaseScale;
var name m_nmWhileFiringCameraAnim;
var float m_CachedRechargeBonusFlat;
var float m_CachedRechargeBonusPercent;
var array<TgEffect> m_ModifiedEffects;
var array<float> m_BaseValues;
var array<TgEffectGroup> m_ModifiedEGLifetimes;
var array<float> m_BaseLifetimes;
var array<TgEffectGroup> m_ModifiedEGAppValues;
var array<float> m_BaseAppValues;
var array<TgEffectGroup> m_ModifiedEGMaxStacks;
var array<float> m_BaseMaxStacks;
var array<Actor> m_CachedTargetList;
var float m_fSelectTargetsExtent;
var TgGameplayCurves m_GameplayCurves;

// Export UTgDeviceFire::execSpecialShieldDestroyed(FFrame&, void* const)
native function SpecialShieldDestroyed();

// Export UTgDeviceFire::execGetProjectileClass(FFrame&, void* const)
native function Class<Projectile> GetProjectileClass();

// Export UTgDeviceFire::execInitializeProjectile(FFrame&, void* const)
native function InitializeProjectile(Projectile Proj);

// Export UTgDeviceFire::execDeployAtActor(FFrame&, void* const)
native function DeployAtActor(Actor TargetActor);

// Export UTgDeviceFire::execDeployAtLocation(FFrame&, void* const)
native function DeployAtLocation(Vector SpawnLocation, Rotator SpawnRotation);

// Export UTgDeviceFire::execDeploy(FFrame&, void* const)
native function Deploy();

// Export UTgDeviceFire::execGetDeployLocationAndRotation(FFrame&, void* const)
native function bool GetDeployLocationAndRotation(out Vector OutLocation, out Rotator OutRotation);

// Export UTgDeviceFire::execGetDeployableBase(FFrame&, void* const)
native function Actor GetDeployableBase();

// Export UTgDeviceFire::execSpawnPet(FFrame&, void* const)
native function TgPawn SpawnPet(bool bPet);

// Export UTgDeviceFire::execGetPetLocationAndRotation(FFrame&, void* const)
native function bool GetPetLocationAndRotation(out Vector OutLocation, out Rotator OutRotation, Pointer botSetup);

// Export UTgDeviceFire::execCustomFire(FFrame&, void* const)
native function CustomFire();

// Export UTgDeviceFire::execTeleportFire(FFrame&, void* const)
native simulated function TeleportFire();

// Export UTgDeviceFire::execGetProperty(FFrame&, void* const)
native function TgProperty GetProperty(int nPropertyId);

// Export UTgDeviceFire::execSetProperty(FFrame&, void* const)
native function SetProperty(int nPropertyId, float fNewValue);

// Export UTgDeviceFire::execGetPropertyValue(FFrame&, void* const)
native function float GetPropertyValue(int nPropertyId);

// Export UTgDeviceFire::execGetPropertyValueById(FFrame&, void* const)
native function float GetPropertyValueById(int nPropertyId, int nPropertyIndex);

// Export UTgDeviceFire::execGetEffectGroup(FFrame&, void* const)
native function TgEffectGroup GetEffectGroup(int nType, out int nIndex);

// Export UTgDeviceFire::execQueryClass(FFrame&, void* const)
native function name QueryClass(int nMode);

// Export UTgDeviceFire::execIsBlockedByGeometry(FFrame&, void* const)
native function bool IsBlockedByGeometry(Actor SourceActor, Actor TargetActor);

// Export UTgDeviceFire::execVerifyProjectile(FFrame&, void* const)
native function VerifyProjectile();

// Export UTgDeviceFire::execLogDebugInfo(FFrame&, void* const)
native function bool LogDebugInfo();

// Export UTgDeviceFire::execGetDamageRadius(FFrame&, void* const)
native function float GetDamageRadius();

// Export UTgDeviceFire::execGetAIRange(FFrame&, void* const)
native function float GetAIRange();

// Export UTgDeviceFire::execGetAIRadius(FFrame&, void* const)
native function float GetAIRadius();

// Export UTgDeviceFire::execGetRemoteActivationTime(FFrame&, void* const)
native function float GetRemoteActivationTime();

// Export UTgDeviceFire::execGetPostLandDuration(FFrame&, void* const)
native function float GetPostLandDuration();

// Export UTgDeviceFire::execGetEffectiveRadius(FFrame&, void* const)
native function float GetEffectiveRadius();

// Export UTgDeviceFire::execGetPersistTime(FFrame&, void* const)
native function float GetPersistTime();

// Export UTgDeviceFire::execGetPersistPulse(FFrame&, void* const)
native function float GetPersistPulse();

// Export UTgDeviceFire::execGetPetLifeSpan(FFrame&, void* const)
native function float GetPetLifeSpan();

// Export UTgDeviceFire::execGetFireAngle(FFrame&, void* const)
native function float GetFireAngle();

// Export UTgDeviceFire::execGetDeployTime(FFrame&, void* const)
native function float GetDeployTime();

// Export UTgDeviceFire::execGetProjectileSpeed(FFrame&, void* const)
native function float GetProjectileSpeed();

// Export UTgDeviceFire::execGetVisionRange(FFrame&, void* const)
native function float GetVisionRange();

// Export UTgDeviceFire::execGetProximityDistance(FFrame&, void* const)
native function float GetProximityDistance();

// Export UTgDeviceFire::execGetRange(FFrame&, void* const)
native function float GetRange();

// Export UTgDeviceFire::execGetMinRange(FFrame&, void* const)
native function float GetMinRange();

// Export UTgDeviceFire::execGetEffectiveRange(FFrame&, void* const)
native function float GetEffectiveRange();

// Export UTgDeviceFire::execGetMinimumRadius(FFrame&, void* const)
native function float GetMinimumRadius();

// Export UTgDeviceFire::execGetMaxDeployableCount(FFrame&, void* const)
native function float GetMaxDeployableCount();

// Export UTgDeviceFire::execGetHeadShotDamage(FFrame&, void* const)
native function float GetHeadShotDamage();

// Export UTgDeviceFire::execGetBonusShieldDamagePerc(FFrame&, void* const)
native function float GetBonusShieldDamagePerc();

// Export UTgDeviceFire::execIsWithinRange(FFrame&, void* const)
native function bool IsWithinRange(float fDistance);

// Export UTgDeviceFire::execIsWithinEffectiveRange(FFrame&, void* const)
native function bool IsWithinEffectiveRange(float fDistance);

// Export UTgDeviceFire::execGetCustomValue1(FFrame&, void* const)
native function float GetCustomValue1();

// Export UTgDeviceFire::execGetCustomValue2(FFrame&, void* const)
native function float GetCustomValue2();

// Export UTgDeviceFire::execGetCustomValue3(FFrame&, void* const)
native function float GetCustomValue3();

// Export UTgDeviceFire::execGetCustomValue4(FFrame&, void* const)
native function float GetCustomValue4();

// Export UTgDeviceFire::execGetCustomValue5(FFrame&, void* const)
native function float GetCustomValue5();

// Export UTgDeviceFire::execCheckTeamPassThrough(FFrame&, void* const)
native function bool CheckTeamPassThrough(Actor HitActor, Vector aimDirection);

// Export UTgDeviceFire::execIsValidTarget(FFrame&, void* const)
native function bool IsValidTarget(Actor P, optional TgDeviceFire.DeviceTargeterType eTargeterType = 0, optional bool bIgnoreHealth, optional bool bInvertTeam);

// Export UTgDeviceFire::execIsSelfOrOwner(FFrame&, void* const)
native function bool IsSelfOrOwner(Actor Target);

// Export UTgDeviceFire::execIsEnemy(FFrame&, void* const)
native function bool IsEnemy(Actor TargetActor);

// Export UTgDeviceFire::execGetTraceImpact(FFrame&, void* const)
native function ImpactInfo GetTraceImpact(Vector StartTrace, Vector EndTrace, Vector Extent, bool bIgnoreWorld, bool bCheckLockOn, bool bForceNoBodyShotCheck, optional float RewindTime = 0.0000000, const optional out array<ImpactToValidate> ImpactsToValidate, optional int nShotIndex);

// Export UTgDeviceFire::execIsArcingAttack(FFrame&, void* const)
native function bool IsArcingAttack();

// Export UTgDeviceFire::execUsesActorEncroachmentForCalcTargetingFire(FFrame&, void* const)
native function bool UsesActorEncroachmentForCalcTargetingFire();

// Export UTgDeviceFire::execGetShotPowerCost(FFrame&, void* const)
native function float GetShotPowerCost(int nPacingType);

// Export UTgDeviceFire::execAddEffectiveRangeReduction(FFrame&, void* const)
native function AddEffectiveRangeReduction(out ImpactInfo Impact, Actor DamageInstigator, Vector OriginLocation, optional bool bUseRadius = false);

// Export UTgDeviceFire::execGetTargetingMode(FFrame&, void* const)
native function TgObject.DeviceTargetMode GetTargetingMode();

// Export UTgDeviceFire::execIsBlockedByBlocker(FFrame&, void* const)
native function Actor IsBlockedByBlocker(Actor DamageInstigator, Actor Target, optional Vector OriginLocation, optional Vector TargetLocation);

// Export UTgDeviceFire::execIgnoreTargetForBlocking(FFrame&, void* const)
native function bool IgnoreTargetForBlocking(Actor Target);

// Export UTgDeviceFire::execGetHitLocationFlat(FFrame&, void* const)
native function Vector GetHitLocationFlat(const out Vector StartTrace, const out Vector TargetLocation, const out Vector targetExtent);

// Export UTgDeviceFire::execGetHitLocationToCenter(FFrame&, void* const)
native function Vector GetHitLocationToCenter(const out Vector StartTrace, const out Vector TargetLocation, const out Vector targetExtent);

// Export UTgDeviceFire::execShouldAddToImpactList(FFrame&, void* const)
native function bool ShouldAddToImpactList(Actor HitActor, array<ImpactInfo> ImpactList);

// Export UTgDeviceFire::execIsInSlice(FFrame&, void* const)
native static function bool IsInSlice(const Actor SourceActor, const Actor TargetActor, Vector StartCone, Vector ConeDir, float ConeAngle, optional float ConeRadius);

// Export UTgDeviceFire::execIsInCone(FFrame&, void* const)
native static function bool IsInCone(Actor SourceActor, Actor TargetActor, Vector StartCone, Vector ConeDir, float ConeAngle);

// Export UTgDeviceFire::execCheckValidTarget(FFrame&, void* const)
native function bool CheckValidTarget(Actor Target, bool bPredicting);

// Export UTgDeviceFire::execCalcWeaponModeFire(FFrame&, void* const)
native function WeaponFireResults CalcWeaponModeFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bPredicting = false, optional bool bNoBodyShotCheck = false, optional float RewindTime = 0.0000000, const optional out array<ImpactToValidate> ImpactsToValidate);

// Export UTgDeviceFire::execCalcConeFire(FFrame&, void* const)
native function ImpactInfo CalcConeFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bUseRange = false, optional bool bPredicting = false);

// Export UTgDeviceFire::execCalcSliceFire(FFrame&, void* const)
native function ImpactInfo CalcSliceFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bUseRange = false, optional bool bPredicting = false);

// Export UTgDeviceFire::execCalcAoeFire(FFrame&, void* const)
native function ImpactInfo CalcAoeFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bPredicting = false, optional float RewindTime = 0.0000000);

// Export UTgDeviceFire::execCalcInstantFire(FFrame&, void* const)
native function WeaponFireResults CalcInstantFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bPredicting = false, optional bool bNoBodyShotCheck = false, optional float RewindTime = 0.0000000, const optional out array<ImpactToValidate> ImpactsToValidate);

// Export UTgDeviceFire::execCalcArcingFire(FFrame&, void* const)
native function ImpactInfo CalcArcingFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bPredicting = false);

// Export UTgDeviceFire::execCalcLinearFire(FFrame&, void* const)
native function ImpactInfo CalcLinearFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bPredicting = false);

// Export UTgDeviceFire::execCalcDeployableTargetingFire(FFrame&, void* const)
native function ImpactInfo CalcDeployableTargetingFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, int nDeployableId, optional bool bPredicting = false);

// Export UTgDeviceFire::execCalcChargeTargetingFire(FFrame&, void* const)
native function ImpactInfo CalcChargeTargetingFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bPredicting = false);

// Export UTgDeviceFire::execCalcActorEncroachmentTargetingFire(FFrame&, void* const)
native function WeaponFireResults CalcActorEncroachmentTargetingFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bPredicting = false, optional float RewindTime = 0.0000000, const optional out array<ImpactToValidate> ImpactsToValidate);

// Export UTgDeviceFire::execGetAlternateAOEStartTrace(FFrame&, void* const)
native function Vector GetAlternateAOEStartTrace(Actor DamageInstigator, const out Vector Center, float Radius);

// Export UTgDeviceFire::execGetCurrentGameplayCurves(FFrame&, void* const)
native function TgGameplayCurves GetCurrentGameplayCurves();

simulated event ApplyEquipEffects()
{
    local TgDevice DeviceOwner;

    // End:0x141
    if((int(m_Owner.Role) == int(ROLE_Authority)) && m_Owner.Instigator.IsA('TgPawn'))
    {
        ApplyEffectType(m_Owner.Instigator, 283);
        DeviceOwner = TgDevice(m_Owner);
        // End:0x141
        if((DeviceOwner != none) && DeviceOwner.IsActive(false, true))
        {
            RemoveEffectType(m_Owner.Instigator, false, 11073);
            ApplyEffectType(m_Owner.Instigator, 11073);
        }
    }
    //return;    
}

simulated event RemoveEquipEffects()
{
    local TgPawn Pawn;
    local int I;

    // End:0x18F
    if((int(m_Owner.Role) == int(ROLE_Authority)) && m_Owner.Instigator.IsA('TgPawn'))
    {
        RemoveEffectType(m_Owner.Instigator, false, 283);
        RemoveEffectType(m_Owner.Instigator, false, 11073);
        // End:0x18F
        if(int(m_eTargeterType) == int(4))
        {
            Pawn = TgPawn(m_Owner.Instigator);
            // End:0x18F
            if(Pawn != none)
            {
                I = 0;
                J0x120:

                // End:0x18F [Loop If]
                if(I < Pawn.c_ActivePets)
                {
                    RemoveHitSpecial(Pawn.s_Pets[I], true);
                    I++;
                    // [Loop Continue]
                    goto J0x120;
                }
            }
        }
    }
    //return;    
}

event SubmitEffect(ImpactInfo Impact, TgEffectGroup EffectGroup, optional bool bRemove, optional int StackCount = 1, optional Actor InstigatorOverride)
{
    local Actor EffectInstigator;
    local TgEffectManager effectManager;
    local TgCombatActor combatHitActor;

    // End:0x3C
    if((Impact.HitActor == none) || EffectGroup == none)
    {
        return;
    }
    // End:0x124
    if(((!Impact.HitActor.IsA('TgPawn') && !Impact.HitActor.IsA('TgDeployable')) && !Impact.HitActor.IsA('TgDestructible')) && !Impact.HitActor.IsA('TgFracturedStaticMeshActor'))
    {
        return;
    }
    Impact.DeviceModeReference = self;
    // End:0x167
    if(InstigatorOverride != none)
    {
        EffectInstigator = InstigatorOverride;        
    }
    else
    {
        // End:0x1B6
        if(m_Owner.Instigator != none)
        {
            EffectInstigator = m_Owner.Instigator;            
        }
        else
        {
            EffectInstigator = m_Owner;
        }
    }
    combatHitActor = TgCombatActor(Impact.HitActor);
    // End:0x245
    if(NotEqual_InterfaceInterface(combatHitActor, TgCombatActor(none)))
    {
        effectManager = combatHitActor.GetEffectManager();        
    }
    else
    {
        // End:0x2B4
        if(TgDestructible(Impact.HitActor) != none)
        {
            effectManager = TgDestructible(Impact.HitActor).r_EffectManager;
        }
    }
    // End:0x382
    if(effectManager != none)
    {
        // End:0x322
        if(bRemove)
        {
            effectManager.RemoveEffectGroupById(EffectGroup.m_nEffectGroupId, StackCount, EffectInstigator);            
        }
        else
        {
            ApplyModifyEffects(EffectGroup);
            effectManager.ProcessEffect(EffectGroup, EffectInstigator, StackCount, Impact);
            RemoveModifyEffects();
        }
    }
    //return;    
}

function ApplyModifyEffects(TgEffectGroup EffectGroup)
{
    local TgPawn PawnOwner;
    local TgDevice devOwner;
    local TgDeployable deployOwner;
    local TgEffectManager em;
    local TgEffectGroup modEffectGroup;
    local TgEffectModifyEffect modEffect;
    local TgEffectModifyDeployable modDeploy;
    local int I, J, K, modIndex;
    local float stackMultiplier;

    devOwner = TgDevice(m_Owner);
    deployOwner = TgDeployable(m_Owner);
    // End:0x1241
    if(((devOwner != none) && devOwner.r_nDeviceId > 0) && devOwner.Owner != none)
    {
        PawnOwner = TgPawn(devOwner.Owner);
        // End:0x123E
        if((PawnOwner != none) && PawnOwner.r_EffectManager != none)
        {
            em = PawnOwner.r_EffectManager;
            I = 0;
            J0x12C:

            // End:0x123E [Loop If]
            if(I < em.s_AppliedEffectGroups.Length)
            {
                modEffectGroup = em.s_AppliedEffectGroups[I];
                // End:0x1E2
                if((modEffectGroup == none) || float(devOwner.r_nDeviceId) != modEffectGroup.m_fPhysicalPowerScaling)
                {                    
                }
                else
                {
                    // End:0x250
                    if((modEffectGroup.m_fMagicalPowerScaling > float(0)) && modEffectGroup.m_fMagicalPowerScaling != float(EffectGroup.m_nEffectGroupId))
                    {                        
                    }
                    else
                    {
                        J = 0;
                        J0x25B:

                        // End:0x1230 [Loop If]
                        if(J < modEffectGroup.m_Effects.Length)
                        {
                            modEffect = TgEffectModifyEffect(modEffectGroup.m_Effects[J]);
                            // End:0x2D5
                            if(modEffect == none)
                            {                                
                            }
                            else
                            {
                                // End:0x649
                                if(modEffect.m_nPropertyId == 1950)
                                {
                                    modIndex = m_ModifiedEGLifetimes.Find(EffectGroup);
                                    // End:0x391
                                    if(modIndex == -1)
                                    {
                                        m_ModifiedEGLifetimes.AddItem(EffectGroup);
                                        m_BaseLifetimes.AddItem(EffectGroup.m_fLifeTime);
                                        modIndex = m_ModifiedEGLifetimes.Find(EffectGroup);
                                    }
                                    // End:0x646
                                    if(modIndex != -1)
                                    {
                                        // End:0x41C
                                        if(modEffectGroup.m_nNumMaxStacks > 0)
                                        {
                                            stackMultiplier = FClamp(float(modEffectGroup.m_nNumStacks), 1.0000000, float(modEffectGroup.m_nNumMaxStacks));                                            
                                        }
                                        else
                                        {
                                            stackMultiplier = FMax(float(modEffectGroup.m_nNumStacks), 1.0000000);
                                        }
                                        // End:0x4BE
                                        if(modEffect.m_nCalcMethodCode == 67)
                                        {
                                            EffectGroup.m_fLifeTime += (modEffect.m_fBase * stackMultiplier);                                            
                                        }
                                        else
                                        {
                                            // End:0x52F
                                            if(modEffect.m_nCalcMethodCode == 70)
                                            {
                                                EffectGroup.m_fLifeTime -= (modEffect.m_fBase * stackMultiplier);                                                
                                            }
                                            else
                                            {
                                                // End:0x5BC
                                                if(modEffect.m_nCalcMethodCode == 68)
                                                {
                                                    EffectGroup.m_fLifeTime += ((m_BaseLifetimes[modIndex] * (modEffect.m_fBase / 100.0000000)) * stackMultiplier);                                                    
                                                }
                                                else
                                                {
                                                    // End:0x646
                                                    if(modEffect.m_nCalcMethodCode == 69)
                                                    {
                                                        EffectGroup.m_fLifeTime -= ((m_BaseLifetimes[modIndex] * (modEffect.m_fBase / 100.0000000)) * stackMultiplier);
                                                    }
                                                }
                                            }
                                        }
                                    }                                    
                                }
                                else
                                {
                                    // End:0x9BD
                                    if(modEffect.m_nPropertyId == 1951)
                                    {
                                        modIndex = m_ModifiedEGAppValues.Find(EffectGroup);
                                        // End:0x705
                                        if(modIndex == -1)
                                        {
                                            m_ModifiedEGAppValues.AddItem(EffectGroup);
                                            m_BaseAppValues.AddItem(EffectGroup.m_fApplicationValue);
                                            modIndex = m_ModifiedEGAppValues.Find(EffectGroup);
                                        }
                                        // End:0x9BA
                                        if(modIndex != -1)
                                        {
                                            // End:0x790
                                            if(modEffectGroup.m_nNumMaxStacks > 0)
                                            {
                                                stackMultiplier = FClamp(float(modEffectGroup.m_nNumStacks), 1.0000000, float(modEffectGroup.m_nNumMaxStacks));                                                
                                            }
                                            else
                                            {
                                                stackMultiplier = FMax(float(modEffectGroup.m_nNumStacks), 1.0000000);
                                            }
                                            // End:0x832
                                            if(modEffect.m_nCalcMethodCode == 67)
                                            {
                                                EffectGroup.m_fApplicationValue += (modEffect.m_fBase * stackMultiplier);                                                
                                            }
                                            else
                                            {
                                                // End:0x8A3
                                                if(modEffect.m_nCalcMethodCode == 70)
                                                {
                                                    EffectGroup.m_fApplicationValue -= (modEffect.m_fBase * stackMultiplier);                                                    
                                                }
                                                else
                                                {
                                                    // End:0x930
                                                    if(modEffect.m_nCalcMethodCode == 68)
                                                    {
                                                        EffectGroup.m_fApplicationValue += ((m_BaseAppValues[modIndex] * (modEffect.m_fBase / 100.0000000)) * stackMultiplier);                                                        
                                                    }
                                                    else
                                                    {
                                                        // End:0x9BA
                                                        if(modEffect.m_nCalcMethodCode == 69)
                                                        {
                                                            EffectGroup.m_fApplicationValue -= ((m_BaseAppValues[modIndex] * (modEffect.m_fBase / 100.0000000)) * stackMultiplier);
                                                        }
                                                    }
                                                }
                                            }
                                        }                                        
                                    }
                                    else
                                    {
                                        // End:0xD3B
                                        if(modEffect.m_nPropertyId == 1989)
                                        {
                                            modIndex = m_ModifiedEGMaxStacks.Find(EffectGroup);
                                            // End:0xA7B
                                            if(modIndex == -1)
                                            {
                                                m_ModifiedEGMaxStacks.AddItem(EffectGroup);
                                                m_BaseMaxStacks.AddItem(float(EffectGroup.m_nNumMaxStacks));
                                                modIndex = m_ModifiedEGMaxStacks.Find(EffectGroup);
                                            }
                                            // End:0xD38
                                            if(modIndex != -1)
                                            {
                                                // End:0xB06
                                                if(modEffectGroup.m_nNumMaxStacks > 0)
                                                {
                                                    stackMultiplier = FClamp(float(modEffectGroup.m_nNumStacks), 1.0000000, float(modEffectGroup.m_nNumMaxStacks));                                                    
                                                }
                                                else
                                                {
                                                    stackMultiplier = FMax(float(modEffectGroup.m_nNumStacks), 1.0000000);
                                                }
                                                // End:0xBAA
                                                if(modEffect.m_nCalcMethodCode == 67)
                                                {
                                                    EffectGroup.m_nNumMaxStacks += int(modEffect.m_fBase * stackMultiplier);                                                    
                                                }
                                                else
                                                {
                                                    // End:0xC1D
                                                    if(modEffect.m_nCalcMethodCode == 70)
                                                    {
                                                        EffectGroup.m_nNumMaxStacks -= int(modEffect.m_fBase * stackMultiplier);                                                        
                                                    }
                                                    else
                                                    {
                                                        // End:0xCAC
                                                        if(modEffect.m_nCalcMethodCode == 68)
                                                        {
                                                            EffectGroup.m_nNumMaxStacks += int((m_BaseMaxStacks[modIndex] * (modEffect.m_fBase / 100.0000000)) * stackMultiplier);                                                            
                                                        }
                                                        else
                                                        {
                                                            // End:0xD38
                                                            if(modEffect.m_nCalcMethodCode == 69)
                                                            {
                                                                EffectGroup.m_nNumMaxStacks -= int((m_BaseMaxStacks[modIndex] * (modEffect.m_fBase / 100.0000000)) * stackMultiplier);
                                                            }
                                                        }
                                                    }
                                                }
                                            }                                            
                                        }
                                        else
                                        {
                                            K = 0;
                                            J0xD46:

                                            // End:0x1222 [Loop If]
                                            if(K < EffectGroup.m_Effects.Length)
                                            {
                                                // End:0x1214
                                                if(EffectGroup.m_Effects[K].m_nPropertyId == modEffect.m_nPropertyId)
                                                {
                                                    modIndex = m_ModifiedEffects.Find(EffectGroup.m_Effects[K]);
                                                    // End:0xEE3
                                                    if(modIndex == -1)
                                                    {
                                                        m_ModifiedEffects.AddItem(EffectGroup.m_Effects[K]);
                                                        m_BaseValues.AddItem(EffectGroup.m_Effects[K].m_fBase);
                                                        modIndex = m_ModifiedEffects.Find(EffectGroup.m_Effects[K]);
                                                    }
                                                    // End:0x1214
                                                    if(modIndex != -1)
                                                    {
                                                        // End:0xF6E
                                                        if(modEffectGroup.m_nNumMaxStacks > 0)
                                                        {
                                                            stackMultiplier = FClamp(float(modEffectGroup.m_nNumStacks), 1.0000000, float(modEffectGroup.m_nNumMaxStacks));                                                            
                                                        }
                                                        else
                                                        {
                                                            stackMultiplier = FMax(float(modEffectGroup.m_nNumStacks), 1.0000000);
                                                        }
                                                        // End:0x102F
                                                        if(modEffect.m_nCalcMethodCode == 67)
                                                        {
                                                            EffectGroup.m_Effects[K].m_fBase += (modEffect.m_fBase * stackMultiplier);                                                            
                                                        }
                                                        else
                                                        {
                                                            // End:0x10BF
                                                            if(modEffect.m_nCalcMethodCode == 70)
                                                            {
                                                                EffectGroup.m_Effects[K].m_fBase -= (modEffect.m_fBase * stackMultiplier);                                                                
                                                            }
                                                            else
                                                            {
                                                                // End:0x116B
                                                                if(modEffect.m_nCalcMethodCode == 68)
                                                                {
                                                                    EffectGroup.m_Effects[K].m_fBase += ((m_BaseValues[modIndex] * (modEffect.m_fBase / 100.0000000)) * stackMultiplier);                                                                    
                                                                }
                                                                else
                                                                {
                                                                    // End:0x1214
                                                                    if(modEffect.m_nCalcMethodCode == 69)
                                                                    {
                                                                        EffectGroup.m_Effects[K].m_fBase -= ((m_BaseValues[modIndex] * (modEffect.m_fBase / 100.0000000)) * stackMultiplier);
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                                ++K;
                                                // [Loop Continue]
                                                goto J0xD46;
                                            }
                                        }
                                    }
                                }
                            }
                            ++J;
                            // [Loop Continue]
                            goto J0x25B;
                        }
                    }
                }
                ++I;
                // [Loop Continue]
                goto J0x12C;
            }
        }        
    }
    else
    {
        // End:0x2447
        if(((deployOwner != none) && deployOwner.r_nDeployableId > 0) && deployOwner.Instigator != none)
        {
            PawnOwner = TgPawn(deployOwner.Instigator);
            // End:0x2447
            if((PawnOwner != none) && PawnOwner.r_EffectManager != none)
            {
                em = PawnOwner.r_EffectManager;
                I = 0;
                J0x1335:

                // End:0x2447 [Loop If]
                if(I < em.s_AppliedEffectGroups.Length)
                {
                    modEffectGroup = em.s_AppliedEffectGroups[I];
                    // End:0x13EB
                    if((modEffectGroup == none) || float(deployOwner.r_nDeployableId) != modEffectGroup.m_fPhysicalPowerScaling)
                    {                        
                    }
                    else
                    {
                        // End:0x1459
                        if((modEffectGroup.m_fMagicalPowerScaling > float(0)) && modEffectGroup.m_fMagicalPowerScaling != float(EffectGroup.m_nEffectGroupId))
                        {                            
                        }
                        else
                        {
                            J = 0;
                            J0x1464:

                            // End:0x2439 [Loop If]
                            if(J < modEffectGroup.m_Effects.Length)
                            {
                                modDeploy = TgEffectModifyDeployable(modEffectGroup.m_Effects[J]);
                                // End:0x14DE
                                if(modDeploy == none)
                                {                                    
                                }
                                else
                                {
                                    // End:0x1852
                                    if(modDeploy.m_nPropertyId == 1950)
                                    {
                                        modIndex = m_ModifiedEGLifetimes.Find(EffectGroup);
                                        // End:0x159A
                                        if(modIndex == -1)
                                        {
                                            m_ModifiedEGLifetimes.AddItem(EffectGroup);
                                            m_BaseLifetimes.AddItem(EffectGroup.m_fLifeTime);
                                            modIndex = m_ModifiedEGLifetimes.Find(EffectGroup);
                                        }
                                        // End:0x184F
                                        if(modIndex != -1)
                                        {
                                            // End:0x1625
                                            if(modEffectGroup.m_nNumMaxStacks > 0)
                                            {
                                                stackMultiplier = FClamp(float(modEffectGroup.m_nNumStacks), 1.0000000, float(modEffectGroup.m_nNumMaxStacks));                                                
                                            }
                                            else
                                            {
                                                stackMultiplier = FMax(float(modEffectGroup.m_nNumStacks), 1.0000000);
                                            }
                                            // End:0x16C7
                                            if(modDeploy.m_nCalcMethodCode == 67)
                                            {
                                                EffectGroup.m_fLifeTime += (modDeploy.m_fBase * stackMultiplier);                                                
                                            }
                                            else
                                            {
                                                // End:0x1738
                                                if(modDeploy.m_nCalcMethodCode == 70)
                                                {
                                                    EffectGroup.m_fLifeTime -= (modDeploy.m_fBase * stackMultiplier);                                                    
                                                }
                                                else
                                                {
                                                    // End:0x17C5
                                                    if(modDeploy.m_nCalcMethodCode == 68)
                                                    {
                                                        EffectGroup.m_fLifeTime += ((m_BaseLifetimes[modIndex] * (modDeploy.m_fBase / 100.0000000)) * stackMultiplier);                                                        
                                                    }
                                                    else
                                                    {
                                                        // End:0x184F
                                                        if(modDeploy.m_nCalcMethodCode == 69)
                                                        {
                                                            EffectGroup.m_fLifeTime -= ((m_BaseLifetimes[modIndex] * (modDeploy.m_fBase / 100.0000000)) * stackMultiplier);
                                                        }
                                                    }
                                                }
                                            }
                                        }                                        
                                    }
                                    else
                                    {
                                        // End:0x1BC6
                                        if(modDeploy.m_nPropertyId == 1951)
                                        {
                                            modIndex = m_ModifiedEGAppValues.Find(EffectGroup);
                                            // End:0x190E
                                            if(modIndex == -1)
                                            {
                                                m_ModifiedEGAppValues.AddItem(EffectGroup);
                                                m_BaseAppValues.AddItem(EffectGroup.m_fApplicationValue);
                                                modIndex = m_ModifiedEGAppValues.Find(EffectGroup);
                                            }
                                            // End:0x1BC3
                                            if(modIndex != -1)
                                            {
                                                // End:0x1999
                                                if(modEffectGroup.m_nNumMaxStacks > 0)
                                                {
                                                    stackMultiplier = FClamp(float(modEffectGroup.m_nNumStacks), 1.0000000, float(modEffectGroup.m_nNumMaxStacks));                                                    
                                                }
                                                else
                                                {
                                                    stackMultiplier = FMax(float(modEffectGroup.m_nNumStacks), 1.0000000);
                                                }
                                                // End:0x1A3B
                                                if(modDeploy.m_nCalcMethodCode == 67)
                                                {
                                                    EffectGroup.m_fApplicationValue += (modDeploy.m_fBase * stackMultiplier);                                                    
                                                }
                                                else
                                                {
                                                    // End:0x1AAC
                                                    if(modDeploy.m_nCalcMethodCode == 70)
                                                    {
                                                        EffectGroup.m_fApplicationValue -= (modDeploy.m_fBase * stackMultiplier);                                                        
                                                    }
                                                    else
                                                    {
                                                        // End:0x1B39
                                                        if(modDeploy.m_nCalcMethodCode == 68)
                                                        {
                                                            EffectGroup.m_fApplicationValue += ((m_BaseAppValues[modIndex] * (modDeploy.m_fBase / 100.0000000)) * stackMultiplier);                                                            
                                                        }
                                                        else
                                                        {
                                                            // End:0x1BC3
                                                            if(modDeploy.m_nCalcMethodCode == 69)
                                                            {
                                                                EffectGroup.m_fApplicationValue -= ((m_BaseAppValues[modIndex] * (modDeploy.m_fBase / 100.0000000)) * stackMultiplier);
                                                            }
                                                        }
                                                    }
                                                }
                                            }                                            
                                        }
                                        else
                                        {
                                            // End:0x1F44
                                            if(modDeploy.m_nPropertyId == 1989)
                                            {
                                                modIndex = m_ModifiedEGMaxStacks.Find(EffectGroup);
                                                // End:0x1C84
                                                if(modIndex == -1)
                                                {
                                                    m_ModifiedEGMaxStacks.AddItem(EffectGroup);
                                                    m_BaseMaxStacks.AddItem(float(EffectGroup.m_nNumMaxStacks));
                                                    modIndex = m_ModifiedEGMaxStacks.Find(EffectGroup);
                                                }
                                                // End:0x1F41
                                                if(modIndex != -1)
                                                {
                                                    // End:0x1D0F
                                                    if(modEffectGroup.m_nNumMaxStacks > 0)
                                                    {
                                                        stackMultiplier = FClamp(float(modEffectGroup.m_nNumStacks), 1.0000000, float(modEffectGroup.m_nNumMaxStacks));                                                        
                                                    }
                                                    else
                                                    {
                                                        stackMultiplier = FMax(float(modEffectGroup.m_nNumStacks), 1.0000000);
                                                    }
                                                    // End:0x1DB3
                                                    if(modDeploy.m_nCalcMethodCode == 67)
                                                    {
                                                        EffectGroup.m_nNumMaxStacks += int(modDeploy.m_fBase * stackMultiplier);                                                        
                                                    }
                                                    else
                                                    {
                                                        // End:0x1E26
                                                        if(modDeploy.m_nCalcMethodCode == 70)
                                                        {
                                                            EffectGroup.m_nNumMaxStacks -= int(modDeploy.m_fBase * stackMultiplier);                                                            
                                                        }
                                                        else
                                                        {
                                                            // End:0x1EB5
                                                            if(modDeploy.m_nCalcMethodCode == 68)
                                                            {
                                                                EffectGroup.m_nNumMaxStacks += int((m_BaseMaxStacks[modIndex] * (modDeploy.m_fBase / 100.0000000)) * stackMultiplier);                                                                
                                                            }
                                                            else
                                                            {
                                                                // End:0x1F41
                                                                if(modDeploy.m_nCalcMethodCode == 69)
                                                                {
                                                                    EffectGroup.m_nNumMaxStacks -= int((m_BaseMaxStacks[modIndex] * (modDeploy.m_fBase / 100.0000000)) * stackMultiplier);
                                                                }
                                                            }
                                                        }
                                                    }
                                                }                                                
                                            }
                                            else
                                            {
                                                K = 0;
                                                J0x1F4F:

                                                // End:0x242B [Loop If]
                                                if(K < EffectGroup.m_Effects.Length)
                                                {
                                                    // End:0x241D
                                                    if(EffectGroup.m_Effects[K].m_nPropertyId == modDeploy.m_nPropertyId)
                                                    {
                                                        modIndex = m_ModifiedEffects.Find(EffectGroup.m_Effects[K]);
                                                        // End:0x20EC
                                                        if(modIndex == -1)
                                                        {
                                                            m_ModifiedEffects.AddItem(EffectGroup.m_Effects[K]);
                                                            m_BaseValues.AddItem(EffectGroup.m_Effects[K].m_fBase);
                                                            modIndex = m_ModifiedEffects.Find(EffectGroup.m_Effects[K]);
                                                        }
                                                        // End:0x241D
                                                        if(modIndex != -1)
                                                        {
                                                            // End:0x2177
                                                            if(modEffectGroup.m_nNumMaxStacks > 0)
                                                            {
                                                                stackMultiplier = FClamp(float(modEffectGroup.m_nNumStacks), 1.0000000, float(modEffectGroup.m_nNumMaxStacks));                                                                
                                                            }
                                                            else
                                                            {
                                                                stackMultiplier = FMax(float(modEffectGroup.m_nNumStacks), 1.0000000);
                                                            }
                                                            // End:0x2238
                                                            if(modDeploy.m_nCalcMethodCode == 67)
                                                            {
                                                                EffectGroup.m_Effects[K].m_fBase += (modDeploy.m_fBase * stackMultiplier);                                                                
                                                            }
                                                            else
                                                            {
                                                                // End:0x22C8
                                                                if(modDeploy.m_nCalcMethodCode == 70)
                                                                {
                                                                    EffectGroup.m_Effects[K].m_fBase -= (modDeploy.m_fBase * stackMultiplier);                                                                    
                                                                }
                                                                else
                                                                {
                                                                    // End:0x2374
                                                                    if(modDeploy.m_nCalcMethodCode == 68)
                                                                    {
                                                                        EffectGroup.m_Effects[K].m_fBase += ((m_BaseValues[modIndex] * (modDeploy.m_fBase / 100.0000000)) * stackMultiplier);                                                                        
                                                                    }
                                                                    else
                                                                    {
                                                                        // End:0x241D
                                                                        if(modDeploy.m_nCalcMethodCode == 69)
                                                                        {
                                                                            EffectGroup.m_Effects[K].m_fBase -= ((m_BaseValues[modIndex] * (modDeploy.m_fBase / 100.0000000)) * stackMultiplier);
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                    ++K;
                                                    // [Loop Continue]
                                                    goto J0x1F4F;
                                                }
                                            }
                                        }
                                    }
                                }
                                ++J;
                                // [Loop Continue]
                                goto J0x1464;
                            }
                        }
                    }
                    ++I;
                    // [Loop Continue]
                    goto J0x1335;
                }
            }
        }
    }
    //return;    
}

function RemoveModifyEffects()
{
    local int I;

    I = m_ModifiedEffects.Length - 1;
    J0x17:

    // End:0xB3 [Loop If]
    if(I >= 0)
    {
        // End:0x7B
        if(m_ModifiedEffects[I] != none)
        {
            m_ModifiedEffects[I].m_fBase = m_BaseValues[I];
        }
        m_ModifiedEffects.Remove(I, 1);
        m_BaseValues.Remove(I, 1);
        --I;
        // [Loop Continue]
        goto J0x17;
    }
    I = m_ModifiedEGLifetimes.Length - 1;
    J0xCA:

    // End:0x166 [Loop If]
    if(I >= 0)
    {
        // End:0x12E
        if(m_ModifiedEGLifetimes[I] != none)
        {
            m_ModifiedEGLifetimes[I].m_fLifeTime = m_BaseLifetimes[I];
        }
        m_ModifiedEGLifetimes.Remove(I, 1);
        m_BaseLifetimes.Remove(I, 1);
        --I;
        // [Loop Continue]
        goto J0xCA;
    }
    I = m_ModifiedEGAppValues.Length - 1;
    J0x17D:

    // End:0x219 [Loop If]
    if(I >= 0)
    {
        // End:0x1E1
        if(m_ModifiedEGAppValues[I] != none)
        {
            m_ModifiedEGAppValues[I].m_fApplicationValue = m_BaseAppValues[I];
        }
        m_ModifiedEGAppValues.Remove(I, 1);
        m_BaseAppValues.Remove(I, 1);
        --I;
        // [Loop Continue]
        goto J0x17D;
    }
    I = m_ModifiedEGMaxStacks.Length - 1;
    J0x230:

    // End:0x2CE [Loop If]
    if(I >= 0)
    {
        // End:0x296
        if(m_ModifiedEGMaxStacks[I] != none)
        {
            m_ModifiedEGMaxStacks[I].m_nNumMaxStacks = int(m_BaseAppValues[I]);
        }
        m_ModifiedEGMaxStacks.Remove(I, 1);
        m_BaseMaxStacks.Remove(I, 1);
        --I;
        // [Loop Continue]
        goto J0x230;
    }
    //return;    
}

simulated function DisplayMessage(string sMessage)
{
    // End:0xD0
    if((m_Owner.Instigator != none) && m_Owner.Instigator.Controller.IsA('PlayerController'))
    {
        TgPlayerController(m_Owner.Instigator.Controller).ClientMessage(sMessage);
    }
    //return;    
}

event ApplyEffectType(Actor Target, int nEffectGroupType, optional ImpactInfo Impact, optional int StackCount = 1)
{
    local int nIndex;
    local TgEffectGroup theEffectGroup;

    Impact.HitActor = Target;
    nIndex = 0;
    J0x37:

    // End:0xB6 [Loop If]
    if(nIndex >= 0)
    {
        theEffectGroup = GetEffectGroup(nEffectGroupType, nIndex);
        // End:0xA5
        if(theEffectGroup != none)
        {
            SubmitEffect(Impact, theEffectGroup, false, StackCount);            
        }
        else
        {
            // [Explicit Break]
            goto J0xB6;
        }
        nIndex++;
        // [Loop Continue]
        goto J0x37;
    }
    J0xB6:

    //return;    
}

event RemoveEffectType(Actor Target, bool bForceRemove, int nEffectGroupType, optional int StackCount = 1)
{
    local ImpactInfo Impact;
    local int nIndex;
    local TgEffectGroup theEffectGroup;

    Impact.HitActor = Target;
    nIndex = 0;
    J0x36:

    // End:0xE6 [Loop If]
    if(nIndex >= 0)
    {
        theEffectGroup = GetEffectGroup(nEffectGroupType, nIndex);
        // End:0xD5
        if(theEffectGroup != none)
        {
            // End:0xD2
            if(theEffectGroup.m_bIsManaged || bForceRemove)
            {
                SubmitEffect(Impact, theEffectGroup, true, StackCount);
            }            
        }
        else
        {
            // [Explicit Break]
            goto J0xE6;
        }
        nIndex++;
        // [Loop Continue]
        goto J0x36;
    }
    J0xE6:

    //return;    
}

event ApplyHitSpecial(Actor Target, optional ImpactInfo Impact, optional int nHitSpecialSituationalType = 0, optional int StackCount = 1)
{
    local TgPawn HittingPawn;
    local TgDeployable Deploy;
    local int nIndex;
    local TgEffectGroup theEffectGroup;

    Impact.HitActor = Target;
    nIndex = 0;
    J0x3C:

    // End:0x12F [Loop If]
    if(nIndex >= 0)
    {
        theEffectGroup = GetEffectGroup(10681, nIndex);
        // End:0x11E
        if(theEffectGroup != none)
        {
            // End:0x11B
            if((theEffectGroup != none) && theEffectGroup.m_nHitSpecialSituationalType == nHitSpecialSituationalType)
            {
                theEffectGroup.m_fPercAbsorbedDamage = Impact.PercAbsorbedDamage;
                SubmitEffect(Impact, theEffectGroup, false, StackCount);
            }            
        }
        else
        {
            // [Explicit Break]
            goto J0x12F;
        }
        nIndex++;
        // [Loop Continue]
        goto J0x3C;
    }
    J0x12F:

    nIndex = 0;
    J0x13A:

    // End:0x22D [Loop If]
    if(nIndex >= 0)
    {
        theEffectGroup = GetEffectGroup(10036, nIndex);
        // End:0x21C
        if(theEffectGroup != none)
        {
            // End:0x219
            if((theEffectGroup != none) && theEffectGroup.m_nHitSpecialSituationalType == nHitSpecialSituationalType)
            {
                theEffectGroup.m_fPercAbsorbedDamage = Impact.PercAbsorbedDamage;
                SubmitEffect(Impact, theEffectGroup, false, StackCount);
            }            
        }
        else
        {
            // [Explicit Break]
            goto J0x22D;
        }
        nIndex++;
        // [Loop Continue]
        goto J0x13A;
    }
    J0x22D:

    HittingPawn = TgPawn(m_Owner.Instigator);
    // End:0x3D4
    if(HittingPawn != none)
    {
        // End:0x2CB
        if(TgDevice(m_Owner) != none)
        {
            HittingPawn.DeviceOnHitSpecial(TgDevice(m_Owner), Impact, nHitSpecialSituationalType);            
        }
        else
        {
            // End:0x3D4
            if(TgDeployable(m_Owner) != none)
            {
                Deploy = TgDeployable(m_Owner);
                // End:0x3D4
                if((Deploy.s_SpawnerDeviceMode != none) && TgDevice(Deploy.s_SpawnerDeviceMode.m_Owner) != none)
                {
                    HittingPawn.DeviceOnHitSpecial(TgDevice(Deploy.s_SpawnerDeviceMode.m_Owner), Impact, nHitSpecialSituationalType);
                }
            }
        }
    }
    //return;    
}

event RemoveHitSpecial(Actor Target, bool bForceRemove, optional int nHitSpecialSituationalType = 0, optional int StackCount = 1)
{
    local ImpactInfo Impact;
    local int nIndex;
    local TgEffectGroup theEffectGroup;

    Impact.HitActor = Target;
    nIndex = 0;
    J0x3B:

    // End:0x113 [Loop If]
    if(nIndex >= 0)
    {
        theEffectGroup = GetEffectGroup(10681, nIndex);
        // End:0x102
        if(theEffectGroup != none)
        {
            // End:0xFF
            if(theEffectGroup.m_nHitSpecialSituationalType == nHitSpecialSituationalType)
            {
                // End:0xFF
                if(theEffectGroup.m_bIsManaged || bForceRemove)
                {
                    SubmitEffect(Impact, theEffectGroup, true, StackCount);
                }
            }            
        }
        else
        {
            // [Explicit Break]
            goto J0x113;
        }
        nIndex++;
        // [Loop Continue]
        goto J0x3B;
    }
    J0x113:

    nIndex = 0;
    J0x11E:

    // End:0x1F6 [Loop If]
    if(nIndex >= 0)
    {
        theEffectGroup = GetEffectGroup(10036, nIndex);
        // End:0x1E5
        if(theEffectGroup != none)
        {
            // End:0x1E2
            if(theEffectGroup.m_nHitSpecialSituationalType == nHitSpecialSituationalType)
            {
                // End:0x1E2
                if(theEffectGroup.m_bIsManaged || bForceRemove)
                {
                    SubmitEffect(Impact, theEffectGroup, true, StackCount);
                }
            }            
        }
        else
        {
            // [Explicit Break]
            goto J0x1F6;
        }
        nIndex++;
        // [Loop Continue]
        goto J0x11E;
    }
    J0x1F6:

    //return;    
}

function TrackDeviceModeHit(TgPawn Hitter, float fDistance, bool bHitPlayer)
{
    local TgPawn ResponsiblePawn;
    local int nDeviceModeID;

    // End:0x75
    if(Hitter.WasPlayerSpawned())
    {
        ResponsiblePawn = Hitter.r_Owner;
        nDeviceModeID = Hitter.s_nSpawnerDeviceModeId;        
    }
    else
    {
        // End:0xFC
        if((Hitter.Controller != none) && Hitter.Controller.IsA('TgPlayerController'))
        {
            ResponsiblePawn = Hitter;
            nDeviceModeID = m_nId;            
        }
        else
        {
            return;
        }
    }
    ResponsiblePawn.TrackHit(nDeviceModeID, fDistance, bHitPlayer);
    //return;    
}

event bool ApplyHit(ImpactInfo Impact, Actor DamageInstigator)
{
    local bool bHitPlayer;
    local TgPawn HittingPawn, TargetPawn;
    local KActor TargetKActor;
    local InterpActor TargetInterpActor;
    local TgDeployable Deploy;

    Impact.DeviceModeReference = self;
    TargetKActor = KActor(Impact.HitActor);
    // End:0x151
    if(TargetKActor != none)
    {
        // End:0x14F
        if(m_DamageTypeClass != none)
        {
            TargetKActor.OnWeaponHit(Impact, m_DamageTypeClass.default.KDamageImpulse);
            TargetKActor.TakeDamage(1, m_Owner.Instigator.Controller, Impact.HitLocation, Impact.RayDir, m_DamageTypeClass,, DamageInstigator);
        }
        return true;
    }
    TargetInterpActor = InterpActor(Impact.HitActor);
    // End:0x23E
    if(TargetInterpActor != none)
    {
        // End:0x23C
        if(m_DamageTypeClass != none)
        {
            TargetInterpActor.TakeDamage(1, m_Owner.Instigator.Controller, Impact.HitLocation, Impact.RayDir, m_DamageTypeClass,, DamageInstigator);
        }
        return true;
    }
    TargetPawn = TgPawn(Impact.HitActor);
    bHitPlayer = ((TargetPawn != none) && TargetPawn.Controller != none) && TargetPawn.Controller.IsA('TgPlayerController');
    HittingPawn = TgPawn(m_Owner.Instigator);
    // End:0x3BC
    if(DamageInstigator.IsA('TgProjectile') && HittingPawn != none)
    {
        TrackDeviceModeHit(HittingPawn, VSize(HittingPawn.Location - Impact.HitActor.Location), bHitPlayer);        
    }
    else
    {
        // End:0x458
        if(DamageInstigator.IsA('TgPawn'))
        {
            TrackDeviceModeHit(TgPawn(DamageInstigator), VSize(DamageInstigator.Location - Impact.HitActor.Location), bHitPlayer);
        }
    }
    SubmitHitEffects(DamageInstigator, Impact, 264);
    // End:0x4D7
    if(m_Owner.Instigator != none)
    {
        HandleSuccessfulHit(DamageInstigator, m_Owner.Instigator, Impact);
    }
    // End:0x63B
    if(HittingPawn != none)
    {
        // End:0x53B
        if(TgDevice(m_Owner) != none)
        {
            HittingPawn.DeviceOnHit(TgDevice(m_Owner), Impact);            
        }
        else
        {
            // End:0x63B
            if(TgDeployable(m_Owner) != none)
            {
                Deploy = TgDeployable(m_Owner);
                // End:0x63B
                if((Deploy.s_SpawnerDeviceMode != none) && TgDevice(Deploy.s_SpawnerDeviceMode.m_Owner) != none)
                {
                    HittingPawn.DeviceOnHit(TgDevice(Deploy.s_SpawnerDeviceMode.m_Owner), Impact);
                }
            }
        }
    }
    return true;
    //return ReturnValue;    
}

function HandleMiss()
{
    local TgDevice Dev;
    local TgPawn_Character TgP;

    Dev = TgDevice(m_Owner);
    // End:0x93
    if(Dev != none)
    {
        TgP = TgPawn_Character(m_Owner.Instigator);
        // End:0x93
        if(TgP != none)
        {
            TgP.DeviceOnMiss(Dev);
        }
    }
    //return;    
}

function HandleSuccessfulHit(Actor DamageInstigator, Pawn OwnerInstigator, ImpactInfo Impact)
{
    local ImpactInfo OwnerImpact;

    OwnerImpact = Impact;
    OwnerImpact.HitActor = OwnerInstigator;
    OwnerImpact.HitLocation = OwnerInstigator.Location;
    SubmitHitEffects(DamageInstigator, OwnerImpact, 759);
    //return;    
}

function SubmitHitEffects(Actor DamageInstigator, ImpactInfo Impact, int nType)
{
    local int nIndex;
    local TgEffectGroup theEffectGroup;

    nIndex = 0;
    J0x0B:

    // End:0xBD [Loop If]
    if(nIndex >= 0)
    {
        theEffectGroup = GetEffectGroup(nType, nIndex);
        // End:0xAC
        if(theEffectGroup != none)
        {
            theEffectGroup.m_fPercAbsorbedDamage = Impact.PercAbsorbedDamage;
            SubmitEffect(Impact, theEffectGroup);            
        }
        else
        {
            // [Explicit Break]
            goto J0xBD;
        }
        nIndex++;
        // [Loop Continue]
        goto J0x0B;
    }
    J0xBD:

    //return;    
}

event SubmitFinalBlowEffects(Actor DamageInstigator, ImpactInfo Impact)
{
    SubmitHitEffects(DamageInstigator, Impact, 10575);
    //return;    
}

simulated event float GetRefireTime()
{
    // End:0x3D
    if(m_Owner.IsA('TgDevice'))
    {
        return (GetPreHitDelay()) + (GetPostHitDelay());        
    }
    else
    {
        return m_fFireTime;
    }
    //return ReturnValue;    
}

simulated event float GetBuildupTime()
{
    return m_fBuildupTime;
    //return ReturnValue;    
}

simulated event float GetPreHitDelay()
{
    return m_fFirePreHitDelay;
    //return ReturnValue;    
}

simulated event float GetPostHitDelay()
{
    local TgDevice DeviceOwner;

    DeviceOwner = TgDevice(m_Owner);
    // End:0x7E
    if((DeviceOwner != none) && DeviceOwner.m_bUsesBurstFire)
    {
        // End:0x7E
        if(DeviceOwner.m_nBurstShotsRemaining > 1)
        {
            return GetCustomValue1();
        }
    }
    return m_fFirePostHitDelay;
    //return ReturnValue;    
}

simulated event float GetFireLockTime()
{
    return m_fFireLockTime;
    //return ReturnValue;    
}

simulated event float GetCooldownTime()
{
    local TgPawn P;
    local TgDevice D;
    local TgAIController_Behavior aic;
    local float fCooldownTime;

    fCooldownTime = GetPropertyValue(4);
    D = TgDevice(m_Owner);
    // End:0x10D
    if(D != none)
    {
        // End:0x10D
        if(D.IsOffhand())
        {
            P = TgPawn(m_Owner.Instigator);
            // End:0x10D
            if(P != none)
            {
                aic = TgAIController_Behavior(P.Controller);
                // End:0x10D
                if(aic != none)
                {
                    fCooldownTime *= aic.GetCooldownModifier();
                }
            }
        }
    }
    return fCooldownTime;
    //return ReturnValue;    
}

simulated event float GetMinCooldownTime()
{
    local TgProperty CooldownProp;

    CooldownProp = GetProperty(4);
    return ((CooldownProp != none) ? CooldownProp.m_fMinimum : 0.0000000);
    //return ReturnValue;    
}

simulated event float GetContagiousRadius()
{
    local float fRadius;

    fRadius = GetPropertyValue(312);
    fRadius = fRadius * float(16);
    return fRadius;
    //return ReturnValue;    
}

simulated event float GetConeAttackAngle()
{
    return Abs(GetPropertyValue(64));
    //return ReturnValue;    
}

simulated event float GetSignedConeAttackAngle()
{
    return GetPropertyValue(64);
    //return ReturnValue;    
}

simulated event float GetConeAttackAngleOffset()
{
    return GetPropertyValue(1627);
    //return ReturnValue;    
}

event int GetNumArcJumps()
{
    return m_nArcingJumps;
    //return ReturnValue;    
}

simulated function bool CanSimulateTeleportFire()
{
    return true;
    //return ReturnValue;    
}

defaultproperties
{
    m_bCanTriggerCounter=true
    m_bEnchroachmentFireLOSCheck=true
    m_bCanTargetStealthedTargets=true
    m_nShotsPerFire=1
    m_nAmmoCostPerShot=1
    m_vActorEncroachmentBaseScale=(X=1.0000000,Y=1.0000000,Z=1.0000000)
}