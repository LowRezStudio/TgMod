class UIDataLeagueTier extends UIData
    native(UIData)
    config(Engine);

enum UIDLT_Tag {
    UIDLT_Decays,  // 0
    UIDLT_PlatinumQueue,  // 1
    UIDLT_NoDivisions,  // 2
};

var UIDataLeague pLeague;
var dword dwTierId;
