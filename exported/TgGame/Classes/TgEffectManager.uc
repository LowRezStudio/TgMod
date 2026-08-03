class TgEffectManager extends Actor
    native(Effects)
    nativereplication
    notplaceable
    hidecategories(Navigation);

const TGEA_MAX_EFFECTS = 16;
const TGEA_MAX_EFFECTS_QUEUE = 16;
const TGEGS_EMPTY = 0;
const TGEGS_ACTIVE_REP = 1;
const TGEGS_ACTIVE = 2;
const TGEGS_FLASH_REP = 3;
const TGEGS_EMPTY_REP = 4;
const REFRESH_NONE = 0;
const REFRESH_REUSE = 1;
const REFRESH_ADD = 2;
const AIE_DAMAGE = 0;
const AIE_HEALTH = 1;
const AIE_MANA = 2;
const AIE_STASIS = 4;
const AIE_STUN = 5;
const AIE_PROPERTY = 6;
const AIE_PROPERTY_PERC = 7;
const AIE_ENERGY = 8;
const AIE_STUN_PROXY_EFFECT_GROUP_ID = 33431;
const CONTRIBUTION_BUFFER = 0.75f;
const CONTRIBUTION_BUFFEE = 0.25f;
const TG_DEFAULTSPAWNGUARDTIME = 3.0f;
const WALL_STUN_CHECK_HEIGHT = 62.0f;
const WALL_STUN_CHECK_DISTANCE = 96.0f;

enum EDiminshingReturnsStackType
{
    DRST_None,                      // 0
    DRST_CrowdControl,              // 1
    DRST_SuperiorCrowdControl,      // 2
    DRST_Stun,                      // 3
    DRST_MAX                        // 4
};

struct native EffectQueueEntry
{
    var int nEffectGroupID;
    var int nExtraInfo;
    var Vector vHitLocation;
    var Rotator rHitNormal;

    structdefaultproperties
    {
        nEffectGroupID=0
        nExtraInfo=0
        vHitLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        rHitNormal=(Pitch=0,Yaw=0,Roll=0)
    }
};

struct native EffectListEntry
{
    var int nEffectGroupID;
    var byte byNumStacks;
    var float fInitTimeRemaining;
    var int nExtraInfo;

    structdefaultproperties
    {
        nEffectGroupID=0
        byNumStacks=0
        fInitTimeRemaining=0.0000000
        nExtraInfo=0
    }
};

struct native StunStackEntry
{
    var TgEffect Effect;
    var Controller.EStunType StunType;

    structdefaultproperties
    {
        Effect=none
        StunType=EStunType.STUN_TYPE_NONE
    }
};

struct native EnergyStunStackEntry
{
    var TgEffect Effect;

    structdefaultproperties
    {
        Effect=none
    }
};

struct native ReduceActiveCooldownEntry
{
    var int nDeviceId;
    var float fValue;
    var bool bPercent;
    var float fApplicationTime;
    var float fCooldownFloor;

    structdefaultproperties
    {
        nDeviceId=0
        fValue=0.0000000
        bPercent=false
        fApplicationTime=0.0000000
        fCooldownFloor=0.0000000
    }
};

struct native DiminishingReturnsStackInfo
{
    var TgEffectManager.EDiminshingReturnsStackType StackType;
    var init array<init int> DevicesApplyingThisTick;
    var init array<init float> Timestamps;
    var int nStackCount;
    var float fRelevancyTime;

    structdefaultproperties
    {
        StackType=EDiminshingReturnsStackType.DRST_None
        DevicesApplyingThisTick=none
        Timestamps=none
        nStackCount=0
        fRelevancyTime=7.0000000
    }
};

