class OnlineSubsystem extends Object
    abstract
    native
    config(Engine);

const PIT_Game = 0x0001;
const PIT_App = 0x0002;
const PIT_Consumable = 0x0004;
const PIT_Durable = 0x0008;
const PIT_GameDemo = 0x0010;
const PIT_All = 0x001F;

enum ELoginStatus
{
    LS_NotLoggedIn,                 // 0
    LS_UsingLocalProfile,           // 1
    LS_LoggedIn,                    // 2
    LS_MAX                          // 3
};

enum EFeaturePrivilege
{
    FP_OnlinePlay,                  // 0
    FP_CommunicationText,           // 1
    FP_CommunicationVideo,          // 2
    FP_CommunicationVoice,          // 3
    FP_ShareUserCreatedContent,     // 4
    FP_PurchaseContent,             // 5
    FP_ViewPlayerProfile,           // 6
    FP_ShowPresenceInformation,     // 7
    FP_RecordDVRClips,              // 8
    FP_CloudStorage,                // 9
    FP_PremiumContent,              // 10
    FP_PremiumVideoContent,         // 11
    FP_BrowseInternet,              // 12
    FP_SocialNetworkSharing,        // 13
    FP_KinectSharing,               // 14
    FP_FitnessUpload,               // 15
    FP_MAX                          // 16
};

enum EFeaturePrivilegeLevel
{
    FPL_Disabled,                   // 0
    FPL_EnabledFriendsOnly,         // 1
    FPL_Enabled,                    // 2
    FPL_MAX                         // 3
};

enum EReputationFeedbackType
{
    RFBT_CommunicationsAbusiveVoice,// 0
    RFBT_CommunicationsInappropriateVideo,// 1
    RFBT_FairPlayCheater,           // 2
    RFBT_FairPlayKicked,            // 3
    RFBT_FairPlayKillsTeammates,    // 4
    RFBT_FairPlayQuitter,           // 5
    RFBT_FairPlayTampering,         // 6
    RFBT_InappropriateUserGeneratedContent,// 7
    RFBT_PositiveHelpfulPlayer,     // 8
    RFBT_PositiveHighQualityUserGeneratedContent,// 9
    RFBT_PositiveSkilledPlayer,     // 10
    RFBT_MAX                        // 11
};

enum ENetworkNotificationPosition
{
    NNP_TopLeft,                    // 0
    NNP_TopCenter,                  // 1
    NNP_TopRight,                   // 2
    NNP_CenterLeft,                 // 3
    NNP_Center,                     // 4
    NNP_CenterRight,                // 5
    NNP_BottomLeft,                 // 6
    NNP_BottomCenter,               // 7
    NNP_BottomRight,                // 8
    NNP_MAX                         // 9
};

enum EOnlineGameState
{
    OGS_NoSession,                  // 0
    OGS_Pending,                    // 1
    OGS_Starting,                   // 2
    OGS_InProgress,                 // 3
    OGS_Ending,                     // 4
    OGS_Ended,                      // 5
    OGS_MAX                         // 6
};

enum EOnlineEnumerationReadState
{
    OERS_NotStarted,                // 0
    OERS_InProgress,                // 1
    OERS_Done,                      // 2
    OERS_Failed,                    // 3
    OERS_MAX                        // 4
};

enum EOnlineAccountTier
{
    OAT_Unknown,                    // 0
    OAT_NewUser,                    // 1
    OAT_Silver,                     // 2
    OAT_Gold,                       // 3
    OAT_FamilyGold,                 // 4
    OAT_MAX                         // 5
};

enum EOnlineFriendState
{
    OFS_Offline,                    // 0
    OFS_Online,                     // 1
    OFS_Away,                       // 2
    OFS_Busy,                       // 3
    OFS_MAX                         // 4
};

enum EOnlineCreateGameSessionFlag
{
    OCGSF_New,                      // 0
    OCGSF_ReSubmit,                 // 1
    OCGSF_MAX                       // 2
};

enum EOnlineContentType
{
    OCT_Downloaded,                 // 0
    OCT_SaveGame,                   // 1
    OCT_MAX                         // 2
};

enum EOnlineServerConnectionStatus
{
    OSCS_NotConnected,              // 0
    OSCS_Connected,                 // 1
    OSCS_ConnectionDropped,         // 2
    OSCS_NoNetworkConnection,       // 3
    OSCS_ServiceUnavailable,        // 4
    OSCS_UpdateRequired,            // 5
    OSCS_ServersTooBusy,            // 6
    OSCS_DuplicateLoginDetected,    // 7
    OSCS_InvalidUser,               // 8
    OSCS_Banned,                    // 9
    OSCS_TooYoung,                  // 10
    OSCS_PSNUnavailable,            // 11
    OSCS_MAX                        // 12
};

