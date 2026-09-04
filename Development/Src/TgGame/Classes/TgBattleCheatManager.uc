class TgBattleCheatManager extends PComCheatManager within TgPlayerController
    native
    config(Game)
    dependson(TgObject);

var TgDemoRecSpectator_Debug m_DebugCameraController;
var array<PlayerStart> m_DebugPlayerStarts;

native exec function SwitchClass(string godName, optional string skinName, optional string weaponSkinName, optional string headName);  // Export UTgBattleCheatManager::execSwitchClass(FFrame&, void* const)

native exec function SwitchWard(optional string wardSkinName);  // Export UTgBattleCheatManager::execSwitchWard(FFrame&, void* const)

native exec function PurchaseGod(string godName);  // Export UTgBattleCheatManager::execPurchaseGod(FFrame&, void* const)

native exec function JoinMatchQueue(int nQueueId, optional int god1, optional int god2, optional int god3, optional int god4, optional int god5);  // Export UTgBattleCheatManager::execJoinMatchQueue(FFrame&, void* const)

native exec function ListTickableActors(Object.ETickingGroup checkgroup);  // Export UTgBattleCheatManager::execListTickableActors(FFrame&, void* const)

native exec function TestPanningRule(optional string sPanningRule="Headphone");  // Export UTgBattleCheatManager::execTestPanningRule(FFrame&, void* const)

native exec function TestLanguage(string newLangExt);  // Export UTgBattleCheatManager::execTestLanguage(FFrame&, void* const)

native function NativeMaxLevel();  // Export UTgBattleCheatManager::execNativeMaxLevel(FFrame&, void* const)

native function TgPawn SpawnBotByName(string botName, int Taskforce, int nCount, int BotDifficulty, string BehaviorTreeName, int nHeadId);  // Export UTgBattleCheatManager::execSpawnBotByName(FFrame&, void* const)

native function SpawnBotAllSkins(int nBatch);  // Export UTgBattleCheatManager::execSpawnBotAllSkins(FFrame&, void* const)

native exec function ToggleLoadFailureOutput();  // Export UTgBattleCheatManager::execToggleLoadFailureOutput(FFrame&, void* const)

native exec function SpawnDeployable(int dep_id);  // Export UTgBattleCheatManager::execSpawnDeployable(FFrame&, void* const)

native exec function FillEnergy();  // Export UTgBattleCheatManager::execFillEnergy(FFrame&, void* const)

native function SetAILevel(TgAIController_BehaviorGod aic, int nLevel);  // Export UTgBattleCheatManager::execSetAILevel(FFrame&, void* const)

exec function separator() { }

exec function sc(string godName, optional string skinName, optional string weaponSkinName, optional string headName) { }

exec function echo(string inputString) { }

exec function Loc() { }

exec function ServerExec(string FSCommand) { }

exec function SpawnTestBot(string sName, optional string sDeviceName, optional int nFireMode=0, optional int nTaskForce=2, optional int nCount=1) { }

exec function SpawnEmoteTestBot(string sName, optional int nTaskForce=2, optional int nCount=1) { }

exec function stb(string sName, optional string sDeviceName, optional int nFireMode=0, optional int nTaskForce=2, optional int nCount=1) { }

exec function _SpawnBot(string sName, optional int nTaskForce=2, optional int nCount=1) { }

exec function SpawnBot(string sName, optional int nTaskForce=2, optional int nCount=1, optional int BotDifficulty=1, optional string BehaviorTreeName, optional int nHeadId) { }

exec function TestSkinGallery(optional int nGallery=0) { }

exec function MaxLevel() { }

exec function ML() { }

exec function SimNWCondition(int nPktLoss, int nPktLag) { }

function CheatLog(string cheatText, bool bOn) { }

simulated exec function God() { }

simulated exec function energy() { }

simulated exec function Cooldown() { }

simulated exec function ForceToggleMount() { }

exec function MaxPower() { }

exec function HookMeUp() { }

exec function GiveRecommendedItems() { }

exec function SetGroundspeed(float val) { }

exec function SetStealth(bool bOn) { }

exec function ShowMoveErrors() { }

exec function DebugProjectileLagCompensationServer() { }

exec function DebugProjectileLagCompensationClient() { }

exec function _SpawnTemplatePlayer(int nProfileId, optional int nSkinId=0, optional int nWeaponSkinId=0, optional int nHeadSkinId=0) { }

exec function KillAllMinions() { }

function KillAllPawnsHelper(Class<Pawn> PawnClass) { }

exec function KillAllPawnsByClass(string PawnClassName) { }

simulated exec function ToggleDeviceLog(optional TgObject.TG_EQUIP_POINT eqp=0) { }

simulated exec function ToggleCustomPhysics() { }