var repnotify EffectListEntry r_ManagedEffectList[16];
var byte c_byCounterList[16];
var Controller.EStunType s_eCachedStunType;
var float m_fTimeRemaining[16];
var TgEffectForm c_Forms[16];
var bool c_ActiveTimers;
var repnotify bool r_bRelevancyNotify;
var EffectQueueEntry r_EventQueue[16];
var repnotify int r_nNextQueueIndex;
var repnotify int r_nFirstValidQueueIndex;
var int c_nLastQueueIndex;
var array<TgEffectGroup> s_AppliedEffectGroups;
var repnotify Actor r_Owner;
var TgEffectGroup m_ApplyDamageEffectGroup;
var TgEffect m_ApplyDamageEffect;
var TgEffectGroup m_ApplyHealthEffectGroup;
var TgEffect m_ApplyHealthEffect;
var TgEffectGroup m_ApplyManaEffectGroup;
var TgEffect m_ApplyManaEffect;
var TgEffectGroup m_ApplyEnergyEffectGroup;
var TgEffect m_ApplyEnergyEffect;
var array<StunStackEntry> s_StunStack;
var array<EnergyStunStackEntry> s_EnergyStunStack;
var array<ReduceActiveCooldownEntry> s_ReduceActiveCooldownEffects;
var float m_fMaxReduceActiveCooldownDelay;
var int s_nSilenceCount;
var int s_nDisarmCount;
var int s_nCrippleCount;
var int s_nStealthCount;
var int s_nDazeCount;
var int s_nMarkedCount;
var int s_nSlowCount;
var int s_bStealthDisabledCount;
var int s_nOnFireCount;
var int s_nCCImmuneCount;
var int s_nBleedingCount;
var int s_nKnockbackCount;
var int s_nRootCount;
var int s_nPoisonedCount;
var int s_nBoostCount;
var int s_nStealthInCombatCount;
var int s_nWallHackCount;
var int s_nForceOutOfCombatCount;
var int s_nPolymorphCount;
var int s_nRevealedCount;
var int s_nFlashCount;
var float s_fSpawnGuardTime;
var array<Actor> s_InstigatorWallReveals;
var array<int> s_nInstigatorWallRevealCount;
var array<Actor> s_InstigatorStealthReveals;
var array<int> s_nInstigatorStealthRevealCount;
var array<TgEffect> s_SlowCaps;
var array<TgEffect> s_MaxHPDamageCaps;
var array<TgEffect> s_CurHPDamageCaps;
var int s_FreezeBehaviorCount;
var array<DiminishingReturnsStackInfo> s_DiminishingReturnsStacks;
var const int m_nDiminishingReturnMaxStacks;
var array<TgEffectGroup> s_ActiveDamageDeviceIntercepts;
var array<TgEffectGroup> s_ActiveDamageMitigationIntercepts;
var array<TgEffectGroup> s_ActiveOnLandedIntercepts;
var array<TgEffectGroup> s_ActiveWallStuns;

replication
{
    // Pos:0x000
    if(((int(Role) == int(ROLE_Authority)) && !bDemoRecording) && (bNetInitial || bNetTimelapseInit) || bNetTimelapsePost)
        r_nFirstValidQueueIndex;

    // Pos:0x04F
    if((int(Role) == int(ROLE_Authority)) && bDemoRecording || !(bNetInitial || bNetTimelapseInit) || bNetTimelapsePost)
        r_EventQueue, r_nNextQueueIndex;

    // Pos:0x09E
    if(int(Role) == int(ROLE_Authority))
        r_ManagedEffectList, r_Owner, 
        r_bRelevancyNotify;
}

// Export UTgEffectManager::execSetEffectRep(FFrame&, void* const)
native function int SetEffectRep(TgEffectGroup eg, int nSkinId);

// Export UTgEffectManager::execUpdateEffectRep(FFrame&, void* const)
native function UpdateEffectRep(TgEffectGroup eg);

// Export UTgEffectManager::execClearEffectRep(FFrame&, void* const)
native function ClearEffectRep(TgEffectGroup Group);

// Export UTgEffectManager::execUpdateEffectForms(FFrame&, void* const)
native function UpdateEffectForms();

// Export UTgEffectManager::execUpdateQueueEffectForms(FFrame&, void* const)
native function UpdateQueueEffectForms();

// Export UTgEffectManager::execUpdateManagedEffectForms(FFrame&, void* const)
native function UpdateManagedEffectForms();

// Export UTgEffectManager::execRemoveEffectGroupById(FFrame&, void* const)
native function bool RemoveEffectGroupById(int nEffectGroupID, optional int nNumStacks = 0, const optional Actor theInstigator);

// Export UTgEffectManager::execRemoveEffectGroupsByCategory(FFrame&, void* const)
native function bool RemoveEffectGroupsByCategory(int nCategoryCode, optional int nNumStacks = 0, const optional Actor theInstigator);

// Export UTgEffectManager::execRemoveAllEffectGroups(FFrame&, void* const)
native function bool RemoveAllEffectGroups(TgEffectGroup eg);

// Export UTgEffectManager::execResetEffectGroupLifeTimeById(FFrame&, void* const)
native function bool ResetEffectGroupLifeTimeById(int nEffectGroupID, float Lifetime);

// Export UTgEffectManager::execResetEffectGroupLifeTimeByCategory(FFrame&, void* const)
native function bool ResetEffectGroupLifeTimeByCategory(int nCategoryCode, float Lifetime);

// Export UTgEffectManager::execRemoveAllDebuff(FFrame&, void* const)
native function RemoveAllDebuff();

// Export UTgEffectManager::execRemoveAllSuperiorCrowdControl(FFrame&, void* const)
native function RemoveAllSuperiorCrowdControl();

// Export UTgEffectManager::execRemoveAllCrowdControl(FFrame&, void* const)
native function RemoveAllCrowdControl();

