class TgSkelControlSingleBone_Skinned extends TgSkelControlSingleBone
    native(Anim)
    hidecategories(Object,Object)
    config(Engine);

struct SkinStrengthOverride {
    var () int nSkinId;
    var () float fDesiredStrength;
    structdefaultproperties {}
};

var () float DefaultStrength;
var () export editinline array<export editinline SkinStrengthOverride> SkinOverrides;
var bool bInitializedStrength;
var transient float fSkinStrength;

defaultproperties
{
    DefaultStrength=1.0000000
}
