class BattlePlayerController extends TgPlayerController
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

native function BattlePlayerControllerFunction();  // Export UBattlePlayerController::execBattlePlayerControllerFunction(FFrame&, void* const)

defaultproperties
{}
