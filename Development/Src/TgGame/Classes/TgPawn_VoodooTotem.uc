class TgPawn_VoodooTotem extends TgPawn_Pet
    native(Pawns)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

const MAX_VOODOO_LINKS = 5;

var TgPawn r_linkedEnemies[5];
var int nBreakDist;
var int m_nBeamFXID;
var TgSpecialFx m_BeamFXs[5];
var float fDamageAmount;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_linkedEnemies;
}

native function PostPawnSetupServer();  // Export UTgPawn_VoodooTotem::execPostPawnSetupServer(FFrame&, void* const)

native function UpdateLinkedEnemies();  // Export UTgPawn_VoodooTotem::execUpdateLinkedEnemies(FFrame&, void* const)

native function UpdateAllBeams();  // Export UTgPawn_VoodooTotem::execUpdateAllBeams(FFrame&, void* const)

native function PawnOnDamaged(out OnDamagedParams Params);  // Export UTgPawn_VoodooTotem::execPawnOnDamaged(FFrame&, void* const)

native function bool ShouldShowHudOverlay(TgPawn PlayerPawn);  // Export UTgPawn_VoodooTotem::execShouldShowHudOverlay(FFrame&, void* const)

simulated function ForwardEffects(ImpactInfo Impact, TgEffectGroup EffectGroup, TgDevice SourceDevice, optional bool bRemove, optional int StackCount=1) { }

simulated event DestroyIt(optional bool bSkipFx) { }

function SetMovementPhysics() { }

event bool CanBePulled() { }

event bool CanBeGrabbed() { }

simulated function bool ShouldNudgePlayer(TgPawn PlayerPawn) { }

defaultproperties
{}
