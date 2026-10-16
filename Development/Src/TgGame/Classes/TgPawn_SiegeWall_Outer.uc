class TgPawn_SiegeWall_Outer extends TgPawn_SiegeWall
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

native function SendAttackAlert();  // Export UTgPawn_SiegeWall_Outer::execSendAttackAlert(FFrame&, void* const)

simulated function PostBeginPlay() { }

simulated function name GetWallImpactKismetName() { }

event int GetHPScalingValue() { }

event RegisterWithGRI() { }

function UnRegisterWithGRI() { }

defaultproperties
{}
