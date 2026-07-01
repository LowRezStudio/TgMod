class TgRepInfo_Game extends GameReplicationInfo
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var bool r_bKillCamEnabled;
var bool r_bAttackersKillCamEnabled;
var bool r_bDefendersKillCamEnabled;
var bool r_bBlockKillCam;
var repnotify TgRepInfo_TaskForce r_AttackingTaskForce;
var repnotify TgRepInfo_TaskForce r_CapturingTaskForce;
var int r_nPlayOfTheGamePawnId;

// Export UTgRepInfo_Game::execGetTaskForce(FFrame&, void* const)
native function TgRepInfo_TaskForce GetTaskForce(int nTaskForceNum, optional bool bCreate = false);

// Export UTgRepInfo_Game::execGetAttackingTaskForce(FFrame&, void* const)
native final function TgRepInfo_TaskForce GetAttackingTaskForce();

// Export UTgRepInfo_Game::execGetDefendingTaskForce(FFrame&, void* const)
native final function TgRepInfo_TaskForce GetDefendingTaskForce();

simulated function UpdateAttackingTaskforce(TgRepInfo_TaskForce NewAttackingTaskForce){}