// Export UTgEffectManager::execIsStrongest(FFrame&, void* const)
native function bool IsStrongest(TgEffectGroup eg, bool bConsiderLifetime, out TgEffectGroup prevStrongest);

// Export UTgEffectManager::execGetNextStrongest(FFrame&, void* const)
native function TgEffectGroup GetNextStrongest(TgEffectGroup eg);

// Export UTgEffectManager::execRemoveAllEffects(FFrame&, void* const)
native function RemoveAllEffects();

// Export UTgEffectManager::execRemoveAllEffectsOnDeath(FFrame&, void* const)
native function RemoveAllEffectsOnDeath();

// Export UTgEffectManager::execRemoveAllStealthEffects(FFrame&, void* const)
native function RemoveAllStealthEffects();

// Export UTgEffectManager::execRemoveAllMesmerizeEffects(FFrame&, void* const)
native function RemoveAllMesmerizeEffects();

// Export UTgEffectManager::execGetEffectGroup(FFrame&, void* const)
native function TgEffectGroup GetEffectGroup(int nEffectGroupID, const optional Actor theInstigator);

// Export UTgEffectManager::execGetEffectGroupByCategory(FFrame&, void* const)
native function TgEffectGroup GetEffectGroupByCategory(int nCategoryCode, const optional Actor theInstigator);

// Export UTgEffectManager::execUpdateEffectFormVisibility(FFrame&, void* const)
native function UpdateEffectFormVisibility();

// Export UTgEffectManager::execClearAllClientEffectForms(FFrame&, void* const)
native function ClearAllClientEffectForms();

// Export UTgEffectManager::execIsSpawnGuarded(FFrame&, void* const)
native function bool IsSpawnGuarded();

// Export UTgEffectManager::execIsStunned(FFrame&, void* const)
native function bool IsStunned();

// Export UTgEffectManager::execIsSlowed(FFrame&, void* const)
native function bool IsSlowed();

// Export UTgEffectManager::execIsDazed(FFrame&, void* const)
native function bool IsDazed();

// Export UTgEffectManager::execRecalculateFx(FFrame&, void* const)
native function RecalculateFx();

// Export UTgEffectManager::execRecalculateBeltFx(FFrame&, void* const)
native function RecalculateBeltFx();

// Export UTgEffectManager::execHandleOnLandedIntercepts(FFrame&, void* const)
native function HandleOnLandedIntercepts();

// Export UTgEffectManager::execApplyDamage(FFrame&, void* const)
native function ApplyDamage(int nDamage, optional Actor aInstigator, optional int nAttackType, optional int nDamageType, optional ImpactInfo Impact, optional int nEffectGroupCategory);

// Export UTgEffectManager::execApplyHealth(FFrame&, void* const)
native function ApplyHealth(int nHealth, optional Actor aInstigator, optional int nAttackType, optional int nDamageType, optional ImpactInfo Impact, optional int nEffectGroupCategory);

// Export UTgEffectManager::execApplyMana(FFrame&, void* const)
native function ApplyMana(int nMana, optional Actor aInstigator, optional int nAttackType, optional int nDamageType, optional ImpactInfo Impact, optional int nEffectGroupCategory);

// Export UTgEffectManager::execApplyEnergy(FFrame&, void* const)
native function ApplyEnergy(int nEnergy, optional Actor aInstigator, optional int nAttackType, optional int nDamageType, optional ImpactInfo Impact, optional int nEffectGroupCategory);

// Export UTgEffectManager::execApplyStun(FFrame&, void* const)
native function ApplyStun(float fDuration, optional Actor aInstigator, optional int nAttackType, optional int nDamageType, optional ImpactInfo Impact, optional Controller.EStunType StunType);

// Export UTgEffectManager::execApplySpawnGuard(FFrame&, void* const)
native function ApplySpawnGuard();

// Export UTgEffectManager::execRemoveSpawnGuard(FFrame&, void* const)
native function RemoveSpawnGuard();

// Export UTgEffectManager::execApplyStasis(FFrame&, void* const)
native function ApplyStasis(int nValue, optional Actor aInstigator, optional int nAttackType, optional int nDamageType, optional ImpactInfo Impact, optional int nEffectGroupCategory);

// Export UTgEffectManager::execReduceActiveCooldown(FFrame&, void* const)
native function ReduceActiveCooldown(ReduceActiveCooldownEntry effectEntry, optional bool bInitialApplication = true);

// Export UTgEffectManager::execAddDelayedReduceActiveCooldownEffect(FFrame&, void* const)
native function AddDelayedReduceActiveCooldownEffect(ReduceActiveCooldownEntry effectEntry);

