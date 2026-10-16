interface TgCombatActor extends Interface
    abstract
    native(Pawns);

enum GameplayDesignType
{
    GDT_None,                       // 0
    GDT_Player,                     // 1
    GDT_Pet,                        // 2
    GDT_Deployable,                 // 3
    GDT_Shield,                     // 4
    GDT_MAX                         // 5
};

// Export UTgCombatActor::execGetHealth(FFrame&, void* const)
native function float GetHealth();

// Export UTgCombatActor::execGetMaxHealth(FFrame&, void* const)
native function float GetMaxHealth();

// Export UTgCombatActor::execGetHealthPercent(FFrame&, void* const)
native function float GetHealthPercent();

// Export UTgCombatActor::execGetMana(FFrame&, void* const)
native function float GetMana();

// Export UTgCombatActor::execGetMaxMana(FFrame&, void* const)
native function float GetMaxMana();

// Export UTgCombatActor::execGetShieldHealth(FFrame&, void* const)
native function float GetShieldHealth();

// Export UTgCombatActor::execGetMaxShield(FFrame&, void* const)
native function float GetMaxShield();

// Export UTgCombatActor::execCanTakeHealthDamage(FFrame&, void* const)
native function bool CanTakeHealthDamage();

// Export UTgCombatActor::execCanDealHeadShots(FFrame&, void* const)
native function bool CanDealHeadShots();

// Export UTgCombatActor::execCanTakeHeadShots(FFrame&, void* const)
native function bool CanTakeHeadShots();

// Export UTgCombatActor::execOnlyTakeHeadShots(FFrame&, void* const)
native function bool OnlyTakeHeadShots();

// Export UTgCombatActor::execIsImmuneToDamage(FFrame&, void* const)
native function bool IsImmuneToDamage();

// Export UTgCombatActor::execCanBeExecuted(FFrame&, void* const)
native function bool CanBeExecuted();

// Export UTgCombatActor::execIsImmuneToHealing(FFrame&, void* const)
native function bool IsImmuneToHealing();

// Export UTgCombatActor::execBuffDamage(FFrame&, void* const)
native function BuffDamage(Actor Target, TgEffectDamage Effect, ImpactInfo Impact, float fBaseDamage, out float fProratedAmount, out ExtraDamageInfo ExtraInfo);

// Export UTgCombatActor::execGetSpecialDamageDealtPercentAI(FFrame&, void* const)
native function float GetSpecialDamageDealtPercentAI();

// Export UTgCombatActor::execGetSpecialDamageTakenPercentAI(FFrame&, void* const)
native function float GetSpecialDamageTakenPercentAI();

// Export UTgCombatActor::execMitigateHealthDamage(FFrame&, void* const)
native function MitigateHealthDamage(TgPawn pInstigator, TgEffectDamage Effect, ImpactInfo Impact, out float NewValue, out float fPercReduction);

// Export UTgCombatActor::execGetDamageReductionPerc(FFrame&, void* const)
native function float GetDamageReductionPerc(TgDevice damageDev, TgEffectGroup eg);

// Export UTgCombatActor::execTakeHealthDamage(FFrame&, void* const)
native function TakeHealthDamage(float fDamage, Controller InstigatedBy, Class<DamageType> DamageType, ImpactInfo Impact, ExtraDamageInfo ExtraInfo, optional Actor DamageCauser);

// Export UTgCombatActor::execCanBeLifestealInstigator(FFrame&, void* const)
native function bool CanBeLifestealInstigator();

// Export UTgCombatActor::execCanBeLifestealTarget(FFrame&, void* const)
native function bool CanBeLifestealTarget();

// Export UTgCombatActor::execCanTakeManaDamage(FFrame&, void* const)
native function bool CanTakeManaDamage();

// Export UTgCombatActor::execTakeManaDamage(FFrame&, void* const)
native function TakeManaDamage(float fDamage, Controller InstigatedBy, Class<DamageType> DamageType, ImpactInfo Impact, ExtraDamageInfo ExtraInfo, optional Actor DamageCauser);

// Export UTgCombatActor::execCanTakeShieldDamage(FFrame&, void* const)
native function bool CanTakeShieldDamage();

// Export UTgCombatActor::execCanUsePersonalShield(FFrame&, void* const)
native function bool CanUsePersonalShield();

// Export UTgCombatActor::execTakePersonalShieldDamage(FFrame&, void* const)
native function int TakePersonalShieldDamage(float fDamage, Controller InstigatedBy, Class<DamageType> DamageType, ImpactInfo Impact, ExtraDamageInfo ExtraInfo, optional Actor DamageCauser);

// Export UTgCombatActor::execShieldDamageAppliesToHealth(FFrame&, void* const)
native function bool ShieldDamageAppliesToHealth();

// Export UTgCombatActor::execTakeStealthDamage(FFrame&, void* const)
native function TakeStealthDamage(float fDamage);

// Export UTgCombatActor::execGetDamageToLeaveStealth(FFrame&, void* const)
native function float GetDamageToLeaveStealth();

// Export UTgCombatActor::execHandleNotificationsForAI(FFrame&, void* const)
native function HandleNotificationsForAI(float fStatChange, TgPawn InstigatorPawn);

// Export UTgCombatActor::execLocalPlayerHasLOS(FFrame&, void* const)
native function bool LocalPlayerHasLOS();

// Export UTgCombatActor::execGetLocation(FFrame&, void* const)
native function Vector GetLocation();

// Export UTgCombatActor::execGetPropCurrentValue(FFrame&, void* const)
native function float GetPropCurrentValue(int nPropIndex);

// Export UTgCombatActor::execGetPropIndex(FFrame&, void* const)
native function int GetPropIndex(int nPropId);

// Export UTgCombatActor::execGetMarkedPercent(FFrame&, void* const)
native function float GetMarkedPercent(Actor InstigatorPawn);

// Export UTgCombatActor::execGetMarkedPercentInhand(FFrame&, void* const)
native function float GetMarkedPercentInhand(Actor InstigatorPawn);

// Export UTgCombatActor::execGetEffectManager(FFrame&, void* const)
native function TgEffectManager GetEffectManager();

// Export UTgCombatActor::execGetDesignType(FFrame&, void* const)
native function TgCombatActor.GameplayDesignType GetDesignType();

// Export UTgCombatActor::execIsPet(FFrame&, void* const)
native function bool IsPet();

// Export UTgCombatActor::execGetPetOwner(FFrame&, void* const)
native function Actor GetPetOwner();

simulated function float GetMaxAimAssistStacks()
{
    //return ReturnValue;    
}

simulated function Actor GetActorFromCombatActor()
{
    //return ReturnValue;    
}

simulated function GetAimAssistBounds(const out Vector ObserverLocation, out float Width, out float Height, out Vector Center)
{
    //return;    
}
