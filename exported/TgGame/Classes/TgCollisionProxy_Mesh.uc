class TgCollisionProxy_Mesh extends TgCollisionProxy
    native
    notplaceable
    hidecategories(Navigation);

var export editinline MeshComponent m_MeshComponent;

// Export UTgCollisionProxy_Mesh::execSpawnMesh(FFrame&, void* const)
native function SpawnMesh(int AssemblyID);

// Export UTgCollisionProxy_Mesh::execScaleCollisionMesh(FFrame&, void* const)
native function ScaleCollisionMesh(Vector NewScale);

defaultproperties
{
    // Reference: CylinderComponent'TgGame.Default__TgCollisionProxy_Mesh.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgCollisionProxy.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    Components[0]=CollisionCylinder
    CollisionComponent=none
}