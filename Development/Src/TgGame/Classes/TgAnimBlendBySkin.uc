class TgAnimBlendBySkin extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

struct SkinChildInfo {
    var () int nSkinId;
    var () int nChildIndex;
    structdefaultproperties {}
};

var () array<SkinChildInfo> m_SkinMap;
