class TgSkeletalMeshComponent_Weapon extends TgSkeletalMeshComponent
    native(Pawns)
    editinlinenew
    hidecategories(Object)
    config(Engine);

var const name m_nmFire;
var const name m_nmFireLoop;
var const name m_nmFireLoopTailSound;
var bool m_bDoNotPlayFireParticlesIfHidden;
var const bool m_bKillFiringLoopParticlesOnHidden;
var const bool m_bCanPlayFireParticles;
var const bool m_bCanPlayFireLoopParticles;
var const bool m_bCanPlayFireSounds;
var const bool m_bCanPlayFireLoopSounds;
var const int m_nFireLoopActiveBitMask;

native function CompleteInitialization();  // Export UTgSkeletalMeshComponent_Weapon::execCompleteInitialization(FFrame&, void* const)

native function SetFireDisplayGroup(name nmFire);  // Export UTgSkeletalMeshComponent_Weapon::execSetFireDisplayGroup(FFrame&, void* const)

native function SetFireLoopDisplayGroup(name nmFire, name nmFireLoopTail);  // Export UTgSkeletalMeshComponent_Weapon::execSetFireLoopDisplayGroup(FFrame&, void* const)

native function SetCanPlayParticleFlags(bool bFire, bool bFireLoop, bool bDoNotPlayIfHidden);  // Export UTgSkeletalMeshComponent_Weapon::execSetCanPlayParticleFlags(FFrame&, void* const)

native function SetCanPlaySoundFlags(bool bFire, bool bFireLoop);  // Export UTgSkeletalMeshComponent_Weapon::execSetCanPlaySoundFlags(FFrame&, void* const)

native function PlayFire(optional int nEquipSlot=1, optional int nFireMode);  // Export UTgSkeletalMeshComponent_Weapon::execPlayFire(FFrame&, void* const)

native function StopFire(optional bool bForce, optional int nEquipSlot, optional int nFireMode);  // Export UTgSkeletalMeshComponent_Weapon::execStopFire(FFrame&, void* const)

native function bool IsFireLoopActive(optional int nEquipSlot=1, optional int nFireMode);  // Export UTgSkeletalMeshComponent_Weapon::execIsFireLoopActive(FFrame&, void* const)

native function bool IsFireLoopActivated(optional int nEquipSlot=1);  // Export UTgSkeletalMeshComponent_Weapon::execIsFireLoopActivated(FFrame&, void* const)

native function GetAllFireLoopParticleSystemComponents(out array<ParticleSystemComponent> FireLoopParticles, optional int nEquipSlot=1, optional int nFireMode);  // Export UTgSkeletalMeshComponent_Weapon::execGetAllFireLoopParticleSystemComponents(FFrame&, void* const)

native function PlayFireLoop(optional int nEquipSlot=1, optional int nFireMode);  // Export UTgSkeletalMeshComponent_Weapon::execPlayFireLoop(FFrame&, void* const)

native function StopFireLoop(optional int nEquipSlot=1, optional int nFireMode);  // Export UTgSkeletalMeshComponent_Weapon::execStopFireLoop(FFrame&, void* const)

defaultproperties
{
    m_nmFire="Fire"
    m_nmFireLoop="FireLoop"
    m_nmFireLoopTailSound="FireLoopTailSound"
    m_bDoNotPlayFireParticlesIfHidden=true
    m_bCanPlayFireParticles=true
    m_bCanPlayFireLoopParticles=true
    LowUpdateFrameRate=0
    AnimationLODFrameRate=0
    bUseTickOptimization=false
    ReplacementPrimitive=none
}
