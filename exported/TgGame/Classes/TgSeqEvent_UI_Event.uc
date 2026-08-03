class TgSeqEvent_UI_Event extends SequenceEvent
    native(Kismet)
    forcescriptorder(true)
    hidecategories(Object);

var int mDeckNum;
var int mEmptyItemSlots;

event DeckUIInitialized(Actor InOriginator, Actor InInstigator)
{
    local array<int> ActivateIndices;

    ActivateIndices[0] = 0;
    CheckActivate(InOriginator, InInstigator,, ActivateIndices);
    //return;    
}

event ItemUIInitialized(Actor InOriginator, Actor InInstigator)
{
    local array<int> ActivateIndices;

    ActivateIndices[0] = 1;
    CheckActivate(InOriginator, InInstigator,, ActivateIndices);
    //return;    
}

event DeckMenuOpened(Actor InOriginator, Actor InInstigator)
{
    local array<int> ActivateIndices;

    ActivateIndices[0] = 2;
    CheckActivate(InOriginator, InInstigator,, ActivateIndices);
    //return;    
}

event DeckChanged(Actor InOriginator, Actor InInstigator, int Deck)
{
    local array<int> ActivateIndices;

    ActivateIndices[0] = 3;
    mDeckNum = Deck;
    CheckActivate(InOriginator, InInstigator,, ActivateIndices);
    //return;    
}

event DeckSelected(Actor InOriginator, Actor InInstigator, int Deck)
{
    local array<int> ActivateIndices;

    ActivateIndices[0] = 4;
    mDeckNum = Deck;
    CheckActivate(InOriginator, InInstigator,, ActivateIndices);
    //return;    
}

event ItemMenuOpened(Actor InOriginator, Actor InInstigator)
{
    local array<int> ActivateIndices;

    ActivateIndices[0] = 5;
    CheckActivate(InOriginator, InInstigator,, ActivateIndices);
    //return;    
}

event ItemPurchased(Actor InOriginator, Actor InInstigator, int EmptySlots)
{
    local array<int> ActivateIndices;

    ActivateIndices[0] = 6;
    mEmptyItemSlots = EmptySlots;
    CheckActivate(InOriginator, InInstigator,, ActivateIndices);
    //return;    
}

event ItemUpgraded(Actor InOriginator, Actor InInstigator)
{
    local array<int> ActivateIndices;

    ActivateIndices[0] = 7;
    CheckActivate(InOriginator, InInstigator,, ActivateIndices);
    //return;    
}

defaultproperties
{
    MaxTriggerCount=0
    bClientSideOnly=true
    OutputLinks[0]=(Links=none,LinkDesc="Deck UI Initialized",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[1]=(Links=none,LinkDesc="Item UI Initialized",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[2]=(Links=none,LinkDesc="Deck Menu Opened",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[3]=(Links=none,LinkDesc="Deck Changed",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[4]=(Links=none,LinkDesc="Deck Selected",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[5]=(Links=none,LinkDesc="Item Menu Opened",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[6]=(Links=none,LinkDesc="Item Purchased",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[7]=(Links=none,LinkDesc="Item Upgraded",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Instigator",LinkVar="None",PropertyName="None",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Int',LinkedVariables=none,LinkDesc="Deck Number",LinkVar="None",PropertyName="mDeckNum",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[2]=(ExpectedType=Class'Engine.SeqVar_Int',LinkedVariables=none,LinkDesc="Empty Item Slots",LinkVar="None",PropertyName="mEmptyItemSlots",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Tutorial UI Event"
}