enum ENATType
{
    NAT_Unknown,                    // 0
    NAT_Open,                       // 1
    NAT_Moderate,                   // 2
    NAT_Strict,                     // 3
    NAT_MAX                         // 4
};

enum ELanBeaconState
{
    LANB_NotUsingLanBeacon,         // 0
    LANB_Hosting,                   // 1
    LANB_Searching,                 // 2
    LANB_MAX                        // 3
};

enum EOnlineAccountCreateStatus
{
    OACS_CreateSuccessful,          // 0
    OACS_UnknownError,              // 1
    OACS_InvalidUserName,           // 2
    OACS_InvalidPassword,           // 3
    OACS_InvalidUniqueUserName,     // 4
    OACS_UniqueUserNameInUse,       // 5
    OACS_ServiceUnavailable,        // 6
    OACS_MAX                        // 7
};

enum EOnlineFileType
{
    OFT_Unknown,                    // 0
    OFT_Binary,                     // 1
    OFT_Json,                       // 2
    OFT_MAX                         // 3
};

enum EAchievementRewardType
{
    ART_Unknown,                    // 0
    ART_Gamerscore,                 // 1
    ART_InApp,                      // 2
    ART_Art,                        // 3
    ART_MAX                         // 4
};

enum EAchievementMediaAssetType
{
    AMAT_Unknown,                   // 0
    AMAT_Icon,                      // 1
    AMAT_Art,                       // 2
    AMAT_MAX                        // 3
};

enum EAchievementUnlockType
{
    AUT_Unknown,                    // 0
    AUT_All,                        // 1
    AUT_Persistent,                 // 2
    AUT_Challenge,                  // 3
    AUT_MAX                         // 4
};

enum EAchievementParticipationType
{
    EAPT_Unknown,                   // 0
    EAPT_Individual,                // 1
    EAPT_Group,                     // 2
    EAPT_MAX                        // 3
};

enum EAchievementProgressState
{
    APS_Unknown,                    // 0
    APS_Achieved,                   // 1
    APS_NotStarted,                 // 2
    APS_InProgress,                 // 3
    APS_MAX                         // 4
};

enum ECatalogSortOrder
{
    CSO_FreeAndPaidCountDaily,      // 0
    CSO_PaidCountAllTime,           // 1
    CSO_PaidCountDail,              // 2
    CSO_DigitalReleaseDate,         // 3
    CSO_ReleaseDate,                // 4
    CSO_UserRatings,                // 5
    CSO_MAX                         // 6
};

enum EMediaItemType
{
    MIT_Unknown,                    // 0
    MIT_Game,                       // 1
    MIT_Application,                // 2
    MIT_GameContent,                // 3
    MIT_GameConsumable,             // 4
    MIT_Subscription,               // 5
    MIT_MAX                         // 6
};

enum EInventoryItemState
{
    IIS_Unknown,                    // 0
    IIS_All,                        // 1
    IIS_Enabled,                    // 2
    IIS_Suspended,                  // 3
    IIS_Expired,                    // 4
    IIS_Canceled,                   // 5
    IIS_MAX                         // 6
};

enum EOnlineNewsType
{
    ONT_Unknown,                    // 0
    ONT_GameNews,                   // 1
    ONT_ContentAnnouncements,       // 2
    ONT_Misc,                       // 3
    ONT_MAX                         // 4
};

enum ESessionMemberStatus
{
    DSMS_Reserved,                  // 0
    DSMS_Inactive,                  // 1
    DSMS_Ready,                     // 2
    DSMS_Active,                    // 3
    DSMS_MAX                        // 4
};

struct native UniqueNetId
{
    var QWord Uid;

    structdefaultproperties
    {
        Uid=()
    }
};

struct native FriendsQuery
{
    var UniqueNetId UniqueId;
    var bool bIsFriend;

    structdefaultproperties
    {
        UniqueId=(Uid=())
        bIsFriend=false
    }
};

struct native OnlineProfile
{
    var string UserId;
    var OnlineSubsystem.EOnlineAccountTier AccountTier;
    var int Gamerscore;
    var string ApplicationDisplayName;
    var string GameDisplayName;
    var string ApplicationDisplayPictureResizeURL;
    var string GameDisplayPictureResizeURL;

    structdefaultproperties
    {
        UserId=""
        AccountTier=EOnlineAccountTier.OAT_Unknown
        Gamerscore=0
        ApplicationDisplayName=""
        GameDisplayName=""
        ApplicationDisplayPictureResizeURL=""
        GameDisplayPictureResizeURL=""
    }
};

struct native OnlineFriend
{
    var const UniqueNetId UniqueId;
    var const QWord SessionId;
    var const string NickName;
    var const string PresenceInfo;
    var const string AdditionalPresenceInfo;
    var const OnlineSubsystem.EOnlineFriendState FriendState;
    var const bool bIsOnline;
    var const bool bIsPlaying;
    var const bool bIsPlayingThisGame;
    var const bool bIsPlayingPartnerGame;
    var const bool bIsJoinable;
    var const bool bHasVoiceSupport;
    var bool bHaveInvited;
    var const bool bHasInvitedYou;

