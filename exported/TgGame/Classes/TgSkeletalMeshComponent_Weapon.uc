class TgSkeletalMeshComponent_Weapon extends TgSkeletalMeshComponent
    native(Pawns)
    editinlinenew
    hidecategories(Object);

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

// Export UTgSkeletalMeshComponent_Weapon::execCompleteInitialization(FFrame&, void* const)
native function CompleteInitialization();

// Export UTgSkeletalMeshComponent_Weapon::execSetFireDisplayGroup(FFrame&, void* const)
native final function SetFireDisplayGroup(name nmFire);

// Export UTgSkeletalMeshComponent_Weapon::execSetFireLoopDisplayGroup(FFrame&, void* const)
native final function SetFireLoopDisplayGroup(name nmFire, name nmFireLoopTail);

// Export UTgSkeletalMeshComponent_Weapon::execSetCanPlayParticleFlags(FFrame&, void* const)
native final function SetCanPlayParticleFlags(bool bFire, bool bFireLoop, bool bDoNotPlayIfHidden);

// Export UTgSkeletalMeshComponent_Weapon::execSetCanPlaySoundFlags(FFrame&, void* const)
native final function SetCanPlaySoundFlags(bool bFire, bool bFireLoop);

// Export UTgSkeletalMeshComponent_Weapon::execPlayFire(FFrame&, void* const)
native function PlayFire(optional int nEquipSlot = 1, optional int nFireMode);

// Export UTgSkeletalMeshComponent_Weapon::execStopFire(FFrame&, void* const)
native function StopFire(optional bool bForce, optional int nEquipSlot, optional int nFireMode);

// Export UTgSkeletalMeshComponent_Weapon::execIsFireLoopActive(FFrame&, void* const)
native final function bool IsFireLoopActive(optional int nEquipSlot = 1, optional int nFireMode);

// Export UTgSkeletalMeshComponent_Weapon::execIsFireLoopActivated(FFrame&, void* const)
native final function bool IsFireLoopActivated(optional int nEquipSlot = 1);

// Export UTgSkeletalMeshComponent_Weapon::execGetAllFireLoopParticleSystemComponents(FFrame&, void* const)
native final function GetAllFireLoopParticleSystemComponents(out array<editinline ParticleSystemComponent> FireLoopParticles, optional int nEquipSlot = 1, optional int nFireMode);

// Export UTgSkeletalMeshComponent_Weapon::execPlayFireLoop(FFrame&, void* const)
native function PlayFireLoop(optional int nEquipSlot = 1, optional int nFireMode);

// Export UTgSkeletalMeshComponent_Weapon::execStopFireLoop(FFrame&, void* const)
native function StopFireLoop(optional int nEquipSlot = 1, optional int nFireMode);

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