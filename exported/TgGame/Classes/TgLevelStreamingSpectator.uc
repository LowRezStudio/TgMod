class TgLevelStreamingSpectator extends LevelStreaming
    native
    editinlinenew;

enum SpectatorStreamingMethod
{
    SSM_OnlyLoadIfSpectating,       // 0
    SSM_OnlyLoadIfNotSpectating,    // 1
    SSM_AlwaysLoad,                 // 2
    SSM_MAX                         // 3
};

var() TgLevelStreamingSpectator.SpectatorStreamingMethod m_LoadingMethod;

defaultproperties
{
    m_LoadingMethod=SpectatorStreamingMethod.SSM_AlwaysLoad
}