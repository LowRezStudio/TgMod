interface TgPaladinsController extends Interface
    dependson(TgObject);

function int GetCredits();

function SetCredits(int nCreditsAmount);

function ResetUlt();

function SetRewardValues(int XP, int Currency, Actor Source, TgObject.ERewardValueType RewardType, optional bool bFlankKill=false);  // Export UTgPaladinsController::execSetRewardValues(FFrame&, void* const)

function LiveRespawn(bool bResetHealth, bool bResetDevices);

event Revive();

function TgPawn GetTgPawn();

function int GetTaskForceNumber();  // Export UTgPaladinsController::execGetTaskForceNumber(FFrame&, void* const)