    structdefaultproperties
    {
        UniqueId=(Uid=())
        SessionId=()
        NickName=""
        PresenceInfo=""
        AdditionalPresenceInfo=""
        FriendState=EOnlineFriendState.OFS_Offline
        bIsOnline=false
        bIsPlaying=false
        bIsPlayingThisGame=false
        bIsPlayingPartnerGame=false
        bIsJoinable=false
        bHasVoiceSupport=false
        bHaveInvited=false
        bHasInvitedYou=false
    }
};

struct native OnlineContent
{
    var OnlineSubsystem.EOnlineContentType ContentType;
    var byte UserIndex;
    var bool bIsCorrupt;
    var int DeviceID;
    var int LicenseMask;
    var string FriendlyName;
    var string Filename;
    var string ContentPath;
    var array<string> ContentPackages;
    var array<string> ContentFiles;

    structdefaultproperties
    {
        ContentType=EOnlineContentType.OCT_Downloaded
        UserIndex=0
        bIsCorrupt=false
        DeviceID=0
        LicenseMask=0
        FriendlyName=""
        Filename=""
        ContentPath=""
        ContentPackages=none
        ContentFiles=none
    }
};

struct native OnlineCrossTitleContent extends OnlineContent
{
    var int TitleId;
};

struct native OnlineRegistrant
{
    var const UniqueNetId PlayerNetId;

    structdefaultproperties
    {
        PlayerNetId=(Uid=())
    }
};

struct native OnlineArbitrationRegistrant extends OnlineRegistrant
{
    var const QWord MachineId;
    var const int Trustworthiness;
};

struct SpeechRecognizedWord
{
    var int WordId;
    var string WordText;
    var float Confidence;

    structdefaultproperties
    {
        WordId=0
        WordText=""
        Confidence=0.0000000
    }
};

struct native OnlinePlayerScore
{
    var UniqueNetId PlayerID;
    var int TeamID;
    var int Score;

    structdefaultproperties
    {
        PlayerID=(Uid=())
        TeamID=0
        Score=0
    }
};

struct native LocalTalker
{
    var bool bHasVoice;
    var bool bHasNetworkedVoice;
    var bool bIsRecognizingSpeech;
    var bool bWasTalking;
    var bool bIsTalking;
    var bool bIsRegistered;
    var float TimeSinceLastPacket;

    structdefaultproperties
    {
        bHasVoice=false
        bHasNetworkedVoice=false
        bIsRecognizingSpeech=false
        bWasTalking=false
        bIsTalking=false
        bIsRegistered=false
        TimeSinceLastPacket=0.0000000
    }
};

struct native RemoteTalker
{
    var UniqueNetId TalkerId;
    var float LastNotificationTime;
    var bool bWasTalking;
    var bool bIsTalking;
    var bool bIsRegistered;
    var float TimeSinceLastPacket;
    var float TimeSinceJoining;

    structdefaultproperties
    {
        TalkerId=(Uid=())
        LastNotificationTime=0.0000000
        bWasTalking=false
        bIsTalking=false
        bIsRegistered=false
        TimeSinceLastPacket=0.0000000
        TimeSinceJoining=0.0000000
    }
};

struct native OnlineFriendMessage
{
    var UniqueNetId SendingPlayerId;
    var string SendingPlayerNick;
    var bool bIsFriendInvite;
    var bool bIsGameInvite;
    var bool bWasAccepted;
    var bool bWasDenied;
    var string Message;

    structdefaultproperties
    {
        SendingPlayerId=(Uid=())
        SendingPlayerNick=""
        bIsFriendInvite=false
        bIsGameInvite=false
        bWasAccepted=false
        bWasDenied=false
        Message=""
    }
};

struct native NamedInterface
{
    var name InterfaceName;
    var Object InterfaceObject;

    structdefaultproperties
    {
        InterfaceName="None"
        InterfaceObject=none
    }
};

struct native NamedInterfaceDef
{
    var name InterfaceName;
    var string InterfaceClassName;

    structdefaultproperties
    {
        InterfaceName="None"
        InterfaceClassName=""
    }
};

struct native EmsFile
{
    var string Hash;
    var string DLName;
    var string Filename;
    var int FileSize;

    structdefaultproperties
    {
        Hash=""
        DLName=""
        Filename=""
        FileSize=0
    }
};

struct native TitleFile
{
    var string Filename;
    var OnlineSubsystem.EOnlineEnumerationReadState AsyncState;
    var array<byte> Data;

    structdefaultproperties
    {
        Filename=""
        AsyncState=EOnlineEnumerationReadState.OERS_NotStarted
        Data=none
    }
};

