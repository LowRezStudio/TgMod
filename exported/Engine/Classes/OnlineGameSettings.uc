class OnlineGameSettings extends Settings
    native;

var databinding int NumPublicConnections;
var databinding int NumPrivateConnections;
var databinding int NumOpenPublicConnections;
var databinding int NumOpenPrivateConnections;
var const QWord ServerNonce;
var string ServiceConfigId;
var string SessionTemplateName;
var string MatchHopperName;
var string SessionGuid;
var string SessionHandle;
var array<UniqueNetId> ReservedMembers;
var databinding bool bShouldAdvertise;
var databinding bool bIsLanMatch;
var databinding bool bUsesStats;
var databinding bool bAllowJoinInProgress;
var bool bPublic;
var databinding bool bAllowInvites;
var databinding bool bUsesPresence;
var databinding bool bAllowJoinViaPresence;
var databinding bool bAllowJoinViaPresenceFriendsOnly;
var databinding bool bUsesArbitration;
var databinding bool bAntiCheatProtected;
var const bool bWasFromInvite;
var databinding bool bIsDedicated;
var const bool bHasSkillUpdateInProgress;
var const bool bShouldShrinkArbitratedSessions;
var databinding string OwningPlayerName;
var UniqueNetId OwningPlayerId;
var databinding int PingInMs;
var databinding float MatchQuality;
var databinding const OnlineSubsystem.EOnlineGameState GameState;
var const int BuildUniqueId;

defaultproperties
{
    bShouldAdvertise=true
    bUsesStats=true
    bAllowJoinInProgress=true
    bAllowInvites=true
    bUsesPresence=true
    bAllowJoinViaPresence=true
    bShouldShrinkArbitratedSessions=true
}