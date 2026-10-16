class TgGame_Siege extends TgGame_Battle
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

enum SIEGE_TIER
{
    SGT_NONE,                       // 0
    SGT_TOWERA,                     // 1
    SGT_TOWERB,                     // 2
    SGT_CASTLE,                     // 3
    SGT_MAX                         // 4
};

function float GetSetupTime()
{
    return 45.0000000;
    //return ReturnValue;    
}

function bool StartGameTimer()
{
    m_fGameMissionTime = 14400.0000000;
    return super.StartGameTimer();
    //return ReturnValue;    
}

event ReachedCheckpoint(int Taskforce, int Tier)
{
    switch(Tier)
    {
        // End:0x2E
        case 1:
            DestroyTower(Taskforce, 0);
            // End:0x6B
            break;
        // End:0x4A
        case 2:
            DestroyTower(Taskforce, 1);
            // End:0x6B
            break;
        // End:0x65
        case 3:
            WinGame(Taskforce);
            // End:0x6B
            break;
        // End:0xFFFF
        default:
            // End:0x6B
            break;
            break;
    }
    //return;    
}

function DestroyTower(int Taskforce, int Index)
{
    //return;    
}

function WinGame(int WinningTaskForce)
{
    local TgRepInfo_Game GRI;
    local TgPlayerController PC;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x43
    if((GRI == none) || int(m_GameWinState) != int(0))
    {
        return;
    }
    m_GameWinState = ((WinningTaskForce == 1) ? 2 : 1);
    GRI.r_Winner = GRI.GetTaskForce(WinningTaskForce);
    GRI.bNetDirty = true;
    // End:0x128
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', PC)
    {
        PC.SendClientSetGameWinState(m_GameWinState);        
    }    
    BeginEndMission();
    //return;    
}

defaultproperties
{
    m_bRespawnInhibitors=false
    m_nStartingCurrency=2000
    m_nStartingLevel=3
    m_MinionKillerBonus=0.2500000
    m_GameType=TG_GAME_TYPE.TGT_SIEGE
}