class TgSkelCon_Spring extends SkelControlLookAt
    native(Anim)
    hidecategories(Object,Object)
    config(Engine);

var Vector m_vWorldSpaceGoal;
var (LookAt) Vector m_vInitialWorldSpaceGoalOffset;
var Vector m_vVelocity;
var (Spring) float m_fSpringStiffness;
var (Spring) float m_fSpringDamping;
