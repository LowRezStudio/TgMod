class TgAnimBlendByWeaponSkin extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

struct native WeaponSkinChildInfo
{
    var() int nWeaponSkinId;
    var() int nChildIndex;

    structdefaultproperties
    {
        nWeaponSkinId=0
        nChildIndex=0
    }
};

var() array<WeaponSkinChildInfo> m_SkinMap;
