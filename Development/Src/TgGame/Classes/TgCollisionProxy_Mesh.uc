class TgCollisionProxy_Mesh extends TgCollisionProxy
    native
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var export editinline MeshComponent m_MeshComponent;

native function SpawnMesh(int AssemblyID);  // Export UTgCollisionProxy_Mesh::execSpawnMesh(FFrame&, void* const)

native function ScaleCollisionMesh(Vector NewScale);  // Export UTgCollisionProxy_Mesh::execScaleCollisionMesh(FFrame&, void* const)

defaultproperties
{}
