class TgSkelControlSingleBone_DisplayGroup extends TgSkelControlSingleBone
    native(Anim)
    hidecategories(Object,Object)
    config(Engine);

enum DisplayGroupOnType {
    DISPLAYGROUP_ON_INACTIVE,  // 0
    DISPLAYGROUP_ON_ACTIVE,  // 1
    DISPLAYGROUP_ON_STRENGTHABOVE,  // 2
    DISPLAYGROUP_ON_STRENGTHBELOW,  // 3
};

struct DisplayGroupInfo {
    var () name DisplayGroupName;
    var () TgSkelControlSingleBone_DisplayGroup.DisplayGroupOnType WhenDisplayGroupOn;
    var () float Strength;
    var transient bool bOn;
    var () bool ForceOffIfMeshHidden;
    structdefaultproperties {}
};

var () export editinline array<export editinline DisplayGroupInfo> DisplayGroupInfos;