struct native CommunityContentFile
{
    var int ContentId;
    var string RemoteContentPath;
    var OnlineSubsystem.EOnlineFileType ContentType;
    var int FileSize;
    var UniqueNetId Owner;
    var int DownloadCount;
    var float AverageRating;
    var int RatingCount;
    var int LastRatingGiven;
    var string LocalFilePath;

    structdefaultproperties
    {
        ContentId=0
        RemoteContentPath=""
        ContentType=EOnlineFileType.OFT_Unknown
        FileSize=0
        Owner=(Uid=())
        DownloadCount=0
        AverageRating=0.0000000
        RatingCount=0
        LastRatingGiven=0
        LocalFilePath=""
    }
};

struct native CommunityContentMetadata
{
    var OnlineSubsystem.EOnlineFileType ContentType;
    var string RemotePath;
    var string DisplayName;

    structdefaultproperties
    {
        ContentType=EOnlineFileType.OFT_Unknown
        RemotePath=""
        DisplayName=""
    }
};

struct native UserAccountInfo
{
    var string DateOfBirth;
    var string Email;
    var string FirstName;
    var string LastName;
    var string Gamertag;

    structdefaultproperties
    {
        DateOfBirth=""
        Email=""
        FirstName=""
        LastName=""
        Gamertag=""
    }
};

struct native NamedSession
{
    var name SessionName;
    var native const transient Pointer SessionInfo;
    var OnlineGameSettings GameSettings;
    var array<OnlineRegistrant> Registrants;
    var array<OnlineArbitrationRegistrant> ArbitrationRegistrants;

    structdefaultproperties
    {
        SessionName="None"
        GameSettings=none
        Registrants=none
        ArbitrationRegistrants=none
    }
};

struct native AchievementReward
{
    var const string RewardName;
    var const string Description;
    var const string Data;
    var const OnlineSubsystem.EAchievementRewardType RewardType;

    structdefaultproperties
    {
        RewardName=""
        Description=""
        Data=""
        RewardType=EAchievementRewardType.ART_Unknown
    }
};

struct native AchievementMediaAsset
{
    var const string AssetName;
    var const OnlineSubsystem.EAchievementMediaAssetType AssetType;
    var const string AssetURL;

    structdefaultproperties
    {
        AssetName=""
        AssetType=EAchievementMediaAssetType.AMAT_Unknown
        AssetURL=""
    }
};

struct native AchievementTitleAssociation
{
    var const string LocalizedTitleName;
    var const int TitleId;

    structdefaultproperties
    {
        LocalizedTitleName=""
        TitleId=0
    }
};

struct native AchievementDetails
{
    var const int Id;
    var const string StringId;
    var const string AchievementName;
    var const string Description;
    var const string HowTo;
    var Surface Image;
    var const byte MonthEarned;
    var const byte DayEarned;
    var const byte YearEarned;
    var const byte DayOfWeekEarned;
    var const int GamerPoints;
    var const bool bIsSecret;
    var const bool bWasAchievedOnline;
    var const bool bWasAchievedOffline;
    var const OnlineSubsystem.EAchievementUnlockType UnlockType;
    var const QWord ChallengeWindowBegin;
    var const QWord ChallengeWindowEnd;
    var const string DeepLink;
    var const QWord EstimatedUnlockTime;
    var const bool bIsRevoked;
    var const OnlineSubsystem.EAchievementParticipationType ParticipationType;
    var const array<string> PlatformsAvailableOn;
    var const OnlineSubsystem.EAchievementProgressState ProgressState;
    var const array<AchievementReward> Rewards;
    var const array<AchievementMediaAsset> MediaAssets;
    var const string ProductID;
    var const string ServiceConfigurationID;
    var const array<AchievementTitleAssociation> TitleAssociations;

    structdefaultproperties
    {
        Id=0
        StringId=""
        AchievementName=""
        Description=""
        HowTo=""
        Image=none
        MonthEarned=0
        DayEarned=0
        YearEarned=0
        DayOfWeekEarned=0
        GamerPoints=0
        bIsSecret=false
        bWasAchievedOnline=false
        bWasAchievedOffline=false
        UnlockType=EAchievementUnlockType.AUT_Unknown
        ChallengeWindowBegin=()
        ChallengeWindowEnd=()
        DeepLink=""
        EstimatedUnlockTime=()
        bIsRevoked=false
        ParticipationType=EAchievementParticipationType.EAPT_Unknown
        PlatformsAvailableOn=none
        ProgressState=EAchievementProgressState.APS_Unknown
        Rewards=none
        MediaAssets=none
        ProductID=""
        ServiceConfigurationID=""
        TitleAssociations=none
    }
};

struct native MarketplaceProductAvailability
{
    var const array<string> AcceptablePaymentInstrumentTypes;
    var const string Description;
    var const string Title;
    var const int ConsumableQuantity;
    var const string ContentId;
    var const string CurrencyCode;
    var const string DisplayListPrice;
    var const string DisplayPrice;
    var const string DistributionType;
    var const bool bIsPurchasable;
    var const float ListPrice;
    var const string OfferId;
    var const float Price;
    var const string PromotionalText;
    var const string SignedOffer;

