class TgFatalityMeshActor extends Actor
    native
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var () int m_nTaskForceId;
var () export editinline TgSkeletalMeshComponent m_Mesh;

native function Initialize(int MeshAssemblyId, int TaskForceId);  // Export UTgFatalityMeshActor::execInitialize(FFrame&, void* const)

defaultproperties
{}
