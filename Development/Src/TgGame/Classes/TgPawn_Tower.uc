class TgPawn_Tower extends TgPawn_TowerBase
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

var float m_TimeSinceDeath;
var array<MaterialInstanceConstant> m_DestroyedMICs;
var float m_fFadeOutStartTime;
var float m_fFadeOutEndTime;
var Vector r_vInitialRotation;
var bool m_bUseDestruction;
var bool r_bSide0Destroyed;
var bool r_bSide1Destroyed;
var bool r_bSide2Destroyed;
var bool r_bSide3Destroyed;
var repnotify byte r_PlaySide0Destruction;
var repnotify byte r_PlaySide1Destruction;
var repnotify byte r_PlaySide2Destruction;
var repnotify byte r_PlaySide3Destruction;
var int m_nSide0MeshId;
var int m_nSide1MeshId;
var int m_nSide2MeshId;
var int m_nSide3MeshId;
var int m_nSide0Health;
var int m_nSide1Health;
var int m_nSide2Health;
var int m_nSide3Health;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bSide0Destroyed, r_bSide1Destroyed, r_bSide2Destroyed, r_bSide3Destroyed, r_vInitialRotation;
    if((int(Role) == int(ENetRole.ROLE_Authority)) && !bNetInitial) r_PlaySide0Destruction, r_PlaySide1Destruction, r_PlaySide2Destruction, r_PlaySide3Destruction;
}

native function SendAttackAlert();  // Export UTgPawn_Tower::execSendAttackAlert(FFrame&, void* const)

native function SendDeathAlert();  // Export UTgPawn_Tower::execSendDeathAlert(FFrame&, void* const)

native function SendTargetedAlert(TgPawn Target);  // Export UTgPawn_Tower::execSendTargetedAlert(FFrame&, void* const)

native function SwapToBrokenMesh();  // Export UTgPawn_Tower::execSwapToBrokenMesh(FFrame&, void* const)

native function BroadcastDiedToGame();  // Export UTgPawn_Tower::execBroadcastDiedToGame(FFrame&, void* const)

native function int GetMeshOverrideForScript(int MeshId);  // Export UTgPawn_Tower::execGetMeshOverrideForScript(FFrame&, void* const)

simulated function PostBeginPlay() { }

simulated event bool PostPawnSetup() { }

simulated event ReplicatedEvent(name VarName) { }

event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser) { }

simulated function PlaySideDestructionAnim(int SideIndex) { }

simulated function CheckSideDestructionSkelControls(optional int ForceSideIndexHidden=-1) { }

event bool Died(Controller Killer, class<DamageType> DamageType, vector HitLocation) { }

simulated function OnSwapToDestroyedMesh() { }

simulated event PostDemoRewind() { }

state Dying {}

defaultproperties
{}
