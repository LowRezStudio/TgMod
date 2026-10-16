class SeqVar_ObjectVolume extends SeqVar_Object
    native(Sequence)
    hidecategories(Object);

var float LastUpdateTime;
var array<Object> ContainedObjects;
var() array< Class > ExcludeClassList;
var() bool bCollidingOnly;

defaultproperties
{
    ExcludeClassList[0]=Class'Engine.Trigger'
    ExcludeClassList[1]=Class'Engine.Volume'
    bCollidingOnly=true
    ObjName="Object Volume"
}