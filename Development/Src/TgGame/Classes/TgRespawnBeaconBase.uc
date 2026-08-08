class TgRespawnBeaconBase extends TgDestructible
    abstract
    native
    hidecategories(Navigation,SkeletalMeshActor)
    config(Engine);

var () const editconst int m_nMeshAssemblyId;
var export editinline transient MeshComponent m_ActualMeshComponent;
var transient array<TgAnimBlendByTeleportBeacon> m_BeaconNodes;
var transient bool c_bEnemyMatLoaded;
var const bool m_bShouldShowSilhouetteToFriends;
var (BeaconExit) float m_fDeployTime;

native function ForceRecalculateMaterial();  // Export UTgRespawnBeaconBase::execForceRecalculateMaterial(FFrame&, void* const)

native function RecalculateMaterial(bool bIsFriendlyWithLocalPawn, optional bool bForce);  // Export UTgRespawnBeaconBase::execRecalculateMaterial(FFrame&, void* const)

simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp) { }

simulated function NotifyLocalPlayerTeamReceived() { }

defaultproperties
{}
