class TgAnimBlendByMountSkin extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

struct MountSkinChildInfo {
    var () int nMountSkinId;
    var () int nChildIndex;
    structdefaultproperties {}
};

var () array<MountSkinChildInfo> m_SkinMap;
