class PathConstraint extends Object
    native(AI);

var const int CacheIdx;
var PathConstraint NextConstraint;

event Recycle()
{
    NextConstraint = none;
    //return;    
}

event string GetDumpString()
{
    return string(self);
    //return ReturnValue;    
}

defaultproperties
{
    CacheIdx=-1
}