class TgSkelControlSingleBone_Skinned extends TgSkelControlSingleBone
    native(Anim)
    hidecategories(Object,Object);

struct native SkinStrengthOverride
{
    var() int nSkinId;
    var() float fDesiredStrength;

    structdefaultproperties
    {
        nSkinId=0
        fDesiredStrength=0.0000000
    }
};

var() float DefaultStrength;
var() export editinline array<export editinline SkinStrengthOverride> SkinOverrides;
var bool bInitializedStrength;
var transient float fSkinStrength;

defaultproperties
{
    DefaultStrength=1.0000000
}