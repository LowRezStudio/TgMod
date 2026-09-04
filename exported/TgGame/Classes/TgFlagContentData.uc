class TgFlagContentData extends Object
    native;

enum FlagContentDataType
{
    FCDT_None,                      // 0
    FCDT_Egyptian_Lobby,            // 1
    FCDT_Egyptian_Wall,             // 2
    FCDT_Norse_Lobby,               // 3
    FCDT_Norse_Wall,                // 4
    FCDT_Greek_Lobby,               // 5
    FCDT_Greek_Wall,                // 6
    FCDT_Roman_Lobby,               // 7
    FCDT_Roman_Wall,                // 8
    FCDT_Chinese_Lobby,             // 9
    FCDT_Chinese_Wall,              // 10
    FCDT_Mayan_Lobby,               // 11
    FCDT_Mayan_Wall,                // 12
    FCDT_Hindu_Lobby,               // 13
    FCDT_Hindu_Wall,                // 14
    FCDT_MAX                        // 15
};

struct native FlagMeshData
{
    var TgFlagContentData.FlagContentDataType ContentDataType;
    var TgMenuMeshInfo MainMeshInfo;

    structdefaultproperties
    {
        ContentDataType=FlagContentDataType.FCDT_None
        MainMeshInfo=none
    }
};

var array<FlagMeshData> m_MeshData;

function Init()
{
    //return;    
}

event GetMeshData(TgFlagContentData.FlagContentDataType ContentDataType, out FlagMeshData Data)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x88 [Loop If]
    if(I < m_MeshData.Length)
    {
        // End:0x7A
        if(int(ContentDataType) == int(m_MeshData[I].ContentDataType))
        {
            Data = m_MeshData[I];
            return;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

function PreloadTextures(float ForceDuration)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0xA2 [Loop If]
    if(I < m_MeshData.Length)
    {
        // End:0x94
        if(m_MeshData[I].MainMeshInfo != none)
        {
            m_MeshData[I].MainMeshInfo.PreloadTextures(ForceDuration);
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}
