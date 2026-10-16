class Scene extends Object
    native(Scene);

const SDPG_NumBits = 3;

enum ESceneDepthPriorityGroup
{
    SDPG_UnrealEdBackground,        // 0
    SDPG_EmissiveSkybox,            // 1
    SDPG_World,                     // 2
    SDPG_Middleground,              // 3
    SDPG_Foreground,                // 4
    SDPG_UnrealEdForeground,        // 5
    SDPG_PostProcess,               // 6
    SDPG_MAX                        // 7
};

enum EDetailMode
{
    DM_Low,                         // 0
    DM_Medium,                      // 1
    DM_High,                        // 2
    DM_MAX                          // 3
};
