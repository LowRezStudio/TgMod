class SeqVar_Group extends SeqVar_Object
    native(Sequence)
    hidecategories(Object);

var() name GroupName;
var transient bool bCachedList;
var transient array<Object> Actors;

defaultproperties
{
    ObjName="Group"
}