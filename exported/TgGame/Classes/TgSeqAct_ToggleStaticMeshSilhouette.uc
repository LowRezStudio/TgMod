class TgSeqAct_ToggleStaticMeshSilhouette extends SequenceAction
    native(Kismet)
    forcescriptorder(true)
    hidecategories(Object);

var() StaticMeshActor SMA;
var bool bIsEnabled;

function Activated()
{
    // End:0x176
    if((SMA != none) && SMA.Silhouette != none)
    {
        // End:0x8F
        if(InputLinks[0].bHasImpulse)
        {
            SMA.Silhouette.SetEnabled(true);            
        }
        else
        {
            // End:0xE9
            if(InputLinks[1].bHasImpulse)
            {
                SMA.Silhouette.SetEnabled(false);                
            }
            else
            {
                // End:0x176
                if(InputLinks[2].bHasImpulse)
                {
                    SMA.Silhouette.SetEnabled(!SMA.Silhouette.bEnabled);
                }
            }
        }
    }
    //return;    
}

defaultproperties
{
    InputLinks[0]=(LinkDesc="Turn On",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    InputLinks[1]=(LinkDesc="Turn Off",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    InputLinks[2]=(LinkDesc="Toggle",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Static Mesh Actor",LinkVar="None",PropertyName="SMA",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Bool',LinkedVariables=none,LinkDesc="Is Enabled After",LinkVar="None",PropertyName="bIsEnabled",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Toggle Static Mesh Silhouette"
}