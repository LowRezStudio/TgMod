class TgEffectGroup extends Object
    native(Effects);

const TGEGT_STACKING = 155;
const TGEGT_STACKING_REFRESH = 15440;
const TGEGT_STRONGEST_WINS = 157;
const TGEGT_STRONGEST_MASKS = 15416;
const TGEGT_REFRESH = 10257;
const TGEGC_LOCAL = 302;
const TGEGC_REMOVE_EFFECT = 877;
const TGEGC_BLEEDING = 15026;
const TGEGC_CARD_EQUIP_STATS = 15373;
const TGEGC_CC_IMMUNE = 15053;
const TGEGC_CONFUSED = 15011;
const TGEGC_CRIPPLE = 10585;
const TGEGC_DAZE = 15009;
const TGEGC_DISARM = 10423;
const TGEGC_FEAR = 10051;
const TGEGC_FROZEN = 15017;
const TGEGC_JUMP_PENALTY = 11068;
const TGEGC_KNOCKBACK = 10052;
const TGEGC_KNOCKUP = 15014;
const TGEGC_MARKED = 15012;
const TGEGC_MARKED_WITH_UI = 15294;
const TGEGC_MOUNT_SPEED_BUFF = 15063;
const TGEGC_MOVEMENT_SPEED_BUFF = 15062;
const TGEGC_ON_FIRE = 10858;
const TGEGC_POISONED = 10859;
const TGEGC_POLYMORPH = 15051;
const TGEGC_REDUCED_HEALING = 15368;
const TGEGC_REVEALED = 15184;
const TGEGC_ROOT = 10050;
const TGEGC_SHIELD_SPECIAL = 15291;
const TGEGC_SILENCE = 10053;
const TGEGC_SLOW = 10048;
const TGEGC_STEALTH = 10863;
const TGEGC_STUN = 10049;
const TGEGC_STUN_TAUNT = 10649;
const TGEGC_WALLHACK = 10966;
const TGEGC_WEAKEN = 15071;
const TGEGC_LEX_REVEAL = 15506;
const TGEGC_SOUL_ORB_STACK = 15547;
const TGEGC_MESMERIZE = 16608;
const TGEGC_ASTRO_DOT = 16620;
const TGEGC_ASTRO_HEAL = 16627;
const TGEGC_ASTRO_BUFF = 16628;
const TGEGC_PRESENCE_DOT = 16637;
const TGEGC_FLASH_BANG = 16658;
const TGEGC_LIFT = 16657;
const TIMER_INTERVAL = 0;
const TIMER_LIFEDONE = 1;
const DEFAULT_MAX_EFFECT_STACKS = 100;
const TGST_HIGHEST_VALUE = 10130;
const TGST_IN_HAND = 10131;
const TGST_ITEM_POWER = 10552;
const TGST_TOTAL_POWER = 10553;
const TGST_BASE_POWER = 10625;
const TG_MESMERIZE_MIN_DURATION = 0.5f;

enum AttackType
{
    TGAT_None,                      // 0
    TGAT_Range,                     // 1
    TGAT_AOE,                       // 2
    TGAT_Falling,                   // 3
    TGAT_MAX                        // 4
};

struct native LifeTimeCalcInfo
{
    var bool bInitialized;
    var float fReductionFromPawnProtections;
    var float fReductionFromCCProtectionsPerc;
    var float fReductionFromDoTProtections;
    var float fReductionFromDoTProtectionsPerc;
    var int nCrowdControlCount;
    var bool bCrowdControlImmune;
    var float m_fCalculatedLifeTime;

    structdefaultproperties
    {
        bInitialized=false
        fReductionFromPawnProtections=0.0000000
        fReductionFromCCProtectionsPerc=0.0000000
        fReductionFromDoTProtections=0.0000000
        fReductionFromDoTProtectionsPerc=0.0000000
        nCrowdControlCount=0
        bCrowdControlImmune=false
        m_fCalculatedLifeTime=0.0000000
    }
};

