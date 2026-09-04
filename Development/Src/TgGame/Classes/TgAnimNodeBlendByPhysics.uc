class TgAnimNodeBlendByPhysics extends AnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

struct ChildBlendInfo {
    var () Actor.EPhysics m_PhysicsState;
    var () float m_fBlendTime;
    structdefaultproperties {}
};

struct ChildrenBlendInfo {
    var () Actor.EPhysics m_PhysicsState;
    var () array<ChildBlendInfo> m_ChildBlendInfo;
    structdefaultproperties {}
};

var TgPawn m_TgPawn;
var Actor.EPhysics m_LastPhysics;
var Actor.EPhysics m_CurrentPhysics;
var int m_CurrentPhysicsChildIndex;
var () array<Actor.EPhysics> m_PhysicsChildren;
var () bool m_bDirectUnspecifiedPhysicsThroughChild0;
var () float DefaultBlendTime;
var () array<ChildrenBlendInfo> m_ChildrenBlendInfo;

defaultproperties
{
    m_PhysicsChildren[0]=151
    m_bDirectUnspecifiedPhysicsThroughChild0=true
    DefaultBlendTime=0.2000000
    Children=/* Array type was not detected. */
}
