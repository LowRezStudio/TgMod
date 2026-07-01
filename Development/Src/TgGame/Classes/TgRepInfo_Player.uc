class TgRepInfo_Player extends PlayerReplicationInfo
    native(Game)
    nativereplication
    hidecategories(Navigation,Movement,Collision);

var int r_nPlayerId;
var int r_nPawnId;
var repnotify TgRepInfo_TaskForce r_TaskForce;
var TgTeamPlayerStart r_SpawnPoint;

var int r_nMountSkinId;
var int r_nEquippedTitleId;
var repnotify int r_nVoicePackId;

var bool r_bIsVolumeStealthed;
var repnotify int r_nProfileId;

// Export UTgRepInfo_Player::execUpdateBroadcastedItems(FFrame&, void* const)
native function UpdateBroadcastedItems(TgInventoryManager InvMgr);
// Export UTgRepInfo_Player::execSetTaskForceNumber(FFrame&, void* const)
native function bool SetTaskForceNumber(byte nTaskForce, optional bool bForce = false);
// Export UTgRepInfo_Player::execUpdateSpectatorUI(FFrame&, void* const)
native function UpdateSpectatorUI();
// Export UTgRepInfo_Player::execSetTeam(FFrame&, void* const)
native function SetTeam(TgRepInfo_TaskForce pNewTeamRep);

simulated function ClientInitialize(Controller C){}
event UpdateIdAndProfile(){}
event UpdateHealth(int nCurrentHealth, int nMaxHealth){}