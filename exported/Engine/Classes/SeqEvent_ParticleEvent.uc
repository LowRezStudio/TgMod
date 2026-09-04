class SeqEvent_ParticleEvent extends SequenceEvent
    native(Sequence)
    hidecategories(Object);

enum EParticleEventOutputType
{
    ePARTICLEOUT_Spawn,             // 0
    ePARTICLEOUT_Death,             // 1
    ePARTICLEOUT_Collision,         // 2
    ePARTICLEOUT_AttractorCollision,// 3
    ePARTICLEOUT_Kismet,            // 4
    ePARTICLEOUT_MAX                // 5
};

var SeqEvent_ParticleEvent.EParticleEventOutputType EventType;
var Vector EventPosition;
var float EventEmitterTime;
var Vector EventVelocity;
var float EventParticleTime;
var Vector EventNormal;
var() bool UseRelfectedImpactVector;

static event int GetObjClassVersion()
{
    return super(SequenceObject).GetObjClassVersion() + 0;
    //return ReturnValue;    
}

defaultproperties
{
    MaxTriggerCount=0
    bPlayerOnly=false
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Instigator",LinkVar="None",PropertyName="None",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Int',LinkedVariables=none,LinkDesc="Type",LinkVar="None",PropertyName="EventType",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[2]=(ExpectedType=Class'Engine.SeqVar_Vector',LinkedVariables=none,LinkDesc="Pos",LinkVar="None",PropertyName="EventPosition",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[3]=(ExpectedType=Class'Engine.SeqVar_Float',LinkedVariables=none,LinkDesc="ETime",LinkVar="None",PropertyName="EventEmitterTime",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[4]=(ExpectedType=Class'Engine.SeqVar_Vector',LinkedVariables=none,LinkDesc="Vel",LinkVar="None",PropertyName="EventVelocity",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[5]=(ExpectedType=Class'Engine.SeqVar_Float',LinkedVariables=none,LinkDesc="PTime",LinkVar="None",PropertyName="EventParticleTime",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[6]=(ExpectedType=Class'Engine.SeqVar_Vector',LinkedVariables=none,LinkDesc="Normal",LinkVar="None",PropertyName="EventNormal",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="ParticleEvent"
}