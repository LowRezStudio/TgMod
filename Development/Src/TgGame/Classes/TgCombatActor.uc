interface TgCombatActor extends Interface
    dependson(TgObject);

enum GameplayDesignType {
    GDT_None,  // 0
    GDT_Player,  // 1
    GDT_Pet,  // 2
    GDT_Deployable,  // 3
    GDT_Shield,  // 4
};

function float GetHealth();  // Export UTgCombatActor::execGetHealth(FFrame&, void* const)

function float GetMaxHealth();  // Export UTgCombatActor::execGetMaxHealth(FFrame&, void* const)

function float GetHealthPercent();  // Export UTgCombatActor::execGetHealthPercent(FFrame&, void* const)

function float GetMana();  // Export UTgCombatActor::execGetMana(FFrame&, void* const)

function float GetMaxMana();  // Export UTgCombatActor::execGetMaxMana(FFrame&, void* const)

function float GetShieldHealth();  // Export UTgCombatActor::execGetShieldHealth(FFrame&, void* const)

function float GetMaxShield();  // Export UTgCombatActor::execGetMaxShield(FFrame&, void* const)

function bool CanTakeHealthDamage();  // Export UTgCombatActor::execCanTakeHealthDamage(FFrame&, void* const)

function bool CanDealHeadShots();  // Export UTgCombatActor::execCanDealHeadShots(FFrame&, void* const)

function bool CanTakeHeadShots();  // Export UTgCombatActor::execCanTakeHeadShots(FFrame&, void* const)

function bool OnlyTakeHeadShots();  // Export UTgCombatActor::execOnlyTakeHeadShots(FFrame&, void* const)

function bool IsImmuneToDamage();  // Export UTgCombatActor::execIsImmuneToDamage(FFrame&, void* const)

function bool CanBeExecuted();  // Export UTgCombatActor::execCanBeExecuted(FFrame&, void* const)

function bool IsImmuneToHealing();  // Export UTgCombatActor::execIsImmuneToHealing(FFrame&, void* const)

function BuffDamage(Actor Target, TgEffectDamage Effect, ImpactInfo Impact, float fBaseDamage, out float fProratedAmount, out ExtraDamageInfo ExtraInfo);  // Export UTgCombatActor::execBuffDamage(FFrame&, void* const)

function float GetSpecialDamageDealtPercentAI();  // Export UTgCombatActor::execGetSpecialDamageDealtPercentAI(FFrame&, void* const)

function float GetSpecialDamageTakenPercentAI();  // Export UTgCombatActor::execGetSpecialDamageTakenPercentAI(FFrame&, void* const)

function MitigateHealthDamage(TgPawn pInstigator, TgEffectDamage Effect, ImpactInfo Impact, out float NewValue, out float fPercReduction);  // Export UTgCombatActor::execMitigateHealthDamage(FFrame&, void* const)

function float GetDamageReductionPerc(TgDevice damageDev, TgEffectGroup eg);  // Export UTgCombatActor::execGetDamageReductionPerc(FFrame&, void* const)

function TakeHealthDamage(float fDamage, Controller InstigatedBy, Class<DamageType> DamageType, ImpactInfo Impact, ExtraDamageInfo ExtraInfo, optional Actor DamageCauser);  // Export UTgCombatActor::execTakeHealthDamage(FFrame&, void* const)

function bool CanBeLifestealInstigator();  // Export UTgCombatActor::execCanBeLifestealInstigator(FFrame&, void* const)

function bool CanBeLifestealTarget();  // Export UTgCombatActor::execCanBeLifestealTarget(FFrame&, void* const)

function bool CanTakeManaDamage();  // Export UTgCombatActor::execCanTakeManaDamage(FFrame&, void* const)

function TakeManaDamage(float fDamage, Controller InstigatedBy, Class<DamageType> DamageType, ImpactInfo Impact, ExtraDamageInfo ExtraInfo, optional Actor DamageCauser);  // Export UTgCombatActor::execTakeManaDamage(FFrame&, void* const)

function bool CanTakeShieldDamage();  // Export UTgCombatActor::execCanTakeShieldDamage(FFrame&, void* const)

function bool CanUsePersonalShield();  // Export UTgCombatActor::execCanUsePersonalShield(FFrame&, void* const)

function int TakePersonalShieldDamage(float fDamage, Controller InstigatedBy, Class<DamageType> DamageType, ImpactInfo Impact, ExtraDamageInfo ExtraInfo, optional Actor DamageCauser);  // Export UTgCombatActor::execTakePersonalShieldDamage(FFrame&, void* const)

function bool ShieldDamageAppliesToHealth();  // Export UTgCombatActor::execShieldDamageAppliesToHealth(FFrame&, void* const)

function TakeStealthDamage(float fDamage);  // Export UTgCombatActor::execTakeStealthDamage(FFrame&, void* const)

function float GetDamageToLeaveStealth();  // Export UTgCombatActor::execGetDamageToLeaveStealth(FFrame&, void* const)

function HandleNotificationsForAI(float fStatChange, TgPawn InstigatorPawn);  // Export UTgCombatActor::execHandleNotificationsForAI(FFrame&, void* const)

function bool LocalPlayerHasLOS();  // Export UTgCombatActor::execLocalPlayerHasLOS(FFrame&, void* const)

function Vector GetLocation();  // Export UTgCombatActor::execGetLocation(FFrame&, void* const)

function float GetPropCurrentValue(int nPropIndex);  // Export UTgCombatActor::execGetPropCurrentValue(FFrame&, void* const)

function int GetPropIndex(int nPropId);  // Export UTgCombatActor::execGetPropIndex(FFrame&, void* const)

function float GetMarkedPercent(Actor InstigatorPawn);  // Export UTgCombatActor::execGetMarkedPercent(FFrame&, void* const)

function float GetMarkedPercentInhand(Actor InstigatorPawn);  // Export UTgCombatActor::execGetMarkedPercentInhand(FFrame&, void* const)

function TgEffectManager GetEffectManager();  // Export UTgCombatActor::execGetEffectManager(FFrame&, void* const)

function TgCombatActor.GameplayDesignType GetDesignType();  // Export UTgCombatActor::execGetDesignType(FFrame&, void* const)

function bool IsPet();  // Export UTgCombatActor::execIsPet(FFrame&, void* const)

function Actor GetPetOwner();  // Export UTgCombatActor::execGetPetOwner(FFrame&, void* const)

simulated function float GetMaxAimAssistStacks();

simulated function Actor GetActorFromCombatActor();

simulated function GetAimAssistBounds(const out Vector ObserverLocation, out float Width, out float Height, out Vector Center);