// Export UTgEffectManager::execRemoveDelayedReduceActiveCooldownEffect(FFrame&, void* const)
native function RemoveDelayedReduceActiveCooldownEffect(ReduceActiveCooldownEntry effectEntry);

// Export UTgEffectManager::execProcessReduceActiveCooldownEffects(FFrame&, void* const)
native function ProcessReduceActiveCooldownEffects();

// Export UTgEffectManager::execApplyProperty(FFrame&, void* const)
native function TgEffectGroup ApplyProperty(float nValue, int nPropId, optional Actor aInstigator, optional ImpactInfo Impact, optional int nCategory = 0, optional bool bApplyAsPercent = false);

// Export UTgEffectManager::execRemoveProperty(FFrame&, void* const)
native function RemoveProperty(TgEffectGroup EffectGroup);

// Export UTgEffectManager::execProcessEffect(FFrame&, void* const)
native function TgEffectGroup ProcessEffect(TgEffectGroup EffectGroup, optional Actor aInstigator, optional int nNumStacks = 1, optional ImpactInfo Impact);

// Export UTgEffectManager::execGetStackCountFromEffectGroupId(FFrame&, void* const)
native function int GetStackCountFromEffectGroupId(int nEffectGroupID, optional Actor aInstigator);

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    // End:0x5D
    if(int(Role) == int(ROLE_Authority))
    {
        r_bRelevancyNotify = true;
        // End:0x5D
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            UpdateEffectForms();
        }
    }
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x23
    if(VarName == 'r_nFirstValidQueueIndex')
    {
        UpdateFirstValidQueueIndex();
        return;
    }
    // End:0x53
    if(VarName == 'r_nNextQueueIndex')
    {
        // End:0x51
        if(r_bRelevancyNotify)
        {
            UpdateQueueEffectForms();
        }
        return;
    }
    // End:0x83
    if(VarName == 'r_ManagedEffectList')
    {
        // End:0x81
        if(r_bRelevancyNotify)
        {
            UpdateManagedEffectForms();
        }
        return;
    }
    // End:0xA6
    if(VarName == 'r_bRelevancyNotify')
    {
        UpdateEffectForms();
        return;
    }
    // End:0xE7
    if(VarName == 'r_Owner')
    {
        // End:0xE5
        if((r_Owner != none) && r_bRelevancyNotify)
        {
            UpdateEffectForms();
        }
        return;
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

simulated event UpdateFirstValidQueueIndex()
{
    c_nLastQueueIndex = r_nFirstValidQueueIndex - 1;
    //return;    
}

simulated event PostDemoRewind()
{
    ClearAllClientEffectForms();
    //return;    
}

function int ShieldTakeDamage(int nDamage)
{
    local TgEffectGroup eg;
    local bool bHasShieldSpecial;

    // End:0x15B
    if(nDamage > 0)
    {
        // End:0xCA
        foreach s_AppliedEffectGroups(eg)
        {
            // End:0xC9
            if(eg.HasShield())
            {
                // End:0xBD
                if(!eg.HasCategoryCode(15291))
                {
                    nDamage = int(eg.DamageShield(float(nDamage)));
                    // End:0xBA
                    if(nDamage <= 0)
                    {                        
                        return 0;
                    }                    
                }
                else
                {
                    bHasShieldSpecial = true;
                }
            }            
        }        
        // End:0x15B
        if(bHasShieldSpecial)
        {
            // End:0x15A
            foreach s_AppliedEffectGroups(eg)
            {
                // End:0x159
                if(eg.HasShield())
                {
                    nDamage = int(eg.DamageShield(float(nDamage)));
                    // End:0x159
                    if(nDamage <= 0)
                    {                        
                        return 0;
                    }
                }                
            }            
        }
    }
    return nDamage;
    //return ReturnValue;    
}

defaultproperties
{
    r_nNextQueueIndex=-1
    c_nLastQueueIndex=-1
    m_fMaxReduceActiveCooldownDelay=4.0000000
    s_DiminishingReturnsStacks[0]=(StackType=EDiminshingReturnsStackType.DRST_CrowdControl,DevicesApplyingThisTick=none,Timestamps=none,nStackCount=0,fRelevancyTime=7.0000000)
    s_DiminishingReturnsStacks[1]=(StackType=EDiminshingReturnsStackType.DRST_SuperiorCrowdControl,DevicesApplyingThisTick=none,Timestamps=none,nStackCount=0,fRelevancyTime=7.0000000)
    s_DiminishingReturnsStacks[2]=(StackType=EDiminshingReturnsStackType.DRST_Stun,DevicesApplyingThisTick=none,Timestamps=none,nStackCount=0,fRelevancyTime=7.0000000)
    m_nDiminishingReturnMaxStacks=3
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    bHidden=true
    bReplicateInstigator=true
    bReplicateMovement=false
    NetPriority=1.1000000
}