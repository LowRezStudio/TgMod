class TgPawn_SiegeWall_Base extends TgPawn_SiegeWall
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

var bool m_bHasAlertedLowHealth;
var float m_fLowHealthTrigger;

native function SendAttackAlert();  // Export UTgPawn_SiegeWall_Base::execSendAttackAlert(FFrame&, void* const)

native function SendLowHealthAlert();  // Export UTgPawn_SiegeWall_Base::execSendLowHealthAlert(FFrame&, void* const)

simulated function PostBeginPlay() { }

simulated function name GetWallImpactKismetName() { }

event bool Died(Controller Killer, class<DamageType> DamageType, vector HitLocation) { }

event int GetHPScalingValue() { }

event RegisterWithGRI() { }

function UnRegisterWithGRI() { }

defaultproperties
{}