    structdefaultproperties
    {
        AcceptablePaymentInstrumentTypes=none
        Description=""
        Title=""
        ConsumableQuantity=0
        ContentId=""
        CurrencyCode=""
        DisplayListPrice=""
        DisplayPrice=""
        DistributionType=""
        bIsPurchasable=false
        ListPrice=0.0000000
        OfferId=""
        Price=0.0000000
        PromotionalText=""
        SignedOffer=""
    }
};

struct native MarketplaceProductImage
{
    var const string Id;
    var const int Height;
    var const int Width;
    var const string Purpose;
    var const array<string> Purposes;
    var const string ResizeURL;

    structdefaultproperties
    {
        Id=""
        Height=0
        Width=0
        Purpose=""
        Purposes=none
        ResizeURL=""
    }
};

struct native MarketplaceProductDetails
{
    var const string StandardId;
    var const OnlineSubsystem.EMediaItemType MediaItemType;
    var const string ProductName;
    var const string ProductID;
    var const QWord ReleaseDate;
    var const string SandboxId;
    var const int TitleId;
    var const bool bIsBundle;
    var const bool bIsPartOfAnyBundle;
    var const string ReducedName;
    var const array<MarketplaceProductImage> Images;
    var OnlineSubsystem.EOnlineEnumerationReadState DetailsReadState;
    var const array<MarketplaceProductAvailability> Availabilities;
    var const string ProductDescription;

    structdefaultproperties
    {
        StandardId=""
        MediaItemType=EMediaItemType.MIT_Unknown
        ProductName=""
        ProductID=""
        ReleaseDate=()
        SandboxId=""
        TitleId=0
        bIsBundle=false
        bIsPartOfAnyBundle=false
        ReducedName=""
        Images=none
        DetailsReadState=EOnlineEnumerationReadState.OERS_NotStarted
        Availabilities=none
        ProductDescription=""
    }
};

struct native MarketplaceInventoryItem
{
    var const string ProductID;
    var const OnlineSubsystem.EMediaItemType MediaItemType;
    var const OnlineSubsystem.EInventoryItemState ItemState;
    var const int ConsumableBalance;
    var const int TitleId;
    var const array<string> ContainerIds;
    var const QWord StartDate;
    var const QWord EndDate;
    var const QWord RightsObtainedDate;
    var const string URL;
    var const string ConsumableUrl;

    structdefaultproperties
    {
        ProductID=""
        MediaItemType=EMediaItemType.MIT_Unknown
        ItemState=EInventoryItemState.IIS_Unknown
        ConsumableBalance=0
        TitleId=0
        ContainerIds=none
        StartDate=()
        EndDate=()
        RightsObtainedDate=()
        URL=""
        ConsumableUrl=""
    }
};

struct native SessionMemberInfo
{
    var UniqueNetId PlayerNetId;
    var OnlineSubsystem.ESessionMemberStatus MemberStatus;
    var init string SecureAddress;
    var init string NickName;
    var bool Muted;

    structdefaultproperties
    {
        PlayerNetId=(Uid=())
        MemberStatus=ESessionMemberStatus.DSMS_Reserved
        SecureAddress=""
        NickName=""
        Muted=false
    }
};

struct native PermissionsResult
{
    var SessionMemberInfo User;
    var bool bHasPermission;

    structdefaultproperties
    {
        User=(PlayerNetId=(Uid=()),MemberStatus=ESessionMemberStatus.DSMS_Reserved,SecureAddress="",NickName="",Muted=false)
        bHasPermission=false
    }
};

struct native OnlinePartyMember
{
    var const UniqueNetId UniqueId;
    var const string NickName;
    var const byte LocalUserNum;
    var const OnlineSubsystem.ENATType NatType;
    var const int TitleId;
    var const bool bIsLocal;
    var const bool bIsInPartyVoice;
    var const bool bIsTalking;
    var const bool bIsInGameSession;
    var const bool bIsPlayingThisGame;
    var const QWord SessionId;
    var const int Data1;
    var const int Data2;
    var const int Data3;
    var const int Data4;

    structdefaultproperties
    {
        UniqueId=(Uid=())
        NickName=""
        LocalUserNum=0
        NatType=ENATType.NAT_Unknown
        TitleId=0
        bIsLocal=false
        bIsInPartyVoice=false
        bIsTalking=false
        bIsInGameSession=false
        bIsPlayingThisGame=false
        SessionId=()
        Data1=0
        Data2=0
        Data3=0
        Data4=0
    }
};

struct native SocialPostPrivileges
{
    var const bool bCanPostImage;
    var const bool bCanPostLink;

    structdefaultproperties
    {
        bCanPostImage=false
        bCanPostLink=false
    }
};