exec function ToggleAIDebug(optional bool bAttachAIDebugger=false) { }

exec function TestObstacleAvoidance(optional int TestType) { }

exec function RequestRelease() { }

exec function botsgod(optional bool bOn=true) { }

exec function FreezeAI(optional bool bOn=true) { }

exec function botslevel(int nLevel) { }

simulated exec function SpectatorCamera(optional bool bOn=true) { }

exec function ApplyProp(int nPropId, float nValue, optional int nCategory=0) { }

exec function BeTheBoss() { }

exec event ShowFootstepInfo() { }

exec function ToggleAimAssist() { }

exec function SetAimAssistTargetWeightVars(float CurrentTargetBonus, float NotCurrentTargetPenalty, float MinAccuracyBonus, float MaxAccuracyBonus, float MinInaccuracyPenalty, float MaxInaccuracyPenalty, float MaxWeight) { }

exec function ResetAimAssistValues() { }

exec function SetAimAssistValues(float MagnetScaleX, float MagnetScaleY, float FrictionScaleX, float FrictionScaleY, float TrackingScaleX, float TrackingScaleY) { }

exec function SetAimVectorAssistValues(float BoundsScaleX, float BoundsScaleY, float MaxAngleX, float MaxAngleY) { }

exec function AddAimAssistKeyframe(string keyframeType, string KeyframeName, float Distance) { }

exec function ResetAimAssistKeyframes(string keyframeType) { }

exec function RefillAmmo() { }

exec function SetMaxAmmo(int MaxAmmo) { }

exec function ChangeTaskForce(byte nTaskForce) { }

exec function ct(byte nTaskForce) { }

exec function ToggleTaskForce() { }

function RemoveDeviceFromPawnAt(TgPawn TgP, int nEquipPointId) { }

function EquipDeviceOnPawn(TgPawn TgP, int nDeviceId, int nEquipPointId, optional int FireMode=0) { }

exec function TargetEquipDevice(int nDeviceId, int nEquipPointId, optional int FireMode=0) { }

exec function TED(int nDeviceId, int nEquipPointId, optional int FireMode=0) { }

exec function TargetEquipDeviceByName(string sDeviceName, int nEquipPointId, optional int FireMode=1) { }

exec function TEDBN(string sDeviceName, int nEquipPointId, optional int FireMode=1) { }

exec function EquipDeviceByName(string sDeviceName, int nEquipPointId, optional int FireMode=1) { }

exec function EDBN(string sDeviceName, int nEquipPointId, optional int FireMode=1) { }

exec function EquipDevice(int nDeviceId, int nEquipPointId, optional int FireMode=0) { }

exec function ED(int nDeviceId, int nEquipPointId, optional int FireMode=0) { }

exec function UnequipDevice(int nDeviceId) { }

exec function UD(int nDeviceId) { }

exec function RemoveDevice(int nDeviceId) { }

exec function UnequipDeviceAt(int nEquipPointId) { }

exec function RemoveDeviceAt(int nDeviceId) { }

exec function RemoveAllCards() { }

exec function RemoveAllItems() { }

exec function AddGold(int nCurrency) { }

exec function Obama(int nCurrency) { }

exec function SetMeLevel(int nLevel) { }

exec function SL(int nLevel) { }

exec function QuickEndGame(bool bWin) { }

exec function QEG(optional bool bWin=true) { }

exec function SetEnergy(float Value) { }

exec function TestShowInventory() { }

exec function TestStunEffect(float fDuration) { }

exec function TestStun(Controller.EStunType Type) { }

exec function ShowPlayerCircles(bool bEnabled) { }

exec function ToggleSpectatorCamera() { }

exec function InvisMe(bool bInvis) { }

exec function capturePoint() { }

exec function EnemyCapturePoint() { }

exec function ToggleCapturePointOvertime() { }

exec function PickPoint(optional int Index=-1) { }

exec function SetSiegeSpeed(float fSpeed) { }

exec function SetRespawnIncrease(float fIncrease) { }

exec function SetDefenseRespawn(float fDuration) { }

exec function SetAttackRespawn(float fDuration) { }

exec function SetRespawnCap(float fDuration) { }

exec function SetCardCooldownIncrease(float fIncrease) { }

exec function ForceRespawnAll() { }

exec function SetHealth(int Health) { }

exec function SetMana(int mana) { }

exec function DamageHealth(optional int DamageAmount) { }

exec function Heal(optional int HealAmount) { }

exec function DamageTarget(optional int DamageAmount=-1) { }

exec function HealTarget(optional int HealAmount=-1) { }

exec function ShieldTarget(optional int Amount=1000) { }

exec function StopHP5() { }

exec function SkipSetup() { }

exec function ShowProjectileDebug(bool bEnabled) { }

