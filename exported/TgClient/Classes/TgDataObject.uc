class TgDataObject extends UIData
    native(UIData);

enum UIID
{
    UIID_NONE,                      // 0
    UIID_XP,                        // 1
    UIID_LEVEL,                     // 2
    UIID_LEVEL_PCT,                 // 3
    UIID_BOT_ID,                    // 4
    UIID_DEVICE_ID,                 // 5
    UIID_NAME,                      // 6
    UIID_AMMO,                      // 7
    UIID_ICON,                      // 8
    UIID_STATUS,                    // 9
    UIID_POWER,                     // 10
    UIID_COOLDOWN,                  // 11
    UIID_ENEMY_SCORE,               // 12
    UIID_ENEMY_CHARGE,              // 13
    UIID_ENEMY_TASKFORCE,           // 14
    UIID_FRIENDLY_SCORE,            // 15
    UIID_FRIENDLY_CHARGE,           // 16
    UIID_FRIENDLY_TASKFORCE,        // 17
    UIID_ATTACKING_TASKFORCE,       // 18
    UIID_TIMER_VALUE,               // 19
    UIID_TIMER_STATE,               // 20
    UIID_TIMER_TEXT,                // 21
    UIID_MANA,                      // 22
    UIID_MANA_MAX,                  // 23
    UIID_MANA_PCT,                  // 24
    UIID_HEALTH,                    // 25
    UIID_HEALTH_MAX,                // 26
    UIID_HEALTH_PCT,                // 27
    UIID_SHIELD,                    // 28
    UIID_SHIELD_MAX,                // 29
    UIID_SHIELD_PCT,                // 30
    UIID_TIMER_ACTIVATION,          // 31
    UIID_BONUS_CARDS,               // 32
    UIID_COMBAT_FLAG,               // 33
    UIID_COMBAT_TIME,               // 34
    UIID_COMBAT_TIMER,              // 35
    UIID_DISPLAY_CARDS,             // 36
    UIID_PLAYER_ID,                 // 37
    UIID_PLAYER_NAME,               // 38
    UIID_PLAYER_NOTE,               // 39
    UIID_PLAYER_LEVEL,              // 40
    UIID_CLAN_TAG,                  // 41
    UIID_CLAN_NAME,                 // 42
    UIID_MASTERY_LEVEL,             // 43
    UIID_IS_RECENT,                 // 44
    UIID_IS_ONLINE,                 // 45
    UIID_IS_STREAMING,              // 46
    UIID_IS_PARTY,                  // 47
    UIID_IS_MY_PARTY,               // 48
    UIID_IS_FRIEND,                 // 49
    UIID_IS_PENDING,                // 50
    UIID_IS_REQUESTED,              // 51
    UIID_STATUS_ID,                 // 52
    UIID_STATUS_LABEL,              // 53
    UIID_STATUS_MESSAGE,            // 54
    UIID_QUEUE_ICON,                // 55
    UIID_AVATAR_ID,                 // 56
    UIID_FRIENDS_TOTAL,             // 57
    UIID_FRIENDS_ONLINE,            // 58
    UIID_FRIENDS_PENDING,           // 59
    UIID_CLAN_PENDING,              // 60
    UIID_EQUIP_POINT,               // 61
    UIID_MASTERY,                   // 62
    UIID_INVITE_MAP,                // 63
    UIID_INVITE_QUEUE,              // 64
    UIID_INVITE_PENDING,            // 65
    UIID_PARTY_LEADER,              // 66
    UIID_MAX                        // 67
};

enum UIDeviceStatus
{
    UIDS_NONE,                      // 0
    UIDS_LOCKED,                    // 1
    UIDS_READY,                     // 2
    UIDS_COOLDOWN,                  // 3
    UIDS_FIRING,                    // 4
    UIDS_DEPLOYED,                  // 5
    UIDS_MAX                        // 6
};

struct native UIDataValue
{
    var TgDataObject.UIID eType;
    var bool bDirty;
    var float fValue;
    var init string sValue;

    structdefaultproperties
    {
        eType=UIID.UIID_NONE
        bDirty=false
        fValue=0.0000000
        sValue=""
    }
};

var bool m_bDirty;
var bool m_bCallback;
var array<TgDataObject.UIID> m_Laundry;
var init native map{VOID,VOID} m_Data;