struct native SocialPostImageFlags
{
    var bool bIsUserGeneratedImage;
    var bool bIsGameGeneratedImage;
    var bool bIsAchievementImage;
    var bool bIsMediaImage;

    structdefaultproperties
    {
        bIsUserGeneratedImage=false
        bIsGameGeneratedImage=false
        bIsAchievementImage=false
        bIsMediaImage=false
    }
};

struct native SocialPostImageInfo
{
    var SocialPostImageFlags Flags;
    var string MessageText;
    var string TitleText;
    var string PictureCaption;
    var string PictureDescription;

    structdefaultproperties
    {
        Flags=(bIsUserGeneratedImage=false,bIsGameGeneratedImage=false,bIsAchievementImage=false,bIsMediaImage=false)
        MessageText=""
        TitleText=""
        PictureCaption=""
        PictureDescription=""
    }
};

struct native SocialPostLinkInfo extends SocialPostImageInfo
{
    var string TitleURL;
    var string PictureURL;
};

struct native SessionUpdateInfo
{
    var const array<SessionMemberInfo> MembersJoined;
    var const array<SessionMemberInfo> MembersLeft;
    var const bool bHostDeviceTokenChanged;
    var const bool bInitializationStateChanged;
    var const bool bMatchmakingStatusChanged;
    var const bool bMemberJoinedOrLeft;
    var const bool bMemberStatusChanged;
    var const bool bSessionJoinabilityChanged;
    var const bool bCustomPropertyChange;
    var const bool bMemberCustomPropertyChange;

    structdefaultproperties
    {
        MembersJoined=none
        MembersLeft=none
        bHostDeviceTokenChanged=false
        bInitializationStateChanged=false
        bMatchmakingStatusChanged=false
        bMemberJoinedOrLeft=false
        bMemberStatusChanged=false
        bSessionJoinabilityChanged=false
        bCustomPropertyChange=false
        bMemberCustomPropertyChange=false
    }
};

var private native const noexport Pointer VfTable_FTickableObject;
var OnlineAccountInterface AccountInterface;
var OnlinePlayerInterface PlayerInterface;
var OnlinePlayerInterfaceEx PlayerInterfaceEx;
var OnlineMarketplaceInterface MarketplaceInterface;
var OnlineSystemInterface SystemInterface;
var OnlineGameInterface GameInterface;
var OnlineContentInterface ContentInterface;
var OnlineVoiceInterface VoiceInterface;
var OnlineStatsInterface StatsInterface;
var OnlineNewsInterface NewsInterface;
var OnlinePartyChatInterface PartyChatInterface;
var OnlineTitleFileInterface TitleFileInterface;
var OnlineTitleFileCacheInterface TitleFileCacheInterface;
var UserCloudFileInterface UserCloudInterface;
var SharedCloudFileInterface SharedCloudInterface;
var OnlineSocialInterface SocialInterface;
var OnlineChatInterface ChatInterface;
var OnlineAuthInterface AuthInterface;
var OnlineGameDVRInterface GameDVRInterface;
var OnlineCommunityContentInterface CommunityContentInterface;
var native UniqueNetId LoggedInPlayerNetId;
var private array<NamedInterface> NamedInterfaces;
var config array<config NamedInterfaceDef> NamedInterfaceDefs;
var protected const array<NamedSession> Sessions;
var array<SessionMemberInfo> PartyMemberList;
var array<SessionMemberInfo> GameMemberList;
var bool bCameFromAutoLogin;
var config bool bUseBuildIdOverride;
var config int BuildIdOverride;
var config string IniLocPatcherClassName;
var transient IniLocPatcher Patcher;
var config float AsyncMinCompletionTime;
var const config string DefaultSessionTemplateName;
var const config string PartySessionTemplateName;

// Export UOnlineSubsystem::execInit(FFrame&, void* const)
native event bool Init();

event bool PostInit()
{
    local Class<IniLocPatcher> IniLocPatcherClass;

    // End:0x8B
    if(IniLocPatcherClassName != "")
    {
        IniLocPatcherClass = Class<IniLocPatcher>(DynamicLoadObject(IniLocPatcherClassName, Class'Core.Class'));
        Patcher = new IniLocPatcherClass;
        // End:0x89
        if(Patcher != none)
        {
            Patcher.Init();            
        }
        else
        {
            return false;
        }
    }
    return true;
    //return ReturnValue;    
}

// Export UOnlineSubsystem::execExit(FFrame&, void* const)
native event Exit();

event bool SetAccountInterface(Object NewInterface)
{
    AccountInterface = OnlineAccountInterface(NewInterface);
    return NotEqual_InterfaceInterface(AccountInterface, OnlineAccountInterface(none));
    //return ReturnValue;    
}

event bool SetPlayerInterface(Object NewInterface)
{
    PlayerInterface = OnlinePlayerInterface(NewInterface);
    return NotEqual_InterfaceInterface(PlayerInterface, OnlinePlayerInterface(none));
    //return ReturnValue;    
}

