class ApexDestructibleDamageParameters extends Object
    native(Physics)
    hidecategories(Object);

enum EDamageParameterOverrideMode
{
    DPOM_Absolute,                  // 0
    DPOM_Multiplier,                // 1
    DPOM_MAX                        // 2
};

struct native DamageParameters
{
    var() ApexDestructibleDamageParameters.EDamageParameterOverrideMode OverrideMode;
    var() float BaseDamage;
    var() float Radius;
    var() float Momentum;

    structdefaultproperties
    {
        OverrideMode=EDamageParameterOverrideMode.DPOM_Absolute
        BaseDamage=0.0000000
        Radius=0.0000000
        Momentum=0.0000000
    }
};

struct native DamagePair
{
    var() name DamageCauserName;
    var() DamageParameters Params;

    structdefaultproperties
    {
        DamageCauserName="None"
        Params=(OverrideMode=EDamageParameterOverrideMode.DPOM_Absolute,BaseDamage=0.0000000,Radius=0.0000000,Momentum=0.0000000)
    }
};

var() array<DamagePair> DamageMap;
