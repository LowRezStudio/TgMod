class SeqAct_Destroy extends SequenceAction
    hidecategories(Object);

var() bool bDestroyBasedActors;
var() array< Class<Actor> > IgnoreBasedClasses;

defaultproperties
{
    ObjName="Destroy"
}