class TgSkeletalMeshActor_DestructibleTowerChunk extends TgSkeletalMeshActorSpawnable
    hidecategories(Navigation)
    config(Engine);

var export editinline TgSkeletalMeshComponent TgSkeletalMeshComp;

simulated function PlayDestruction(int MeshId, TgPawn_Tower OwningTower) { }

event bool PlayParticleEffect(const AnimNotify_PlayParticleEffect AnimNotifyData) { }

defaultproperties
{}
