class SeqAct_Teleport extends SequenceAction
    hidecategories(Object);

var() bool bUpdateRotation;
var() bool bCheckOverlap;
var() bool bResetVelocity;
var() float TeleportDistance;
var() array<Volume> TeleportVolumes;

static final function bool ShouldTeleport(Actor TestActor, Vector TeleportLocation, optional float TeleportDist, optional array<Volume> Volumes)
{
    local int VolumeIdx;

    // End:0x60
    if((TeleportDist > 0.0000000) && VSizeSq(TestActor.Location - TeleportLocation) < (TeleportDist * TeleportDist))
    {
        return false;        
    }
    else
    {
        // End:0xF3
        if(Volumes.Length > 0)
        {
            VolumeIdx = 0;
            J0x7B:

            // End:0xF3 [Loop If]
            if(VolumeIdx < Volumes.Length)
            {
                // End:0xE5
                if((Volumes[VolumeIdx] != none) && Volumes[VolumeIdx].Encompasses(TestActor))
                {
                    return false;
                }
                ++VolumeIdx;
                // [Loop Continue]
                goto J0x7B;
            }
        }
    }
    return true;
    //return ReturnValue;    
}

static event int GetObjClassVersion()
{
    return super(SequenceObject).GetObjClassVersion() + 1;
    //return ReturnValue;    
}

defaultproperties
{
    bUpdateRotation=true
    TeleportDistance=-1.0000000
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Target",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Destination",LinkVar="None",PropertyName="None",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[2]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Teleport Volumes",LinkVar="None",PropertyName="TeleportVolumes",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=true,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Teleport"
}