class SequenceObject extends Object
    abstract
    native(Sequence)
    forcescriptorder(true)
    hidecategories(Object);

var const int ObjInstanceVersion;
var noimport const Sequence ParentSequence;
var string ObjName;
var() string ObjComment;
var bool bDeletable;
var bool bDrawFirst;
var bool bDrawLast;
var() bool bOutputObjCommentToScreen;
var() bool bSuppressAutoComment;
var int DrawWidth;
var int DrawHeight;

// Export USequenceObject::execScriptLog(FFrame&, void* const)
native final function ScriptLog(string LogText, optional bool bWarning = true);

// Export USequenceObject::execGetWorldInfo(FFrame&, void* const)
native final function WorldInfo GetWorldInfo();

event bool IsValidLevelSequenceObject()
{
    return true;
    //return ReturnValue;    
}

event bool IsPastingIntoLevelSequenceAllowed()
{
    return IsValidLevelSequenceObject();
    //return ReturnValue;    
}

event bool ShouldClearNameOnPasting()
{
    return true;
    //return ReturnValue;    
}

static event int GetObjClassVersion()
{
    return 1;
    //return ReturnValue;    
}

defaultproperties
{
    ObjName="Undefined"
    bDeletable=true
    bSuppressAutoComment=true
}