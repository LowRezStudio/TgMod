class SeqVar_Object extends SequenceVariable
    native(Sequence)
    hidecategories(Object);

var() protected Object ObjValue;
var transient Vector ActorLocation;
var const array< Class > SupportedClasses;

function Object GetObjectValue()
{
    return ObjValue;
    //return ReturnValue;    
}

function SetObjectValue(Object NewValue)
{
    ObjValue = NewValue;
    //return;    
}

defaultproperties
{
    SupportedClasses[0]=Class'Core.Object'
    ObjName="Object"
}