class TgGame_Battle_Training extends TgGame_Battle_Practice
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var bool m_bNewTutorial;
var array<int> m_StartingItems;
var int m_StartingSkills[4];
var array<int> m_RecommendedItems;

// Export UTgGame_Battle_Training::execGetRespawnTime(FFrame&, void* const)
native function float GetRespawnTime(int TaskForceNum);

// Export UTgGame_Battle_Training::execSpawnPlayerCharacter(FFrame&, void* const)
native function TgPawn SpawnPlayerCharacter(Controller C, Vector vLocation);

function float GetSetupTime()
{
    return 10.0000000;
    //return ReturnValue;    
}

function SpawnBots()
{
    //return;    
}

defaultproperties
{
    m_bNewTutorial=true
    m_RecommendedItems[0]=7573
    m_bAllowAutoUpgrades=false
    m_nStartingLevel=1
    m_GameType=TG_GAME_TYPE.TGT_BATTLE_TRAINING
    m_fMaxRepawnTime=10.0000000
}