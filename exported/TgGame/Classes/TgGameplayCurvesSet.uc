class TgGameplayCurvesSet extends Object
    abstract
    native(GameplayCurves)
    editinlinenew
    hidecategories(Object);

enum ECurveSetTypes
{
    CST_None,                       // 0
    CST_Recoil,                     // 1
    CST_RecoilSimple,               // 2
    CST_AccuracyBloom,              // 3
    CST_DamageFalloff,              // 4
    CST_DamageFalloffAOE,           // 5
    CST_DamagePerShotHit,           // 6
    CST_SpreadTendency,             // 7
    CST_RuckusSpinUpControl,        // 8
    CST_GravityFromZVelocity,       // 9
    CST_AirControlFromZVelocity,    // 10
    CST_WallRunVerticalMovement,    // 11
    CST_AimAssist,                  // 12
    CST_AimAssistKeyframes,         // 13
    CST_AimAcceleration,            // 14
    CST_TargetTracking,             // 15
    CST_HitMarkerScaleByDamage,     // 16
    CST_GravityFromCustom,          // 17
    CST_ProjectileSpeedOverTime,    // 18
    CST_FlakInhandSlow,             // 19
    CST_FlakInhandKnockback,        // 20
    CST_ThreatLevelByRange,         // 21
    CST_AimAssistBoundsScale,       // 22
    CST_ProjFrictionOverTime,       // 23
    CST_ProjGravityOverTime,        // 24
    CST_ScopeWeaponFOV,             // 25
    CST_AimAssistBoundsByFOV,       // 26
    CST_MAX                         // 27
};

var(CurveSet) const editconst TgGameplayCurvesSet.ECurveSetTypes CurveSetType;

// Export UTgGameplayCurvesSet::execGetDistributionValue(FFrame&, void* const)
native function float GetDistributionValue(const out RawDistributionFloat Distribution, float T);

// Export UTgGameplayCurvesSet::execGetPrimaryDistributionValue(FFrame&, void* const)
native function bool GetPrimaryDistributionValue(float T, out float Value);
