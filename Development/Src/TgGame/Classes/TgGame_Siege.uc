class TgGame_Siege extends TgGame_Battle
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

enum SIEGE_TIER {
    SGT_NONE,  // 0
    SGT_TOWERA,  // 1
    SGT_TOWERB,  // 2
    SGT_CASTLE,  // 3
};

function float GetSetupTime() { }

function bool StartGameTimer() { }

event ReachedCheckpoint(int Taskforce, int Tier) { }

function DestroyTower(int Taskforce, int Index) { }

function WinGame(int WinningTaskForce) { }

defaultproperties
{
    m_bRespawnInhibitors=false
    m_nStartingCurrency=2000
    m_nStartingLevel=3
    m_MinionKillerBonus=0.2500000
    m_GameType=TGT_SIEGE
}
