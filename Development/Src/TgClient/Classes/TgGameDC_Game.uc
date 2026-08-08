class TgGameDC_Game extends TgDataChunk within GFxMoviePlayer
    native(GameUI)
    config(Engine);

enum GAME_MODE_TYPE {
    GAME_TYPE_BATTLE,  // 0
    GAME_TYPE_ARENA,  // 1
    GAME_TYPE_DOM,  // 2
    GAME_TYPE_SIEGE,  // 3
};

var TgSynchronizedTimer m_GameTimer;
var TgGameDC_Team m_FriendTeamData;
var TgGameDC_Team m_EnemyTeamData;
var TgGameDC_MapEntity m_GoldFury;
var TgGameDC_Game.GAME_MODE_TYPE currentGameType;

native function InitializeData(TgDataHandler Handler, TgDataChunk parentChunk);  // Export UTgGameDC_Game::execInitializeData(FFrame&, void* const)

native function NotifyMapChange();  // Export UTgGameDC_Game::execNotifyMapChange(FFrame&, void* const)

native function UpdateGameClock();  // Export UTgGameDC_Game::execUpdateGameClock(FFrame&, void* const)

native function UpdateGameCapturePoint(int Index, int Taskforce);  // Export UTgGameDC_Game::execUpdateGameCapturePoint(FFrame&, void* const)