var int m_nType;
var Actor m_Target;
var Actor m_Instigator;
var int m_nEffectGroupId;
var float m_fLifeTime;
var float m_fModLifeTime;
var float m_fLifeTimeIncreaseFromInstigator;
var float m_fApplyInterval;
var array<TgEffect> m_Effects;
var int m_nDamageType;
var TgEffectGroup.AttackType m_eAttackType;
var Controller.EStunType m_StunType;
var bool m_bIsManaged;
var bool m_bHasSlowEffect;
var bool m_bHasStealthEffect;
var bool m_bHasSlowToHaltEffect;
var bool m_bDoesDamage;
var bool m_bDoesDamageOverTime;
var bool m_bContagious;
var bool s_bActiveFlag;
var bool s_bCriticalHitFlag;
var bool m_bDeviceSpecificFlag;
var bool m_bHasVisual;
var float m_fPercAbsorbedDamage;
var int m_nApplicationType;
var float m_fApplicationValue;
var float m_fApplicationChance;
var int m_nApplicationCategoryCode;
var int m_nBehaviorCategoryCode;
var int m_nReqDeviceInstanceId;
var float m_fBuffValue;
var float m_fPhysicalPowerScaling;
var float m_fMagicalPowerScaling;
var float m_fLifetimeScaling;
var float m_fLifetimeMax;
var int m_nScalingType;
var int m_nTargetType;
var int m_nTargetAffectsType;
var int m_nHitSpecialSituationalType;
var int m_nNumStacks;
var int m_nNumMaxStacks;
var TgEffectGroup s_NonContagiousEffectGroup;
var ImpactInfo m_Impact;
var int m_nPosture;
var int m_nFxAppliedId;
var name m_nmDisplayGroup;
var int s_ManagedEffectListIndex;
var TgEffectManager s_OwnerEffectManager;
var name m_nmDamageTypeClass;
var int m_nSourceDeviceInstId;
var int m_nSourceItemId;
var float s_fEGShieldHealth;
var float s_fEGShieldHealthMax;
var ForceFeedbackWaveform m_Waveform;
var native Pointer m_pEffectGroupSetup;
var LifeTimeCalcInfo m_LastLifeTimeCalcInfo;

// Export UTgEffectGroup::execCloneEffectGroup(FFrame&, void* const)
native function TgEffectGroup CloneEffectGroup(optional bool bCloneAllEffects);

// Export UTgEffectGroup::execRemoveEffects(FFrame&, void* const)
native function RemoveEffects(optional bool bClearTimers = true);

// Export UTgEffectGroup::execTotalPropertyEffectAmt(FFrame&, void* const)
native function float TotalPropertyEffectAmt(int nPropertyId);

// Export UTgEffectGroup::execQueryFxTransitionTime(FFrame&, void* const)
native function float QueryFxTransitionTime();

// Export UTgEffectGroup::execEffectExists(FFrame&, void* const)
native function bool EffectExists(int nPropId);

// Export UTgEffectGroup::execGetProperty(FFrame&, void* const)
native function TgProperty GetProperty(Actor Target, int nPropertyId);

// Export UTgEffectGroup::execCalcCategoryProtection(FFrame&, void* const)
native function float CalcCategoryProtection(Actor Target, float fValue, out float fPercReduction);

// Export UTgEffectGroup::execCalcDoTLifeTimeProtection(FFrame&, void* const)
native function float CalcDoTLifeTimeProtection(Actor Target, float fValue, out float fDirectReduction, out float fPercReduction);

// Export UTgEffectGroup::execIsBuff(FFrame&, void* const)
native function bool IsBuff();

// Export UTgEffectGroup::execPersistsThroughDeath(FFrame&, void* const)
native function bool PersistsThroughDeath();

// Export UTgEffectGroup::execIsInstantaneous(FFrame&, void* const)
native function bool IsInstantaneous();

// Export UTgEffectGroup::execIsSlow(FFrame&, void* const)
native function bool IsSlow();

