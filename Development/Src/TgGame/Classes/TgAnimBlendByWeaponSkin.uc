class TgAnimBlendByWeaponSkin extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

struct WeaponSkinChildInfo {
    var () int nWeaponSkinId;
    var () int nChildIndex;
    structdefaultproperties {}
};

var () array<WeaponSkinChildInfo> m_SkinMap;
