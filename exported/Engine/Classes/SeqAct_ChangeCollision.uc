class SeqAct_ChangeCollision extends SequenceAction
    native(Sequence)
    hidecategories(Object);

var() const editconst bool bCollideActors;
var() const editconst bool bBlockActors;
var() const editconst bool bIgnoreEncroachers;
var() Actor.ECollisionType CollisionType;

static event int GetObjClassVersion()
{
    return super(SequenceObject).GetObjClassVersion() + 4;
    //return ReturnValue;    
}

defaultproperties
{
    ObjName="Change Collision"
}