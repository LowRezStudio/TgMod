class TgSkelCon_LookAt extends SkelControlLookAt
    native(Anim)
    hidecategories(Object,Object)
    config(Engine);

var TgPawn m_Owner;
var (AI) bool m_bAimAtEnemyTarget;
var (LookAt) bool m_AlwaysInterpolateTarget;
var bool m_bHadTargetLastTick;
