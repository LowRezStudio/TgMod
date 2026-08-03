class TgData_Notifications extends TgDataObject
    native(UIData);

enum NotificationType
{
    NT_NONE,                        // 0
    NT_ACQUISITION,                 // 1
    NT_ACHIEVEMENT,                 // 2
    NT_SOCIAL,                      // 3
    NT_MAX                          // 4
};

struct native Notification
{
    var init string sTitle;
    var init string sDescription;
    var dword dwIconIndex;
    var init string sIconId;
    var dword dwItemId;
    var QWord qwTimeStamp;
    var TgData_Notifications.NotificationType eType;
    var dword dwCount;
    var dword dwItemType;
    var dword dwItemSubType;
    var bool bNavigable;
    var bool bShowDescription;
    var bool bUseCardStack;
    var bool bUseTreasureStack;
    var bool bSeen;

    structdefaultproperties
    {
        sTitle=""
        sDescription=""
        dwIconIndex=()
        sIconId=""
        dwItemId=()
        qwTimeStamp=()
        eType=NotificationType.NT_NONE
        dwCount=()
        dwItemType=()
        dwItemSubType=()
        bNavigable=false
        bShowDescription=false
        bUseCardStack=false
        bUseTreasureStack=false
        bSeen=false
    }
};

var array<Notification> m_Notifications;
