class SeqCond_IsLoggedIn extends SequenceCondition
    native(Sequence)
    hidecategories(Object);

var() int NumNeededLoggedIn;

event bool CheckLogins()
{
    local int LoggedInCount, Count;
    local OnlineSubsystem OnlineSub;
    local OnlinePlayerInterface PlayerInt;

    OnlineSub = Class'Engine.GameEngine'.static.GetOnlineSubsystem();
    // End:0xF1
    if(OnlineSub != none)
    {
        PlayerInt = OnlineSub.PlayerInterface;
        // End:0xF1
        if(NotEqual_InterfaceInterface(PlayerInt, OnlinePlayerInterface(none)))
        {
            Count = 0;
            J0x8B:

            // End:0xF1 [Loop If]
            if(Count < NumNeededLoggedIn)
            {
                // End:0xE3
                if(int(PlayerInt.GetLoginStatus(byte(Count))) >= int(1))
                {
                    LoggedInCount++;
                }
                Count++;
                // [Loop Continue]
                goto J0x8B;
            }
        }
    }
    return LoggedInCount >= NumNeededLoggedIn;
    //return ReturnValue;    
}

defaultproperties
{
    OutputLinks[0]=(Links=none,LinkDesc="True",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[1]=(Links=none,LinkDesc="False",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Int',LinkedVariables=none,LinkDesc="NeededLoggedIn",LinkVar="None",PropertyName="NumNeededLoggedIn",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Is Logged In"
}