event bool SetPlayerInterfaceEx(Object NewInterface)
{
    PlayerInterfaceEx = OnlinePlayerInterfaceEx(NewInterface);
    return NotEqual_InterfaceInterface(PlayerInterfaceEx, OnlinePlayerInterfaceEx(none));
    //return ReturnValue;    
}

event bool SetMarketplaceInterface(Object NewInterface)
{
    MarketplaceInterface = OnlineMarketplaceInterface(NewInterface);
    return NotEqual_InterfaceInterface(MarketplaceInterface, OnlineMarketplaceInterface(none));
    //return ReturnValue;    
}

event bool SetSystemInterface(Object NewInterface)
{
    SystemInterface = OnlineSystemInterface(NewInterface);
    return NotEqual_InterfaceInterface(SystemInterface, OnlineSystemInterface(none));
    //return ReturnValue;    
}

event bool SetGameInterface(Object NewInterface)
{
    GameInterface = OnlineGameInterface(NewInterface);
    return NotEqual_InterfaceInterface(GameInterface, OnlineGameInterface(none));
    //return ReturnValue;    
}

event bool SetContentInterface(Object NewInterface)
{
    ContentInterface = OnlineContentInterface(NewInterface);
    return NotEqual_InterfaceInterface(ContentInterface, OnlineContentInterface(none));
    //return ReturnValue;    
}

event bool SetVoiceInterface(Object NewInterface)
{
    VoiceInterface = OnlineVoiceInterface(NewInterface);
    return NotEqual_InterfaceInterface(VoiceInterface, OnlineVoiceInterface(none));
    //return ReturnValue;    
}

event bool SetStatsInterface(Object NewInterface)
{
    StatsInterface = OnlineStatsInterface(NewInterface);
    return NotEqual_InterfaceInterface(StatsInterface, OnlineStatsInterface(none));
    //return ReturnValue;    
}

event bool SetNewsInterface(Object NewInterface)
{
    NewsInterface = OnlineNewsInterface(NewInterface);
    return NotEqual_InterfaceInterface(NewsInterface, OnlineNewsInterface(none));
    //return ReturnValue;    
}

event bool SetPartyChatInterface(Object NewInterface)
{
    PartyChatInterface = OnlinePartyChatInterface(NewInterface);
    return NotEqual_InterfaceInterface(PartyChatInterface, OnlinePartyChatInterface(none));
    //return ReturnValue;    
}

event bool SetTitleFileInterface(Object NewInterface)
{
    TitleFileInterface = OnlineTitleFileInterface(NewInterface);
    return NotEqual_InterfaceInterface(TitleFileInterface, OnlineTitleFileInterface(none));
    //return ReturnValue;    
}

event bool SetGameChatInterface(Object NewInterface)
{
    ChatInterface = OnlineChatInterface(NewInterface);
    return NotEqual_InterfaceInterface(ChatInterface, OnlineChatInterface(none));
    //return ReturnValue;    
}

event bool SetTitleFileCacheInterface(Object NewInterface)
{
    TitleFileCacheInterface = OnlineTitleFileCacheInterface(NewInterface);
    return NotEqual_InterfaceInterface(TitleFileCacheInterface, OnlineTitleFileCacheInterface(none));
    //return ReturnValue;    
}

event bool SetSocialInterface(Object InSocialInterface)
{
    SocialInterface = OnlineSocialInterface(InSocialInterface);
    return NotEqual_InterfaceInterface(SocialInterface, OnlineSocialInterface(none));
    //return ReturnValue;    
}

event bool SetAuthInterface(Object InAuthInterface)
{
    AuthInterface = OnlineAuthInterface(InAuthInterface);
    return NotEqual_InterfaceInterface(AuthInterface, OnlineAuthInterface(none));
    //return ReturnValue;    
}

event bool SetUserCloudInterface(Object InCloudInterface)
{
    UserCloudInterface = UserCloudFileInterface(InCloudInterface);
    return NotEqual_InterfaceInterface(UserCloudInterface, UserCloudFileInterface(none));
    //return ReturnValue;    
}

event bool SetSharedCloudInterface(Object InCloudInterface)
{
    SharedCloudInterface = SharedCloudFileInterface(InCloudInterface);
    return NotEqual_InterfaceInterface(SharedCloudInterface, SharedCloudFileInterface(none));
    //return ReturnValue;    
}

event bool SetGameDVRInterface(Object InGameDVRInterface)
{
    GameDVRInterface = OnlineGameDVRInterface(InGameDVRInterface);
    return NotEqual_InterfaceInterface(GameDVRInterface, OnlineGameDVRInterface(none));
    //return ReturnValue;    
}

