class UIHudSpectator extends GFxObject within GFxMoviePlayer
    native
    config(Engine);

struct BotLifeData {
    var bool bAlive;
    var int nSpawnTime;
    var int nRespawnTime;
    var array<int> m_DeathTimes;
    structdefaultproperties {}
};

var int m_nIterations;
var int m_BannedIds[6];
var bool m_bFindMatchDetails;
var float m_fUpdateWaitRT;
var float m_fUpdateWaitGT;
var GFxObject _global;
var BotLifeData m_BotLifeData[2];
var UIGameMoviePlayer m_pMovie;

native function Initialize(UIGameMoviePlayer pParentMovie);  // Export UUIHudSpectator::execInitialize(FFrame&, void* const)

native exec function UpdateGraph();  // Export UUIHudSpectator::execUpdateGraph(FFrame&, void* const)

event SendGraphData(GFxObject Obj) { }

defaultproperties
{
    m_bFindMatchDetails=true
    m_BotLifeData[0]=(bAlive=false,nSpawnTime=10,nRespawnTime=300,m_DeathTimes=none)
    m_BotLifeData[1]=(bAlive=false,nSpawnTime=600,nRespawnTime=300,m_DeathTimes=none)
}
