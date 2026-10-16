class TgFlagContentData extends Object
    native
    config(Engine);

enum FlagContentDataType {
    FCDT_None,  // 0
    FCDT_Egyptian_Lobby,  // 1
    FCDT_Egyptian_Wall,  // 2
    FCDT_Norse_Lobby,  // 3
    FCDT_Norse_Wall,  // 4
    FCDT_Greek_Lobby,  // 5
    FCDT_Greek_Wall,  // 6
    FCDT_Roman_Lobby,  // 7
    FCDT_Roman_Wall,  // 8
    FCDT_Chinese_Lobby,  // 9
    FCDT_Chinese_Wall,  // 10
    FCDT_Mayan_Lobby,  // 11
    FCDT_Mayan_Wall,  // 12
    FCDT_Hindu_Lobby,  // 13
    FCDT_Hindu_Wall,  // 14
};

struct FlagMeshData {
    var TgFlagContentData.FlagContentDataType ContentDataType;
    var TgMenuMeshInfo MainMeshInfo;
    structdefaultproperties {}
};

var array<FlagMeshData> m_MeshData;

function Init() { }

event GetMeshData(TgFlagContentData.FlagContentDataType ContentDataType, out FlagMeshData Data) { }

function PreloadTextures(float ForceDuration) { }
