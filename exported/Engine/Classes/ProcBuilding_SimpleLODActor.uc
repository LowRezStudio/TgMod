class ProcBuilding_SimpleLODActor extends StaticMeshActor
    native(ProcBuilding)
    placeable
    hidecategories(Navigation);

defaultproperties
{
    // Reference: StaticMeshComponent'Engine.Default__ProcBuilding_SimpleLODActor.StaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'StaticMeshComponent0'
    // Archetype: StaticMeshComponent'Engine.Default__StaticMeshActor.StaticMeshComponent0'
    begin object name="StaticMeshComponent0"
        ReplacementPrimitive=none
        bDisableAllRigidBody=true
    end object
    StaticMeshComponent=StaticMeshComponent0
    // Reference: TgSilhouetteComponent'Engine.Default__ProcBuilding_SimpleLODActor.MySilhouette'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MySilhouette'
    // Archetype: TgSilhouetteComponent'Engine.Default__StaticMeshActor.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=StaticMeshComponent'Engine.Default__ProcBuilding_SimpleLODActor.StaticMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    Components[0]=StaticMeshComponent0
    Components[1]=MySilhouette
    bCollideActors=false
    bBlockActors=false
    CollisionComponent=StaticMeshComponent0
}