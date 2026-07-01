class TgPawn_Character extends TgPawn_Biped
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

simulated function PrepareIntro(){}

simulated function PlayIntroAnims(){}

simulated function OnRespawn(){}

simulated function PlaySpawnFx(){}

function PossessedBy(Controller C, bool bVehicleTransition){}

// Export UTgPawn_Character::execApplyPawnSetup(FFrame&, void* const)
native function bool ApplyPawnSetup();

simulated event bool PostPawnSetup(){}