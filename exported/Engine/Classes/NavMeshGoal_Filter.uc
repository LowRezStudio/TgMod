class NavMeshGoal_Filter extends Object
    abstract
    native(AI);

var bool bShowDebug;
var transient int NumNodesThrownOut;
var transient int NumNodesProcessed;

event string GetDumpString()
{
    return string(self);
    //return ReturnValue;    
}
