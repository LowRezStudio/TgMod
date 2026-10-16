class UIDataPlayer extends UIData
    native(UIData);

enum SOCIAL_PlayerOnlineStatus
{
    UISPOS_None,                    // 0
    UISPOS_Offline,                 // 1
    UISPOS_Away,                    // 2
    UISPOS_FriendInviteSent,        // 3
    UISPOS_FriendInvitedYou,        // 4
    UISPOS_InMatch,                 // 5
    UISPOS_InParty,                 // 6
    UISPOS_InQueue,                 // 7
    UISPOS_InLobby,                 // 8
    UISPOS_Online,                  // 9
    UISPOS_MAX                      // 10
};

var init string sName;
var init string sStatusString;
var UIDataPlayer.SOCIAL_PlayerOnlineStatus eStatus;
var int nLevel;
var int nHours;
var int nMasteryLevel;
var dword dwPlayerId;
var QWord qwUserId;
var bool bIsSelf;
var bool bIsLeader;
var bool bPartyInvitePending;
var init array<init UIDataLeaguePlayer> pLeaguePlayers;
