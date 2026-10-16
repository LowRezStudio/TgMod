interface TgPaladinsController extends Interface
    abstract
    native(Pawns);

function int GetCredits()
{
    //return ReturnValue;    
}

function SetCredits(int nCreditsAmount)
{
    //return;    
}

function ResetUlt()
{
    //return;    
}

// Export UTgPaladinsController::execSetRewardValues(FFrame&, void* const)
native function SetRewardValues(int XP, int Currency, Actor Source, TgObject.ERewardValueType RewardType, optional bool bFlankKill = false);

function LiveRespawn(bool bResetHealth, bool bResetDevices)
{
    //return;    
}

event Revive()
{
    //return;    
}

function TgPawn GetTgPawn()
{
    //return ReturnValue;    
}

// Export UTgPaladinsController::execGetTaskForceNumber(FFrame&, void* const)
native function int GetTaskForceNumber();
