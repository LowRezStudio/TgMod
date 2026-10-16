class Sequence extends SequenceOp
    native(Sequence)
    hidecategories(Object);

struct native ActivateOp
{
    var SequenceOp ActivatorOp;
    var SequenceOp Op;
    var int InputIdx;
    var float RemainingDelay;

    structdefaultproperties
    {
        ActivatorOp=none
        Op=none
        InputIdx=0
        RemainingDelay=0.0000000
    }
};

struct native QueuedActivationInfo
{
    var SequenceEvent ActivatedEvent;
    var Actor InOriginator;
    var Actor InInstigator;
    var array<int> ActivateIndices;
    var bool bPushTop;

    structdefaultproperties
    {
        ActivatedEvent=none
        InOriginator=none
        InInstigator=none
        ActivateIndices=none
        bPushTop=false
    }
};

var const Pointer LogFile;
var const export array<export SequenceObject> SequenceObjects;
var const array<SequenceOp> ActiveSequenceOps;
var const transient array<Sequence> NestedSequences;
var const array<SequenceEvent> UnregisteredEvents;
var const array<ActivateOp> DelayedActivatedOps;
var const array<SequenceOp> DelayedLatentOps;
var() private bool bEnabled;
var array<QueuedActivationInfo> QueuedActivations;
var int DefaultViewX;
var int DefaultViewY;
var float DefaultViewZoom;

// Export USequence::execFindSeqObjectsByClass(FFrame&, void* const)
native final function FindSeqObjectsByClass(Class<SequenceObject> DesiredClass, bool bRecursive, out array<SequenceObject> OutputObjects);

// Export USequence::execFindSeqObjectsByName(FFrame&, void* const)
native final function FindSeqObjectsByName(string SeqObjName, bool bCheckComment, out array<SequenceObject> OutputObjects, optional bool bRecursive = true, optional bool bUseFullLevelName = false);

function Reset()
{
    local int I;
    local SequenceOp Op;

    I = 0;
    J0x0B:

    // End:0x85 [Loop If]
    if(I < SequenceObjects.Length)
    {
        Op = SequenceOp(SequenceObjects[I]);
        // End:0x77
        if(Op != none)
        {
            Op.Reset();
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

// Export USequence::execSetEnabled(FFrame&, void* const)
native final function SetEnabled(bool bInEnabled);

defaultproperties
{
    bEnabled=true
    DefaultViewZoom=1.0000000
    InputLinks=none
    OutputLinks=none
    ObjName="Sequence"
}