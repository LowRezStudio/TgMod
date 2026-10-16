class TgTeamPlayerStart extends TgStartPoint
    native(Navigation)
    hidecategories(Navigation,Lighting,LightColor,Force,Collision);

const TG_MAX_DISTANCE_FOR_SPAWN_CALCULATION = 1600.0f;

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

event Destroyed()
{
    local int I;
    local TgRepInfo_Player PRI;

    I = s_AssignedPlayers.Length - 1;
    J0x17:

    // End:0xF2 [Loop If]
    if(I >= 0)
    {
        PRI = s_AssignedPlayers[I];
        // End:0xE4
        if((((PRI != none) && PRI.r_SpawnPoint == self) && !PRI.bDeleteMe) && !PRI.IsPendingKill())
        {
            PRI.SetSpawnPoint(none);
        }
        I--;
        // [Loop Continue]
        goto J0x17;
    }
    s_AssignedPlayers.Length = 0;
    super(Actor).Destroyed();
    //return;    
}

event int GetSupportedTaskforce()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x15D
    if(GRI != none)
    {
        // End:0x151
        if((GRI.GameClass == Class'TgGame.TgGame_Paladins_Payload') || GRI.GameClass == Class'TgGame.TgGame_Paladins_Payload_Practice')
        {
            // End:0x151
            if(GRI.r_AttackingTaskForce != none)
            {
                // End:0x10B
                if(int(m_nTaskForce) == int(1))
                {
                    return int(GRI.r_AttackingTaskForce.r_nTaskForce);                    
                }
                else
                {
                    // End:0x14F
                    if(int(GRI.r_AttackingTaskForce.r_nTaskForce) == int(1))
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

simulated function float GetRating(Controller Player)
{
    return NativeGetRating(Player, super.GetRating(Player));
    //return ReturnValue;    
}

simulated function OnSetTaskforce(TgSeqAct_SetTaskforce Action)
{
    m_nTaskForce = byte(Action.TaskForceNumber);
    //return;    
}

defaultproperties
{
    m_nPriority=-1
    nPrevPriority=-1
    m_fMaxDistForEnemyCheckUU=4800.0000000
    m_fMaxWeightForEnemyDistanceCheck=500.0000000
    m_fMaxDistForAllyCheckUU=4800.0000000
    m_fMinDistForAllyCheckUU=256.0000000
    m_fMaxWeightForAllyDistanceCheck=500.0000000
    m_fRandomRatingWeighting=2000.0000000
    m_fExtraHeightToTraceTo=50.0000000
    m_fStartRating=1.0000000
    m_fCurrentRating=1.0000000
    m_fResetRating=1.0000000
    // Reference: CylinderComponent'TgGame.Default__TgTeamPlayerStart.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgStartPoint.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=none
    Components[1]=none
    Components[2]=none
    Components[3]=CollisionCylinder
    Components[4]=none
    CollisionComponent=CollisionCylinder
}