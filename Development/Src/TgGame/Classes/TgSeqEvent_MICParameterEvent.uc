class TgSeqEvent_MICParameterEvent extends SequenceEvent
    native
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

enum eMICEventType {
    MET_NONE,  // 0
    MET_DEFENSE_ALARM,  // 1
};

var () TgSeqEvent_MICParameterEvent.eMICEventType MICEventType;
var () array<MaterialInstanceConstant> AttachedMICs;

native function SetScalarParameterValue(name ParamName, float fValue);  // Export UTgSeqEvent_MICParameterEvent::execSetScalarParameterValue(FFrame&, void* const)

native function SetVectorParameterValue(name ParamName, LinearColor Value);  // Export UTgSeqEvent_MICParameterEvent::execSetVectorParameterValue(FFrame&, void* const)

defaultproperties
{
    MaxTriggerCount=0
    bPlayerOnly=false
    bClientSideOnly=true
    OutputLinks[0]=(Links=none,LinkDesc="Activated",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[1]=(Links=none,LinkDesc="Deactivated",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    ObjName="MIC Parameter Event"
}
