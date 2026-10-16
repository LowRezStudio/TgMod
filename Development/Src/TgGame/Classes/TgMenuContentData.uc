class TgMenuContentData extends Object
    native
    config(Engine);

enum MenuContentDataType {
    MCDT_None,  // 0
    MCDT_Login,  // 1
    MCDT_MainMenu,  // 2
    MCDT_MainMenu_Featured_1,  // 3
    MCDT_MainMenu_Featured_2,  // 4
    MCDT_MainMenu_Featured_3,  // 5
    MCDT_MainMenu_Featured_4,  // 6
    MCDT_MainMenu_Featured_5,  // 7
    MCDT_MainMenu_Featured_6,  // 8
    MCDT_MainMenu_BetaPromo,  // 9
    MCDT_MainMenu_GodPack,  // 10
    MCDT_MainMenu_FacebookPromo,  // 11
    MCDT_MainMenu_TwitterPromo,  // 12
    MCDT_MainMenu_NewPlayer_Feature_1,  // 13
    MCDT_MainMenu_NewPlayer_Feature_2,  // 14
    MCDT_MainMenu_NewPlayer_Feature_3,  // 15
    MCDT_Play,  // 16
    MCDT_Store,  // 17
    MCDT_Social_Friends,  // 18
    MCDT_Social_Followers,  // 19
    MCDT_Social_Blocked,  // 20
    MCDT_Settings,  // 21
    MCDT_Lobby,  // 22
};

struct MeshData {
    var TgMenuContentData.MenuContentDataType ContentDataType;
    var TgMenuMeshInfo MainMeshInfo;
    var name CameraName;
    structdefaultproperties {}
};

var array<MeshData> m_MeshData;
var SoundCue m_LoginMusic;
var SoundCue m_GodSelectionMusic;
var SoundCue m_BattleReadyMusic;

function Init() { }

event GetMeshData(TgMenuContentData.MenuContentDataType ContentDataType, out MeshData Data) { }

function PreloadTextures(float ForceDuration) { }
