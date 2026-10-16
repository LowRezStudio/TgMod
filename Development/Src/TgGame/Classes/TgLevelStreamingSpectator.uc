class TgLevelStreamingSpectator extends LevelStreaming
    native
    editinlinenew
    config(Engine);

enum SpectatorStreamingMethod {
    SSM_OnlyLoadIfSpectating,  // 0
    SSM_OnlyLoadIfNotSpectating,  // 1
    SSM_AlwaysLoad,  // 2
};

var () TgLevelStreamingSpectator.SpectatorStreamingMethod m_LoadingMethod;

defaultproperties
{
    m_LoadingMethod=SSM_AlwaysLoad
}
