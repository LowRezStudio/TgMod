class TgTeamPlayerStart extends TgStartPoint
    native(Navigation)
    hidecategories(Navigation,Lighting,LightColor,Force,Collision)
    config(Engine);

const TG_MAX_DISTANCE_FOR_SPAWN_CALCULATION = 1600.0f;

var () byte m_nTaskForce;
var () int m_nPriority;
var () int nPrevPriority;
var () float m_fMaxDistForEnemyCheckUU;
var () float m_fMaxWeightForEnemyDistanceCheck;
var () float m_fMaxDistForAllyCheckUU;
var () float m_fMinDistForAllyCheckUU;
var () float m_fMaxWeightForAllyDistanceCheck;
var () float m_fRandomRatingWeighting;
var () bool m_bInitialSpawnOnly;
var () bool m_bDisallowEnemyLOS;
var float m_fExtraHeightToTraceTo;
var editconst int m_nMinLevel;
var transient float m_fLastUsedTimeStamp;
var array<TgRepInfo_Player> s_AssignedPlayers;

native function LoadObjectConfig();  // Export UTgTeamPlayerStart::execLoadObjectConfig(FFrame&, void* const)

native function bool IsAssignedToPlayer();  // Export UTgTeamPlayerStart::execIsAssignedToPlayer(FFrame&, void* const)

native function bool AreaUnoccupied();  // Export UTgTeamPlayerStart::execAreaUnoccupied(FFrame&, void* const)

native function float NativeGetRating(Controller Player, float fRating);  // Export UTgTeamPlayerStart::execNativeGetRating(FFrame&, void* const)

event Destroyed() { }

event int GetSupportedTaskforce() { }

simulated function float GetRating(Controller Player) { }

simulated function OnSetTaskforce(TgSeqAct_SetTaskforce Action) { }

defaultproperties
{}
