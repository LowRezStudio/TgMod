class UIDataSocial extends UIDataObject
    native(UIData)
    config(Engine);

struct UISocialReferrer {
    var dword dwReferralId;
    var QWord qwPortalUserId;
    var init string sName;
    structdefaultproperties {}
};

var bool m_bIsPartyCompetitiveReady;
var bool m_bCompetitiveReadyDirty;
var bool m_bSelfIsPartyLeader;
var bool m_nPartyMembersInGame;
var int m_nOnlineFriendCount;
var int m_nConnectedFriendCount;
var int m_nPendingFriendInvites;
var int m_nReferralPeriodSeconds;
var private int m_nOldActivePartySize;
var init array<init UIDataPlayer> m_Friends;
var init array<init UIDataPlayer> m_Party;
var init array<init UISocialReferrer> m_Referrers;
var init array<init UIDataPlayer> m_PlayerArray;

defaultproperties
{
    m_nReferralPeriodSeconds=864000
}
