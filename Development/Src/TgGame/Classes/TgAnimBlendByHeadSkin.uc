class TgAnimBlendByHeadSkin extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

struct HeadSkinChildInfo {
    var () int nHeadSkinId;
    var () int nChildIndex;
    structdefaultproperties {}
};

var () array<HeadSkinChildInfo> m_SkinMap;
