class TgTeamPlayerStart extends TgStartPoint
    native(Navigation)
    hidecategories(Navigation,Lighting,LightColor,Force,Collision);


var() byte m_nTaskForce;
var() int m_nPriority;
var() int nPrevPriority;
var() float m_fMaxDistForEnemyCheckUU;
var() float m_fMaxWeightForEnemyDistanceCheck;
var() float m_fMaxDistForAllyCheckUU;
var() float m_fMinDistForAllyCheckUU;
var() float m_fMaxWeightForAllyDistanceCheck;
var() float m_fRandomRatingWeighting;
var() bool m_bInitialSpawnOnly;
var() bool m_bDisallowEnemyLOS;
var float m_fExtraHeightToTraceTo;
var editconst int m_nMinLevel;
var transient float m_fLastUsedTimeStamp;
var array<TgRepInfo_Player> s_AssignedPlayers;

// Export UTgTeamPlayerStart::execLoadObjectConfig(FFrame&, void* const)
native function LoadObjectConfig();

// Export UTgTeamPlayerStart::execIsAssignedToPlayer(FFrame&, void* const)
native final function bool IsAssignedToPlayer();

// Export UTgTeamPlayerStart::execAreaUnoccupied(FFrame&, void* const)
native final function bool AreaUnoccupied();

// Export UTgTeamPlayerStart::execNativeGetRating(FFrame&, void* const)
native function float NativeGetRating(Controller Player, float fRating);

// Export UTgTeamPlayerStart::execGetSpawnRotationFor(FFrame&, void* const)
native function Rotator GetSpawnRotationFor(Pawn TgP);

event int GetSupportedTaskforce()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x15D
    if(GRI != none)
    {
        // End:0x151
        if(true)
        {
            // End:0x151
            if(GRI.r_AttackingTaskForce != none)
            {
                // End:0x10B
                if(int(m_nTaskForce) == 1)
                {
                    return int(GRI.r_AttackingTaskForce.r_nTaskForce);                    
                }
                else
                {
                    // End:0x14F
                    if(int(GRI.r_AttackingTaskForce.r_nTaskForce) == 1)
                    {
                        return 2;                        
                    }
                    else
                    {
                        return 1;
                    }
                }
            }
        }
        return int(m_nTaskForce);
    }
    //return ReturnValue;    
}