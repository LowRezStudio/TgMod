interface Test2 extends Interface native(Pawns)
    dependson(TgObject);

function int GetCredits() { }

function SetCredits(int nCreditsAmount) { }

function ResetUlt() { }

native function SetRewardValues(int XP, int Currency, Actor Source, TgObject.ERewardValueType RewardType, optional bool bFlankKill=false);  // Export UTgPaladinsController::execSetRewardValues(FFrame&, void* const)

function LiveRespawn(bool bResetHealth, bool bResetDevices) { }

event Revive() { }

function Pawn GetTgPawn() { }

native function int GetTaskForceNumber();  // Export UTgPaladinsController::execGetTaskForceNumber(FFrame&, void* const)
