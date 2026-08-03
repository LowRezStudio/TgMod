class SequenceEvent extends SequenceOp
    abstract
    native(Sequence)
    hidecategories(Object);

var array<SequenceEvent> DuplicateEvts;
var Actor Originator;
var Actor Instigator;
var float ActivationTime;
var int TriggerCount;
var() int MaxTriggerCount;
var() float ReTriggerDelay;
var() bool bEnabled;
var() bool bPlayerOnly;
var transient bool bRegistered;
var() const bool bClientSideOnly;
var() const bool bServerAndClientSide;
var() bool bHumanOnly;
var() byte Priority;
var int MaxWidth;

event RegisterEvent()
{
    //return;    
}

// Export USequenceEvent::execCheckActivate(FFrame&, void* const)
native final function bool CheckActivate(Actor InOriginator, Actor InInstigator, optional bool bTest, const optional out array<int> ActivateIndices, optional bool bPushTop);

function Reset()
{
    ActivationTime = 0.0000000;
    TriggerCount = 0;
    Instigator = none;
    //return;    
}

event Toggled()
{
    //return;    
}

defaultproperties
{
    MaxTriggerCount=1
    bEnabled=true
    bPlayerOnly=true
    bAutoActivateOutputLinks=false
    InputLinks=none
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Instigator",LinkVar="None",PropertyName="None",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
}