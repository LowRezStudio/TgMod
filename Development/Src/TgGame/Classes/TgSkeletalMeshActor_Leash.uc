class TgSkeletalMeshActor_Leash extends TgSkeletalMeshActorSpawnable
    native(Pawns)
    hidecategories(Navigation)
    config(Engine);

var export editinline SkeletalMeshComponent m_StartMesh;
var name m_StartBoneName;
var export editinline SkeletalMeshComponent m_EndMesh;
var name m_EndBoneName;
var SkelControlSingleBone m_StartControl;
var SkelControlSingleBone m_EndControl;

defaultproperties
{}
