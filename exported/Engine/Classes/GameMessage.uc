class GameMessage extends LocalMessage;

var const localized string SwitchLevelMessage;
var const localized string LeftMessage;
var const localized string FailedTeamMessage;
var const localized string FailedPlaceMessage;
var const localized string FailedSpawnMessage;
var const localized string EnteredMessage;
var const localized string MaxedOutMessage;
var const localized string ArbitrationMessage;
var const localized string OvertimeMessage;
var const localized string GlobalNameChange;
var const localized string NewTeamMessage;
var const localized string NewTeamMessageTrailer;
var const localized string NoNameChange;
var const localized string VoteStarted;
var const localized string VotePassed;
var const localized string MustHaveStats;
var const localized string CantBeSpectator;
var const localized string CantBePlayer;
var const localized string BecameSpectator;
var const localized string NewPlayerMessage;
var const localized string KickWarning;
var const localized string NewSpecMessage;
var const localized string SpecEnteredMessage;

static function string GetString(optional int Switch, optional bool bPRI1HUD, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject)
{
    switch(Switch)
    {
        // End:0x29
        case 0:
            return default.OvertimeMessage;
            // End:0x2FA
            break;
        // End:0x73
        case 1:
            // End:0x46
            if(RelatedPRI_1 == none)
            {
                return default.NewPlayerMessage;
            }
            return RelatedPRI_1.PlayerName $ default.EnteredMessage;
            // End:0x2FA
            break;
        // End:0xD7
        case 2:
            // End:0x8A
            if(RelatedPRI_1 == none)
            {
                return "";
            }
            return (RelatedPRI_1.OldName @ default.GlobalNameChange) @ RelatedPRI_1.PlayerName;
            // End:0x2FA
            break;
        // End:0x162
        case 3:
            // End:0xEE
            if(RelatedPRI_1 == none)
            {
                return "";
            }
            // End:0x100
            if(OptionalObject == none)
            {
                return "";
            }
            return ((RelatedPRI_1.PlayerName @ default.NewTeamMessage) @ TeamInfo(OptionalObject).GetHumanReadableName()) $ default.NewTeamMessageTrailer;
            // End:0x2FA
            break;
        // End:0x1A6
        case 4:
            // End:0x179
            if(RelatedPRI_1 == none)
            {
                return "";
            }
            return RelatedPRI_1.PlayerName $ default.LeftMessage;
            // End:0x2FA
            break;
        // End:0x1B8
        case 5:
            return default.SwitchLevelMessage;
            // End:0x2FA
            break;
        // End:0x1CA
        case 6:
            return default.FailedTeamMessage;
            // End:0x2FA
            break;
        // End:0x1DC
        case 7:
            return default.MaxedOutMessage;
            // End:0x2FA
            break;
        // End:0x1EE
        case 8:
            return default.NoNameChange;
            // End:0x2FA
            break;
        // End:0x220
        case 9:
            return RelatedPRI_1.PlayerName @ default.VoteStarted;
            // End:0x2FA
            break;
        // End:0x232
        case 10:
            return default.VotePassed;
            // End:0x2FA
            break;
        // End:0x244
        case 11:
            return default.MustHaveStats;
            // End:0x2FA
            break;
        // End:0x256
        case 12:
            return default.CantBeSpectator;
            // End:0x2FA
            break;
        // End:0x268
        case 13:
            return default.CantBePlayer;
            // End:0x2FA
            break;
        // End:0x29A
        case 14:
            return RelatedPRI_1.PlayerName @ default.BecameSpectator;
            // End:0x2FA
            break;
        // End:0x2AC
        case 15:
            return default.KickWarning;
            // End:0x2FA
            break;
        // End:0x2F7
        case 16:
            // End:0x2CA
            if(RelatedPRI_1 == none)
            {
                return default.NewSpecMessage;
            }
            return RelatedPRI_1.PlayerName $ default.SpecEnteredMessage;
            // End:0x2FA
            break;
        // End:0xFFFF
        default:
            break;
    }
    return "";
    //return ReturnValue;    
}

defaultproperties
{
    SwitchLevelMessage="Switching Levels"
    LeftMessage=" left the game."
    FailedTeamMessage="Could not find team for player"
    FailedPlaceMessage="Could not find a starting spot"
    FailedSpawnMessage="Could not spawn player"
    EnteredMessage=" entered the game."
    MaxedOutMessage="Server is already at capacity."
    ArbitrationMessage="The session has already started."
    OvertimeMessage="Score tied at the end of regulation. Sudden Death Overtime!!!"
    GlobalNameChange="changed name to"
    NewTeamMessage="is now on"
    NoNameChange="Name is already in use."
    VoteStarted="started a vote."
    VotePassed="Vote passed."
    MustHaveStats="Must have stats enabled to join this server."
    CantBeSpectator="Sorry, you cannot become a spectator at this time."
    CantBePlayer="Sorry, you cannot become an active player at this time."
    BecameSpectator="became a spectator."
    NewPlayerMessage="A new player entered the game."
    KickWarning="You are about to be kicked for idling!"
    NewSpecMessage="A spectator entered the game/"
    SpecEnteredMessage=" joined as a spectator."
}