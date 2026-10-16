class TgStaticMeshActorTargeting extends StaticMeshActor
    native(Pawns)
    hidecategories(Navigation);

defaultproperties
{
    // Reference: StaticMeshComponent'TgGame.Default__TgStaticMeshActorTargeting.StaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'StaticMeshComponent0'
    // Archetype: StaticMeshComponent'Engine.Default__StaticMeshActor.StaticMeshComponent0'
    begin object name="StaticMeshComponent0"
        ReplacementPrimitive=none
        bAllowApproximateOcclusion=false
        bForceDirectLightMap=false
        bUsePrecomputedShadows=false
        BlockZeroExtent=false
    end object
    StaticMeshComponent=StaticMeshComponent0
    // Reference: TgSilhouetteComponent'TgGame.Default__TgStaticMeshActorTargeting.MySilhouette'
    // Archetype: TgSilhouetteComponent'Engine.Default__StaticMeshActor.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=StaticMeshComponent'TgGame.Default__TgStaticMeshActorTargeting.StaticMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    Components[0]=StaticMeshComponent0
    Components[1]=MySilhouette
    bStatic=false
    bHidden=true
    bTickIsDisabled=true
    bWorldGeometry=false
    bBlockActors=false
    CollisionComponent=StaticMeshComponent0
}