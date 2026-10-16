class TgPawn_LanePusherRace extends TgPawn_LanePusherBase
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

var const float s_fTotalSplineLength;
var const float s_fPreviousSplineLength;
var const float r_fProgressPercent;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_fProgressPercent;
}

native function PostPawnSetupServer();  // Export UTgPawn_LanePusherRace::execPostPawnSetupServer(FFrame&, void* const)

native function SetSpline(TgSplineActor NewSpline, optional bool bSnapToStart);  // Export UTgPawn_LanePusherRace::execSetSpline(FFrame&, void* const)

native function bool IsNonCombat();  // Export UTgPawn_LanePusherRace::execIsNonCombat(FFrame&, void* const)

native function UpdateTeamScore();  // Export UTgPawn_LanePusherRace::execUpdateTeamScore(FFrame&, void* const)

function ClearFromGRI() { }

event bool Died(Controller Killer, class<DamageType> DamageType, vector HitLocation) { }

simulated event Destroyed() { }

defaultproperties
{}
