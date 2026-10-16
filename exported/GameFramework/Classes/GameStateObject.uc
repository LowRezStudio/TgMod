class GameStateObject extends GameplayEventsHandler
    native(GameStats)
    config(GameStats);

enum GameSessionType
{
    GT_SessionInvalid,              // 0
    GT_SinglePlayer,                // 1
    GT_Coop,                        // 2
    GT_Multiplayer,                 // 3
    GT_MAX                          // 4
};

struct native TeamState
{
    var int TeamIndex;
    var init array<init int> PlayerIndices;

    structdefaultproperties
    {
        TeamIndex=0
        PlayerIndices=none
    }
};

struct native PlayerState
{
    var int PlayerIndex;
    var int CurrentTeamIndex;
    var float TimeSpawned;
    var float TimeAliveSinceLastDeath;

    structdefaultproperties
    {
        PlayerIndex=0
        CurrentTeamIndex=0
        TimeSpawned=0.0000000
        TimeAliveSinceLastDeath=0.0000000
    }
};

var native const Array_Mirror TeamStates;
var native const Array_Mirror PlayerStates;
var GameStateObject.GameSessionType SessionType;
var bool bIsMatchStarted;
var bool bIsRoundStarted;
var int RoundNumber;
var int MaxRoundNumber;

// Export UGameStateObject::execPreProcessStream(FFrame&, void* const)
native event PreProcessStream();

// Export UGameStateObject::execReset(FFrame&, void* const)
native function Reset();
