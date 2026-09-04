class TgGfxFriendManagement extends GFxObject within GFxMoviePlayer
    native
    config(Engine);

enum EFriendTabs {
    FRT_CURRENT_FRIENDS,  // 0
    FRT_REQUESTS,  // 1
    FRT_RECENT,  // 2
    FRT_CLAN,  // 3
    FRT_BLOCKED,  // 4
};

var UIGameMoviePlayer m_Movie;
var init string m_LastErrorString;
var init string m_SelectedPlayerName;
var init string m_InvitedPlayerName;
var TgGfxFriendManagement.EFriendTabs m_tabId;

delegate USC_GetFriendsData_Delegate();

delegate USC_RemoveFriend_Delegate(int nPlayerId);

delegate USC_MessageFriend_Delegate(int nPlayerId, string sPlayerName);

delegate USC_SearchByString_Delegate(string PlayerName);

delegate USC_GetListData_Delegate(int nId);

delegate USC_InviteFriend_Delegate(int nPlayerId);

delegate USC_CancelInvite_Delegate(int nPlayerId);

delegate USC_AcceptClanInvite_Delegate(int nClanId);

delegate USC_CancelClanInvite_Delegate(int nClanId);

delegate USC_AcceptFriendRequest_Delegate(int nPlayerId);

delegate USC_AcceptAllFriendRequests_Delegate();

delegate USC_CancelFriendRequest_Delegate(int nPlayerId);

delegate USC_CancelAllFriendRequests_Delegate();

delegate USC_ViewPlayerProfile_Delegate(string sPlayerName);

delegate USC_ViewPlayerClan_Delegate();

delegate USC_SpectatePlayer_Delegate(int nPlayerId);

delegate USC_WatchFriend_Delegate(int nPlayerId);

delegate USC_PartyInvite_Delegate(int nPlayerId);

delegate USC_PartyKick_Delegate(int nPlayerId);

delegate USC_RemoveBlocked_Delegate(int nPlayerId);

delegate USC_AddPlayerNote_Delegate(int nPlayerId, string sPlayerNote);

delegate USC_InviteFriendByString_Delegate(string sPlayerName);

delegate USC_BlockByString_Delegate(string sPlayerName);

delegate USC_InviteToClan_Delegate(string sPlayerName);

delegate USC_UpdateStatusMessage_Delegate(string sStatus);

delegate USC_ToggleDND_Delegate();

delegate USC_Resize_Delegate(GFxObject pObj);

native function USC_GetFriendsData();  // Export UTgGfxFriendManagement::execUSC_GetFriendsData(FFrame&, void* const)

native function USC_RemoveFriend(int nPlayerId);  // Export UTgGfxFriendManagement::execUSC_RemoveFriend(FFrame&, void* const)

native function USC_MessageFriend(int nPlayerId, string sPlayerName);  // Export UTgGfxFriendManagement::execUSC_MessageFriend(FFrame&, void* const)

native function USC_SearchByString(string PlayerName);  // Export UTgGfxFriendManagement::execUSC_SearchByString(FFrame&, void* const)

native function USC_GetListData(int nId);  // Export UTgGfxFriendManagement::execUSC_GetListData(FFrame&, void* const)

native function USC_InviteFriend(int nPlayerId);  // Export UTgGfxFriendManagement::execUSC_InviteFriend(FFrame&, void* const)

native function USC_CancelInvite(int nPlayerId);  // Export UTgGfxFriendManagement::execUSC_CancelInvite(FFrame&, void* const)

native function USC_AcceptClanInvite(int nClanId);  // Export UTgGfxFriendManagement::execUSC_AcceptClanInvite(FFrame&, void* const)

native function USC_CancelClanInvite(int nClanId);  // Export UTgGfxFriendManagement::execUSC_CancelClanInvite(FFrame&, void* const)

native function USC_AcceptFriendRequest(int nPlayerId);  // Export UTgGfxFriendManagement::execUSC_AcceptFriendRequest(FFrame&, void* const)

native function USC_AcceptAllFriendRequests();  // Export UTgGfxFriendManagement::execUSC_AcceptAllFriendRequests(FFrame&, void* const)

native function USC_CancelFriendRequest(int nPlayerId);  // Export UTgGfxFriendManagement::execUSC_CancelFriendRequest(FFrame&, void* const)

native function USC_CancelAllFriendRequests();  // Export UTgGfxFriendManagement::execUSC_CancelAllFriendRequests(FFrame&, void* const)

native function USC_ViewPlayerProfile(string sPlayerName);  // Export UTgGfxFriendManagement::execUSC_ViewPlayerProfile(FFrame&, void* const)

native function USC_ViewPlayerClan();  // Export UTgGfxFriendManagement::execUSC_ViewPlayerClan(FFrame&, void* const)

native function USC_SpectatePlayer(int nPlayerId);  // Export UTgGfxFriendManagement::execUSC_SpectatePlayer(FFrame&, void* const)

native function USC_WatchFriend(int nPlayerId);  // Export UTgGfxFriendManagement::execUSC_WatchFriend(FFrame&, void* const)

native function USC_PartyInvite(int nPlayerId);  // Export UTgGfxFriendManagement::execUSC_PartyInvite(FFrame&, void* const)

native function USC_PartyKick(int nPlayerId);  // Export UTgGfxFriendManagement::execUSC_PartyKick(FFrame&, void* const)

native function USC_RemoveBlocked(int nPlayerId);  // Export UTgGfxFriendManagement::execUSC_RemoveBlocked(FFrame&, void* const)

native function USC_AddPlayerNote(int nPlayerId, string sPlayerNote);  // Export UTgGfxFriendManagement::execUSC_AddPlayerNote(FFrame&, void* const)

native function USC_InviteFriendByString(string sPlayerName);  // Export UTgGfxFriendManagement::execUSC_InviteFriendByString(FFrame&, void* const)

native function USC_BlockByString(string sPlayerName);  // Export UTgGfxFriendManagement::execUSC_BlockByString(FFrame&, void* const)

native function USC_InviteToClan(string sPlayerName);  // Export UTgGfxFriendManagement::execUSC_InviteToClan(FFrame&, void* const)

native function USC_UpdateStatusMessage(string sStatus);  // Export UTgGfxFriendManagement::execUSC_UpdateStatusMessage(FFrame&, void* const)

native function USC_ToggleDND();  // Export UTgGfxFriendManagement::execUSC_ToggleDND(FFrame&, void* const)

native function USC_Resize(GFxObject pObj);  // Export UTgGfxFriendManagement::execUSC_Resize(FFrame&, void* const)

function ASC_ErrorFeedback(string ErrMsg) { }

event ErrorFeedback(string ErrMsg) { }

function ASC_Reinit() { }

event Reinit() { }