event bool SetCommunityContentInterface(Object InCommunityContentInterface)
{
    CommunityContentInterface = OnlineCommunityContentInterface(InCommunityContentInterface);
    return NotEqual_InterfaceInterface(CommunityContentInterface, OnlineCommunityContentInterface(none));
    //return ReturnValue;    
}

event SetNamedInterface(name InterfaceName, Object NewInterface)
{
    local int InterfaceIndex;

    InterfaceIndex = NamedInterfaces.Find('InterfaceName', InterfaceName);
    // End:0x98
    if(InterfaceIndex == -1)
    {
        InterfaceIndex = NamedInterfaces.Length;
        NamedInterfaces.Length = NamedInterfaces.Length + 1;
        NamedInterfaces[InterfaceIndex].InterfaceName = InterfaceName;
    }
    NamedInterfaces[InterfaceIndex].InterfaceObject = NewInterface;
    //return;    
}

event Object GetNamedInterface(name InterfaceName)
{
    local int InterfaceIndex;

    InterfaceIndex = NamedInterfaces.Find('InterfaceName', InterfaceName);
    // End:0x63
    if(InterfaceIndex != -1)
    {
        return NamedInterfaces[InterfaceIndex].InterfaceObject;
    }
    return none;
    //return ReturnValue;    
}

// Export UOnlineSubsystem::execRaiseEvent(FFrame&, void* const)
native event bool RaiseEvent(const string EventName, const array<string> EventParams);

// Export UOnlineSubsystem::execUniqueNetIdToString(FFrame&, void* const)
native static final function string UniqueNetIdToString(const out UniqueNetId IdToConvert, optional bool Hex = true);

// Export UOnlineSubsystem::execStringToUniqueNetId(FFrame&, void* const)
native static final function bool StringToUniqueNetId(string UniqueNetIdString, out UniqueNetId out_UniqueId);

event UniqueNetId GetPlayerUniqueNetIdFromIndex(int UserIndex)
{
    local UniqueNetId ReturnVal, NullId;

    // End:0x6E
    if(EqualEqual_InterfaceInterface(PlayerInterface, OnlinePlayerInterface(none)) || !PlayerInterface.GetUniquePlayerId(byte(UserIndex), ReturnVal))
    {
        ReturnVal = NullId;
    }
    return ReturnVal;
    //return ReturnValue;    
}

event OnlineSubsystem.ELoginStatus GetLoginStatus(byte UserIndex)
{
    local OnlineSubsystem.ELoginStatus ReturnVal;

    ReturnVal = 0;
    // End:0x5F
    if(NotEqual_InterfaceInterface(PlayerInterface, OnlinePlayerInterface(none)))
    {
        ReturnVal = PlayerInterface.GetLoginStatus(UserIndex);
    }
    return ReturnVal;
    //return ReturnValue;    
}

event bool PreLogin()
{
    return true;
    //return ReturnValue;    
}

// Export UOnlineSubsystem::execGetBuildUniqueId(FFrame&, void* const)
native function int GetBuildUniqueId();

// Export UOnlineSubsystem::execGetNumSupportedLogins(FFrame&, void* const)
native static final function int GetNumSupportedLogins();

function bool IsInSession(name SessionName)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x67 [Loop If]
    if(I < Sessions.Length)
    {
        // End:0x59
        if(Sessions[I].SessionName == SessionName)
        {
            return true;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    return false;
    //return ReturnValue;    
}

static function DumpGameSettings(const OnlineGameSettings GameSettings)
{
    //return;    
}

function DumpSessionState()
{
    local int Index, PlayerIndex;
    local UniqueNetId NetId, ZeroId;

    NetId = ZeroId;
    ZeroId = NetId;
    Index = 0;
    J0x31:

    // End:0x1BD [Loop If]
    if(Index < Sessions.Length)
    {
        DumpGameSettings(Sessions[Index].GameSettings);
        PlayerIndex = 0;
        J0x84:

        // End:0x114 [Loop If]
        if(PlayerIndex < Sessions[Index].Registrants.Length)
        {
            NetId = Sessions[Index].Registrants[PlayerIndex].PlayerNetId;
            PlayerIndex++;
            // [Loop Continue]
            goto J0x84;
        }
        PlayerIndex = 0;
        J0x11F:

        // End:0x1AF [Loop If]
        if(PlayerIndex < Sessions[Index].ArbitrationRegistrants.Length)
        {
            NetId = Sessions[Index].ArbitrationRegistrants[PlayerIndex].PlayerNetId;
            PlayerIndex++;
            // [Loop Continue]
            goto J0x11F;
        }
        Index++;
        // [Loop Continue]
        goto J0x31;
    }
    //return;    
}

function DumpVoiceRegistration()
{
    //return;    
}

function SetDebugSpewLevel(int DebugSpewLevel)
{
    //return;    
}

defaultproperties
{
    NamedInterfaceDefs[0]=(InterfaceName="RecentPlayersList",InterfaceClassName="Engine.OnlineRecentPlayersList")
}