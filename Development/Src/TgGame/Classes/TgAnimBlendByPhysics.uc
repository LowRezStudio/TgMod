class TgAnimBlendByPhysics extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

var (Animations) int PhysicsMap[14];
var int LastPhysics;

defaultproperties
{
    PhysicsMap[0]=-1
    PhysicsMap[2]=1
    PhysicsMap[3]=-1
    PhysicsMap[4]=2
    PhysicsMap[5]=-1
    PhysicsMap[6]=-1
    PhysicsMap[7]=-1
    PhysicsMap[8]=-1
    PhysicsMap[9]=-1
    PhysicsMap[10]=-1
    PhysicsMap[11]=3
    PhysicsMap[12]=-1
    PhysicsMap[13]=-1
    Children=/* Array type was not detected. */
}
