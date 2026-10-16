class TgDistributionFloatSoundAttenuation extends DistributionFloat
    native
    config(Engine)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

enum SoundAttenuationType
{
    TG_ATTENUATION_None,            // 0
    TG_ATTENUATION_Sm_foley,        // 1
    TG_ATTENUATION_Lg_foley,        // 2
    TG_ATTENUATION_Melee_Hit,       // 3
    TG_ATTENUATION_Sm_gun,          // 4
    TG_ATTENUATION_Med_gun,         // 5
    TG_ATTENUATION_Lg_gun,          // 6
    TG_ATTENUATION_Sm_exp,          // 7
    TG_ATTENUATION_Med_exp,         // 8
    TG_ATTENUATION_Lg_exp,          // 9
    TG_ATTENUATION_MAX              // 10
};

struct native AttenuationGroup
{
    var name GroupName;
    var float AttenuationDistance;

    structdefaultproperties
    {
        GroupName="None"
        AttenuationDistance=0.0000000
    }
};

var TgDistributionFloatSoundAttenuation.SoundAttenuationType AttenuationType;
var config float Attenuation_Sm_foley;
var config float Attenuation_Lg_foley;
var config float Attenuation_Melee_hit;
var config float Attenuation_Sm_gun;
var config float Attenuation_Med_gun;
var config float Attenuation_Lg_gun;
var config float Attenuation_Sm_exp;
var config float Attenuation_Med_exp;
var config float Attenuation_Lg_exp;
var() name GroupName;
var config array<config AttenuationGroup> AttenuationGroups;

defaultproperties
{
    AttenuationGroups[0]=(GroupName="Sm_foley",AttenuationDistance=1600.0000000)
    AttenuationGroups[1]=(GroupName="Lg_foley",AttenuationDistance=3200.0000000)
    AttenuationGroups[2]=(GroupName="Melee_hit",AttenuationDistance=6400.0000000)
    AttenuationGroups[3]=(GroupName="Sm_gun",AttenuationDistance=4800.0000000)
    AttenuationGroups[4]=(GroupName="Med_gun",AttenuationDistance=12800.0000000)
    AttenuationGroups[5]=(GroupName="Lg_gun",AttenuationDistance=48000.0000000)
    AttenuationGroups[6]=(GroupName="Sm_exp",AttenuationDistance=14400.0000000)
    AttenuationGroups[7]=(GroupName="Med_exp",AttenuationDistance=80000.0000000)
    AttenuationGroups[8]=(GroupName="Lg_exp",AttenuationDistance=144000.0000000)
    bCanBeBaked=false
}