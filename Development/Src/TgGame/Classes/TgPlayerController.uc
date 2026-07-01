class TgPlayerController extends PComPlayerController
    native(Pawns)
    nativereplication
    config(Game)
    hidecategories(Navigation);
    //implements(TgPaladinsController,TgCallbackInterface,TgSoundNotifyActorInterface);



enum EPlayerInputType
{
    PIT_MoveForward,
    PIT_MoveBackward,
    PIT_MoveRight,
    PIT_MoveLeft,
    PIT_LookLeft,
    PIT_LookRight,
    PIT_LookUp,
    PIT_LookDown,
    PIT_Auto,
    PIT_Alt,
    PIT_BattleAbility,
    PIT_MovementAbility,
    PIT_Ultimate,
    PIT_Reload,
    PIT_Jump,
    PIT_Mount,
    PIT_LoadoutMenu,
    PIT_BurnCardMenu,
    PIT_Emote,
    PIT_Spray,
    //PIT_MAX
};


var int s_nPlayerId;
var QWord s_qwNetAccessFlags;
var transient TgRepInfo_Player CachedPRI;
var float r_fServerTimeStamp;

var transient int m_nKillCamTargetId;
var transient int m_nKillCamTargetBackupId;

var bool bForcedTimelapseRequested;
var bool bForcedPlayOfGameRequested;

var int m_nVoicePackId;

var() editinline TgControlModule ControlModule;

// Export UTgPlayerController::execSetInputAllowed(FFrame&, void* const)
native exec function SetInputAllowed(TgPlayerController.EPlayerInputType InputType, bool bEnabled);

// Export UTgPlayerController::execLiveMatchSwitchChampion(FFrame&, void* const)
native function LiveMatchSwitchChampion(int BotId, int BodySkinId, int WeaponSkinId);

// Export UTgPlayerController::execCanPlayKillCam(FFrame&, void* const)
native function bool CanPlayKillCam(bool bPlayOfGame);

// Export UTgPlayerController::execSwitchChampion(FFrame&, void* const)
native function SwitchChampion(int BotId, int BodySkinId, int WeaponSkinId, int VoicePackId);

// Export UTgPlayerController::execSetPlayerProfile(FFrame&, void* const)
native function SetPlayerProfile(int nProfileId, int nSkinId, int nWeaponSkinId, int nHeadSkinId, optional int nVoicePackId = 0);

// Export UTgPlayerController::execGetDeviceIdByName(FFrame&, void* const)
native function int GetDeviceIdByName(string sDeviceName);

// Export UTgPlayerController::execGetTaskForceNumber(FFrame&, void* const)
native function int GetTaskForceNumber();

// Export UTgPlayerController::execSpectateGM(FFrame&, void* const)
native exec function SpectateGM(string sPlayerName, optional string sSpectatePassword);

// Export UTgPlayerController::execSpectate(FFrame&, void* const)
native exec function Spectate(string sPlayerName, optional string sSpectatePassword);

// Export UTgPlayerController::execSpectateStop(FFrame&, void* const)
native exec function SpectateStop();

// Export UTgPlayerController::execSpectateDamage(FFrame&, void* const)
native exec function SpectateDamage(bool bShow);

// Export UTgPlayerController::execSpectateHeals(FFrame&, void* const)
native exec function SpectateHeals(bool bShow);

// Export UTgPlayerController::execSpectateCrits(FFrame&, void* const)
native exec function SpectateCrits(bool bShow);

// Export UTgPlayerController::execSpectateGold(FFrame&, void* const)
native exec function SpectateGold(bool bShow);

// Export UTgPlayerController::execSpectateXP(FFrame&, void* const)
native exec function SpectateXP(bool bShow);

// Export UTgPlayerController::execSpectateOutlines(FFrame&, void* const)
native exec function SpectateOutlines(bool bShow);

// Export UTgPlayerController::execToggleCombatInfo(FFrame&, void* const)
native exec function ToggleCombatInfo();

// Export UTgPlayerController::execSendCombatMessage(FFrame&, void* const)
native function SendCombatMessage(CombatMessageInfo msgInfo);

event InitInputSystem(){}

reliable client native simulated function ClientDebugPlayPotg();

function SetCredits(int nCreditsAmount) {}

unreliable client simulated function ClientPlaySound(SoundCue ASound){}

unreliable client simulated function ClientPlaySoundBase(AkBaseSoundObject ASound){}

function LiveRespawn(bool bResetHealth, bool bResetDevices){}

event SetNoSmoothedMovementCorrection(bool bNoSmoothedCorrections, optional bool bManaged = false){}

reliable client simulated event UpdateReviveTimeRemaining(float fTimeRemaining){}

reliable client simulated event ClientSetRotationAndDesired(Rotator NewRotation, optional bool bResetCamera){}

exec function SetReadyToPlay(){}
function AcknowledgePossession(Pawn P){}
reliable server function ServerAcknowledgePossession(Pawn P){}
event Possess(Pawn aPawn, bool bVehicleTransition){}
event UnPossess(){}

exec function SwitchCamera(string sCamera){}
exec function GoSpectate(){}

// Export UTgPlayerController::execClientDebugPlayPotg(FFrame&, void* const)
//reliable client native simulated function ClientDebugPlayPotg();





















// KILLCAMS

function SetKillCamTarget(TgPawn KillCamTarget){}
reliable client simulated function ClientSetKillCamTarget(int KillCamTargetId, int BackupKillCamTargetId){}
function ForceKillCamViewTargetChange(optional Actor ForceTarget){}

// Export UTgPlayerController::execGetBestKillCamTarget(FFrame&, void* const)
native final function Actor GetBestKillCamTarget();

// Export UTgPlayerController::execStartTimelapsePlayback(FFrame&, void* const)
native function StartTimelapsePlayback(float BeginTimeOffset, float EndTimeOffset, optional bool bPlayOfGame);

exec function StartTimelapse(optional float Begin = -5.0000000, optional float End = 2.0000000, optional bool bPlayOfGame = false, optional bool bForced = true){}
event ControllerPreTimeLapse(){}



defaultproperties
{
    CheatClass=Class'TgBattleCheatManager'
}


