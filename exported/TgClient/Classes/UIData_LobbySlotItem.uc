class UIData_LobbySlotItem extends UIData
    native(UIData);

enum UIChampionCustomizeState
{
    UICCS_Collections,              // 0
    UICCS_HEAD,                     // 1
    UICCS_BODY,                     // 2
    UICCS_WEAPON,                   // 3
    UICCS_EMOTE,                    // 4
    UICCS_VOICE,                    // 5
    UICCS_MVPPOSE,                  // 6
    UICCS_MOUNT,                    // 7
    UICCS_Spray,                    // 8
    UICCS_MAX                       // 9
};

var UIData_LobbySlotItem.UIChampionCustomizeState eState;
var native Pointer pItemInfo;
var bool bActive;
