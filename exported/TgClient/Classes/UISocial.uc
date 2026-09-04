class UISocial extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UISOCIAL_HEADER_COUNT = 5;
const UISOCIAL_REFER_LEVELS = 5;
const UISOCIAL_REFER_BUTTONS = 3;
const UISOCIAL_REFER_FRIENDS = 5;
const UISOCIAL_REFER_REWARDS = 6;
const UISOCIAL_REFER_LISTSIZE = 7;
const UISOCIAL_FRIEND_COUNT = 7;
const UISOCIAL_FRIEND_OPTIONS = 3;
const UISOCIAL_PARTY_COUNT = 5;
const UISOCIAL_PARTY_OPTIONS = 3;
const UISOCIAL_FRIEND_INVITEPARTY_INDEX = 1;
const UISOCIAL_TEAMINVITE_MAX_RECORDS = 64;
const UISOCIAL_PARTY_MININVITEWAIT = 3.0;

enum SOCIALSTATE
{
    ESS_PARTY,                      // 0
    ESS_FRIENDS,                    // 1
    ESS_REFERRAL,                   // 2
    ESS_REFERREDFRIENDS,            // 3
    ESS_REFERREDREWARDS,            // 4
    ESS_SENDREFERREDFRIENDS,        // 5
    ESS_MAX                         // 6
};

enum SOCIAL_ReferralError
{
    UISRE_None,                     // 0
    UISRE_AlreadyReferred,          // 1
    UISRE_AlreadyHaveAccount,       // 2
    UISRE_NoRemainingReferrals,     // 3
    UISRE_ReferralsDisabled,        // 4
    UISRE_LevelRequirementNotMet,   // 5
    UISRE_AgeRequirementNotMet,     // 6
    UISRE_MAX                       // 7
};

struct native ReferralReward
{
    var int nItem;
    var int nLevel;
    var int nReward;
    var bool bCurrency;
    var GFxObject pObj;
    var GFxObject pIcon;
    var GFxObject pFrame;
    var GFxObject pTitle;
    var GFxObject pAmount;
    var GFxObject pCurrency;
    var GFxObject pAddition;

    structdefaultproperties
    {
        nItem=0
        nLevel=0
        nReward=0
        bCurrency=false
        pObj=none
        pIcon=none
        pFrame=none
        pTitle=none
        pAmount=none
        pCurrency=none
        pAddition=none
    }
};

