class NavMeshPathConstraint extends Object
    native(AI);

var NavMeshPathConstraint NextConstraint;
var int NumNodesProcessed;
var int NumThrownOutNodes;
var float AddedDirectCost;
var float AddedHeuristicCost;

event Recycle()
{
    NextConstraint = none;
    NumThrownOutNodes = 0;
    AddedDirectCost = 0.0000000;
    AddedHeuristicCost = 0.0000000;
    NumNodesProcessed = 0;
    //return;    
}

event string GetDumpString()
{
    return string(self);
    //return ReturnValue;    
}