// Export UTgEffectGroup::execIsStealth(FFrame&, void* const)
native function bool IsStealth();

// Export UTgEffectGroup::execIsSlowToHalt(FFrame&, void* const)
native function bool IsSlowToHalt();

// Export UTgEffectGroup::execIsCrit(FFrame&, void* const)
native function bool IsCrit();

// Export UTgEffectGroup::execIsDot(FFrame&, void* const)
native function bool IsDot();

// Export UTgEffectGroup::execIsDebuff(FFrame&, void* const)
native function bool IsDebuff();

// Export UTgEffectGroup::execIsSuperiorCrowdControl(FFrame&, void* const)
native function bool IsSuperiorCrowdControl();

// Export UTgEffectGroup::execIsCrowdControl(FFrame&, void* const)
native function bool IsCrowdControl();

// Export UTgEffectGroup::execAppliesDiminishingReturns(FFrame&, void* const)
native function bool AppliesDiminishingReturns();

// Export UTgEffectGroup::execReceivesDiminishingReturns(FFrame&, void* const)
native function bool ReceivesDiminishingReturns();

// Export UTgEffectGroup::execDoesDamage(FFrame&, void* const)
native function bool DoesDamage();

// Export UTgEffectGroup::execHasCategoryCode(FFrame&, void* const)
native function bool HasCategoryCode(int nCategoryCode, optional bool bBehaviorOnly);

// Export UTgEffectGroup::execIsActive(FFrame&, void* const)
native function bool IsActive();

// Export UTgEffectGroup::execSetActive(FFrame&, void* const)
native function SetActive(bool bActive, optional bool bRemoving = false);

// Export UTgEffectGroup::execHandleStatusEffects(FFrame&, void* const)
native function HandleStatusEffects(bool bRemoving);

// Export UTgEffectGroup::execGetTimeElapsed(FFrame&, void* const)
native function float GetTimeElapsed();

// Export UTgEffectGroup::execGetTimeRemaining(FFrame&, void* const)
native function float GetTimeRemaining();

// Export UTgEffectGroup::execGetPercentTimeRemaining(FFrame&, void* const)
native function float GetPercentTimeRemaining();

// Export UTgEffectGroup::execGetIntervalTimeRemaining(FFrame&, void* const)
native function float GetIntervalTimeRemaining();

// Export UTgEffectGroup::execApplyEffects(FFrame&, void* const)
native function bool ApplyEffects();

// Export UTgEffectGroup::execApplyInterval(FFrame&, void* const)
native function ApplyInterval();

// Export UTgEffectGroup::execLifeDone(FFrame&, void* const)
native function LifeDone();

// Export UTgEffectGroup::execGetLifeTime(FFrame&, void* const)
native function float GetLifeTime(optional bool bModifiers = false, optional out LifeTimeCalcInfo CalcInfo);

// Export UTgEffectGroup::execGetUtilityPower(FFrame&, void* const)
native function float GetUtilityPower();

// Export UTgEffectGroup::execQueueRemovalOnManagerTick(FFrame&, void* const)
native function QueueRemovalOnManagerTick();

// Export UTgEffectGroup::execHasShield(FFrame&, void* const)
native function bool HasShield();

// Export UTgEffectGroup::execGetShieldHealth(FFrame&, void* const)
native function float GetShieldHealth();

// Export UTgEffectGroup::execGetShieldMaxHealth(FFrame&, void* const)
native function float GetShieldMaxHealth();

// Export UTgEffectGroup::execDamageShield(FFrame&, void* const)
native function float DamageShield(float fDamage);

// Export UTgEffectGroup::execHealShield(FFrame&, void* const)
native function float HealShield(float fHeal);

defaultproperties
{
    m_StunType=EStunType.STUN_TYPE_NORMAL
    m_fApplicationChance=1.0000000
    m_nNumMaxStacks=100
    s_ManagedEffectListIndex=-1
}