var int m_nPlayerLevel;
var int m_nMemberDetail;
var int m_nMemberScrollIndex;
var int m_nFriendDetail;
var int m_nFriendScrollIndex;
var int m_nFriendsTotal;
var int m_nFriendsPending;
var int m_nReferredFriendsScrollIndex;
var int m_nSendReferralScrollIndex;
var int m_nReferralTier2Level;
var int m_nReferralReachedTier2;
var int m_nReferralHighestLevel;
var int m_nReferralLongestPlayed;
var int m_nHoursPlayedWithReferrer;
var bool m_bRewardDataLoaded;
var bool m_bInvitationSent;
var float m_fReferralTimeRemaining;
var UISocial.SOCIALSTATE m_eState;
var GFxObject m_mcBack;
var GFxObject m_mcTitle;
var GFxObject m_mcHeader;
var GFxObject m_mcHeaderGlow;
var GFxObject m_mcHeaderButton[5];
var GFxObject m_mcHeaderButtonCTA[5];
var GFxObject m_mcHeaderButtonLine[5];
var GFxObject m_mcHeaderButtonGlow[5];
var GFxObject m_mcHeaderButtonBounds[5];
var GFxObject m_mcHeaderButtonShadow[5];
var GFxObject m_mcHeaderButtonSelected[5];
var GFxObject m_mcHeaderButtonHighlight[5];
var GFxObject m_mcReferral;
var GFxObject m_mcReferralPanel;
var GFxObject m_mcReferralLevels;
var GFxObject m_mcReferralFriends;
var GFxObject m_mcReferralRewards;
var GFxObject m_mcReferralTimeTitle;
var GFxObject m_mcReferralTimeSubtitle;
var GFxObject m_mcReferralButton[3];
var ReferralReward m_ReferralLevels[5];
var ReferralReward m_ReferralRewards[6];
var ReferralReward m_ReferralFriends[5];
var ReferralReward m_ReferredLevels[5];
var ReferralReward m_ReferredFriends[5];
var GFxObject m_mcReferredRewardsPopup;
var GFxObject m_mcReferredRewardsPopupPanel;
var GFxObject m_mcReferredRewardsPopupLevels;
var GFxObject m_mcReferredRewardsPopupButton;
var GFxObject m_mcReferredRewardsPopupFriends;
var GFxObject m_mcReferredRewardsPopupTimeTitle;
var GFxObject m_mcReferredRewardsPopupTimeSubtitle;
var GFxObject m_mcReferredFriendsPopup;
var GFxObject m_mcReferredFriendsPopupList;
var GFxObject m_mcReferredFriendsPopupListScrollbar;
var GFxObject m_mcReferredFriendsPopupName[7];
var GFxObject m_mcReferredFriendsPopupEntry[7];
var GFxObject m_mcReferredFriendsPopupLevel[7];
var GFxObject m_mcReferredFriendsPopupHours[7];
var GFxObject m_mcSendReferralFriendsPopup;
var GFxObject m_mcSendReferralFriendsPopupList;
var GFxObject m_mcSendReferralFriendsPopupListScrollbar;
var GFxObject m_mcSendReferralFriendsPopupEntry[7];
var GFxObject m_mcSendReferralFriendsPopupName[7];
var TgGFxGroup m_grParty;
var TgGFxGroup m_grPartyDetail;
var TgGFxGroup m_grFriends;
var TgGFxGroup m_grFriendDetail;
var TgGFxGroup m_grReferrals;
var TgGFxGroup m_grReferredRewards;
var TgGFxGroup m_grReferredFriends;
var TgGFxGroup m_grSendReferralFriends;
var TgGFxGroup m_grRecentPlayers;
var TgGFxGroup m_grLookingForParty;
var array<UIDataPlayer> m_vReferredFriends;
var GFxObject m_mcFriends;
var GFxObject m_mcFriendsAdd;
var GFxObject m_mcFriendsTitle;
var GFxObject m_mcFriendsInput;
var GFxObject m_mcFriendsSubtitle;
var GFxObject m_mcFriendScrollbar;
var GFxObject m_mcFriend[7];
var GFxObject m_mcFriendIcon[7];
var GFxObject m_mcFriendName[7];
var GFxObject m_mcFriendLevel[7];
var GFxObject m_mcFriendStatus[7];
var GFxObject m_mcFriendSelected[7];
var GFxObject m_mcFriendRankedIndicator[7];
var GFxObject m_mcFriendRankedIndicatorRankIcon[7];
var GFxObject m_mcFriendDetail;
var GFxObject m_mcFriendDetailIcon;
var GFxObject m_mcFriendDetailName;
var GFxObject m_mcFriendDetailLevel;
var GFxObject m_mcFriendDetailStatus;
var GFxObject m_mcFriendDetailButton[3];
var GFxObject m_mcParty;
var GFxObject m_mcPartyAdd;
var GFxObject m_mcPartyInput;
var GFxObject m_mcPartyLeave;
var GFxObject m_mcPartyTitle;
var GFxObject m_mcPartyScrollbar;
var GFxObject m_mcPartyBonus;
var GFxObject m_mcPartyBonusIcon;
var GFxObject m_mcPartyBonusIconIcon;
var GFxObject m_mcPartyBonusIconFrame;
var GFxObject m_mcPartyBonusTitle;
var GFxObject m_mcPartyBonusActive;
var GFxObject m_mcPartyBonusEntry0;
var GFxObject m_mcPartyBonusEntry1;
var GFxObject m_mcPartyBonusEntry2;
var GFxObject m_mcMember[5];
var GFxObject m_mcMemberIcon[5];
var GFxObject m_mcMemberName[5];
var GFxObject m_mcMemberLevel[5];
var GFxObject m_mcMemberStatus[5];
var GFxObject m_mcMemberSelected[5];
var GFxObject m_mcMemberRankedIndicator[7];
var GFxObject m_mcMemberRankedIndicatorRankIcon[7];
var GFxObject m_mcMemberInviteButton[5];
var GFxObject m_mcMemberInviteButtonText[5];
var GFxObject m_mcMemberDetail;
var GFxObject m_mcMemberDetailIcon;
var GFxObject m_mcMemberDetailName;
var GFxObject m_mcMemberDetailLevel;
var GFxObject m_mcMemberDetailStatus;
var GFxObject m_mcMemberDetailButton[3];
var native map{VOID,VOID} m_fInvitesSentTimestamps;

defaultproperties
{
    m_nMemberDetail=-1
    m_nReferralTier2Level=15
    m_OptionList[0]=14
    m_OptionList[1]=4
    m_nBackground=4
    m_bBlur=true
    m_bResetHeaderFocusOnShow=false
    m_bIsOnline=true
    m_bAllowMultipleOnStack=false
    m_Name="UISocial"
}