exec function DisableProximity(bool bEnabled) { }

exec function GiveCard(int nDeviceId) { }

exec function ForceLanePusher() { }

exec function EnableScoring() { }

exec function DisableScoring() { }

exec function SetScore(optional int tf1Score=0, optional int tf2Score=0) { }

exec function EndGame() { }

exec function HelpMe() { }

exec function QuickSiege() { }

exec function ReinforceDoors(optional int healthAmt=20000000) { }

exec function ReinforceSiege(optional int healthAmt=20000000) { }

exec function SetGameEnvironmentRule(TgObject.EGameEnvironmentRule Rule) { }

exec function SetGameRespawnRule(TgObject.EGameRespawnRule Rule) { }

exec function SetGameMode(TgObject.EGameMode Mode) { }

exec function SetAirFriction(float frictionAmt) { }

exec function SetFallingFriction(float frictionAmt) { }

exec function SetFlyingFriction(float frictionAmt) { }

exec function TestSpawnPoints(optional float PauseTime=3.0000000) { }

exec function SetInstantFireMeshTrace(bool bEnabled) { }

exec function ToggleWeaponLagPrediction() { }

exec function SetMaximumLagPrediction(float NewMaximum) { }

exec function DumpWeaponPredictionStats() { }

exec function DumpLastServerAims() { }

exec function DumpLastClientAims() { }

exec function SetDamageMultiplier(float NewMult) { }

exec function SetGroundSpeedMultiplier(float NewMult) { }

exec function SetAutoHealingMultiplier(float NewMult) { }

exec function ToggleSiegeEngineRequiresAllies() { }

exec function SetVaultImmuneHealth(float fHealth) { }

exec function SetVisibilityRanges(optional float fNormal=-1.0000000, optional float fInVolume=-1.0000000) { }

exec function ForceRoundSetupEnd() { }

exec function FRSE() { }

exec function LevelAim() { }

exec function Set1p(optional bool bForce1P=true) { }

exec function Set3p(optional bool bForce3P=true) { }

exec function Toggle3p() { }

exec function GainXP(int xpAmount) { }

exec function GainCredits(int creditsAmount) { }

exec function GainTickets(int ticketsAmount) { }

exec function EndRound(optional int nTaskForce=0) { }

exec function OpenSpawnGates() { }

exec function CloseSpawnGates() { }

exec function SetCAPOvertime(float overtimeDuration, optional float overtimeWarning=-1.0000000) { }

exec function PayloadForever() { }

exec function SetAIAccuracy(float DegreeMissed, float MissLikelihood) { }

exec function EnableThreat(bool bEnabled) { }

exec function EnableOcclusion(bool bEnabled) { }

exec function DisplayThreatParams() { }

exec function ShowThreats(bool bEnabled, optional string ChannelName) { }

exec function AllNoah(optional string ChannelName) { }

exec function AllowHeadShots(optional bool bEnable=true) { }

exec function LiveRespawn(optional bool bResetHealth=true, optional bool bResetDevices=true) { }

exec function SetBodyMesh(int nBodyMeshID) { }

exec function SBM(int nBodyMeshID) { }

exec function SetBodyMeshByName() { }

exec function SBMBN() { }

exec function SetHeadMesh(int nHeadMeshID) { }

exec function SHM(int nHeadMeshID) { }

exec function SetHeadMeshByName() { }

exec function SHBN() { }

exec function RemoveHeadMesh() { }

exec function rhm() { }

exec function decapitate() { }

exec function EnableHeadMesh(bool bEnabled) { }

exec function ToggleHeadMesh() { }

exec function TargetSetMeshes(int nBodyMeshID, optional int nHeadMeshID=0) { }

exec function TSM(int nBodyMeshID, optional int nHeadMeshID=0) { }

exec function TargetSetBodyMesh(int nBodyMeshID) { }

exec function TSBM(int nBodyMeshID) { }

exec function TargetSetHeadMesh(int nHeadMeshID) { }

exec function TSHM(int nHeadMeshID) { }

exec function AllowMount(optional bool bEnabled=true) { }

exec function PlayPotG() { }

exec function PlayPotGForAll() { }

exec function ResetPotG() { }

exec function LockPotG(bool bLocked) { }

exec function EnableAI(bool bEnabled) { }

exec function KillProjectiles() { }

exec function ToggleAIDifficultyAdjust() { }

exec function EnableGhostMounting(bool bEnabled) { }

exec function StopFog() { }

exec function ResumeFog() { }

exec function SetFogDistance(int Distance) { }

exec function PlayIntroAnim() { }

exec function SetMountSkin(int nSkinId) { }

exec function toggleDiminishingReturns() { }

defaultproperties
{
    DebugCameraControllerClassName="TgGame.TgDebugCameraController"
}
