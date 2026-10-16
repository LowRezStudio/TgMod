class TgSeqEvent_EnergyUpdated extends SequenceEvent
    native(Kismet)
    forcescriptorder(true)
    hidecategories(Object);

var int ResultEnergy;

static event int GetIndex(float CurrentEnergy, float PreviousEnergy)
{
    local int nCurrentEnergy, nPreviousEnergy;

    nCurrentEnergy = int(CurrentEnergy);
    nPreviousEnergy = int(PreviousEnergy);
    // End:0x50
    if((nPreviousEnergy != 0) && nCurrentEnergy == 0)
    {
        return 4;        
    }
    else
    {
        // End:0x78
        if((nPreviousEnergy < 25) && nCurrentEnergy >= 25)
        {
            return 3;            
        }
        else
        {
            // End:0xA0
            if((nPreviousEnergy < 50) && nCurrentEnergy >= 50)
            {
                return 2;                
            }
            else
            {
                // End:0xC7
                if((nPreviousEnergy < 75) && nCurrentEnergy >= 75)
                {
                    return 1;                    
                }
                else
                {
                    // End:0xEE
                    if((nPreviousEnergy < 100) && nCurrentEnergy >= 100)
                    {
                        return 0;                        
                    }
                    else
                    {
                        return -1;
                    }
                }
            }
        }
    }
    //return ReturnValue;    
}

defaultproperties
{
    MaxTriggerCount=0
    bPlayerOnly=false
    OutputLinks[0]=(Links=none,LinkDesc="100%",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[1]=(Links=none,LinkDesc="75%",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[2]=(Links=none,LinkDesc="50%",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[3]=(Links=none,LinkDesc="25%",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[4]=(Links=none,LinkDesc="0%",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    ObjName="Player Ultimate Energy Updated"
}